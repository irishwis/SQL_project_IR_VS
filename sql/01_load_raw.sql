-- 01_load_raw.sql
-- Загрузка файлов Berka в слой raw.
-- Запускать через psql ИЗ КОРНЯ репозитория (пути относительные):
--   psql -U postgres -d bank -f sql/01_load_raw.sql
-- Формат файлов: разделитель ';', текст в двойных кавычках, 1 строка заголовка.

\copy raw.account  FROM 'data/raw/account.asc'  WITH (FORMAT csv, DELIMITER ';', HEADER true)
\copy raw.client   FROM 'data/raw/client.asc'   WITH (FORMAT csv, DELIMITER ';', HEADER true)
\copy raw.disp     FROM 'data/raw/disp.asc'     WITH (FORMAT csv, DELIMITER ';', HEADER true)
\copy raw."order"  FROM 'data/raw/order.asc'    WITH (FORMAT csv, DELIMITER ';', HEADER true)
\copy raw.trans    FROM 'data/raw/trans.asc'    WITH (FORMAT csv, DELIMITER ';', HEADER true)
\copy raw.loan     FROM 'data/raw/loan.asc'     WITH (FORMAT csv, DELIMITER ';', HEADER true)
\copy raw.card     FROM 'data/raw/card.asc'     WITH (FORMAT csv, DELIMITER ';', HEADER true)
\copy raw.district FROM 'data/raw/district.asc' WITH (FORMAT csv, DELIMITER ';', HEADER true)

-- Проверка: сколько строк загрузилось (ожидаемое число — в комментарии)
SELECT 'account'  AS tbl, count(*) FROM raw.account   -- 4 500
UNION ALL SELECT 'client',   count(*) FROM raw.client    -- 5 369
UNION ALL SELECT 'disp',     count(*) FROM raw.disp      -- 5 369
UNION ALL SELECT 'order',    count(*) FROM raw."order"   -- 6 471
UNION ALL SELECT 'trans',    count(*) FROM raw.trans     -- 1 056 320
UNION ALL SELECT 'loan',     count(*) FROM raw.loan      -- 682
UNION ALL SELECT 'card',     count(*) FROM raw.card      -- 892
UNION ALL SELECT 'district', count(*) FROM raw.district; -- 77
