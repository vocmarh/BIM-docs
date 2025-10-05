<!-- docs/DoD.md -->
# Definition of Done (DoD) и тесты

## Фаза 0 — DoD
- GitHub Actions запускает build + тесты.
- Миграции ставятся на чистую MSSQL (Docker).

**Тесты:** Acceptance.Phase0.* — зелёные.

## Фаза 1 — DoD
- В БД созданы таблицы для элементов/EAV.
- Нет дубликатов колонок, типы параметров сохранены.

**Тесты:** Core.*, Infra.Sql.*, Acceptance.Phase1.* — зелёные.

## Фаза 2 — DoD
- ГПР версии не затираются, актуальная помечена.
- Мэтчинг по ClassifierCode устойчив к дублям/пропускам.
- Dry-run формирует отчёт; запись меняет только нужные параметры.

**Тесты:** Infra.Excel.*, Infra.Sql.*, Core.*, Acceptance.Phase2.* — зелёные.

## Фаза 2.1 — DoD
- CSV/XLSX → dry-run и запись параметров (без БД).

**Тесты:** Acceptance.Phase2_1.* — зелёные.
