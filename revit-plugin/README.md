# Revit Plugin (C#)

Каркас плагина для панели «План–Факт»:
- MVVM, DockablePane, ExternalEvent.
- Параметры `TOUCH_*` (Instance).
- Экспорт в MSSQL (Dapper/SqlClient), батчи и upsert.
- Устойчивый `ElementGuid` = GUIDv5(DocumentGUID, Element.UniqueId).

## Стартовые шаги
1. Создайте решение Visual Studio (.NET Framework 4.8).
2. Подключите RevitAPI.dll / RevitServices.
3. Добавьте проекты: `Plugin`, `Plugin.Tests`.
4. Реализуйте команды: `MarkStart`, `MarkFinish`, `ExportToSql`.
