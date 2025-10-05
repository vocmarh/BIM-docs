<!-- docs/PLAN.md -->
# План по фазам (0–2, 2.1)

## Фаза 0. Инфраструктура и каркас
- Repo-скелет, тестовая БД (Docker), DbUp миграции.
- CI (GitHub Actions): сборка + тесты.

## Фаза 1. Экспорт Revit → MSSQL
- BulkInsert, авто-уникализация колонок, StorageType.

## Фаза 2. ГПР → БД → запись дат в параметры
- Парсинг Excel/CSV (MS Project), версионирование ГПР, мэппинг по ClassifierCode.

## Фаза 2.1. Упрощёнка без БД
- Excel/CSV → сразу в Revit (dry-run + запись).
