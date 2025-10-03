-- MSSQL schema for BIM план–факт

CREATE TABLE dbo.Classificator (
  Id          INT IDENTITY(1,1) PRIMARY KEY,
  Code        NVARCHAR(50) NOT NULL UNIQUE,
  Name        NVARCHAR(255) NOT NULL,
  ParentId    INT NULL,
  Level       TINYINT NULL,
  Unit        NVARCHAR(20) NULL,
  Notes       NVARCHAR(255) NULL,
  CONSTRAINT FK_Classificator_Parent
    FOREIGN KEY (ParentId) REFERENCES dbo.Classificator(Id)
);

CREATE TABLE dbo.Elements (
  ElementGuid   UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
  RevitId       INT NOT NULL,
  Category      NVARCHAR(100) NULL,
  Family        NVARCHAR(120) NULL,
  Type          NVARCHAR(120) NULL,
  Project       NVARCHAR(120) NULL,
  ModelVersion  NVARCHAR(40)  NULL,
  ClassCode     NVARCHAR(50)  NULL,
  Qty           FLOAT         NULL,
  Unit          NVARCHAR(20)  NULL,
  CreatedAt     DATETIME2(3)  NOT NULL DEFAULT SYSUTCDATETIME(),
  UpdatedAt     DATETIME2(3)  NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE INDEX IX_Elements_ClassCode ON dbo.Elements(ClassCode);
CREATE INDEX IX_Elements_Category ON dbo.Elements(Category);

ALTER TABLE dbo.Elements
  ADD CONSTRAINT FK_Elements_Classificator
  FOREIGN KEY (ClassCode) REFERENCES dbo.Classificator(Code);

CREATE TABLE dbo.ScheduleBindings (
  MsProjectTaskUid UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
  ClassCode        NVARCHAR(50) NOT NULL,
  TaskName         NVARCHAR(255) NOT NULL
);
CREATE INDEX IX_ScheduleBindings_ClassCode ON dbo.ScheduleBindings(ClassCode);

CREATE TABLE dbo.PlanFact (
  ElementGuid   UNIQUEIDENTIFIER NOT NULL,
  SnapshotDate  DATE NOT NULL,
  PlanStart     DATE NULL,
  PlanFinish    DATE NULL,
  ActStart      DATE NULL,
  ActFinish     DATE NULL,
  PRIMARY KEY (ElementGuid, SnapshotDate),
  CONSTRAINT FK_PlanFact_Elements
    FOREIGN KEY (ElementGuid) REFERENCES dbo.Elements(ElementGuid)
);

CREATE TABLE dbo.Snapshots (
  SnapshotDate DATE PRIMARY KEY,
  Source       NVARCHAR(50) NULL,
  Comment      NVARCHAR(255) NULL
);

-- Helpful views (скелеты):
GO
CREATE OR ALTER VIEW dbo.vw_Elements AS
SELECT e.* FROM dbo.Elements e;

GO
CREATE OR ALTER VIEW dbo.vw_PlanFact AS
SELECT pf.* FROM dbo.PlanFact pf;

GO
CREATE OR ALTER VIEW dbo.vw_StatusAgg AS
SELECT
  e.ClassCode,
  CAST(MAX(pf.PlanFinish) AS DATE) AS PlanFinish,
  SUM(CASE WHEN pf.ActFinish IS NOT NULL THEN ISNULL(e.Qty,0) ELSE 0 END) AS FactQty,
  SUM(ISNULL(e.Qty,0)) AS TotalQty
FROM dbo.Elements e
JOIN dbo.PlanFact pf ON pf.ElementGuid = e.ElementGuid
GROUP BY e.ClassCode;
