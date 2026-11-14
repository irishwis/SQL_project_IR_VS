-- 00_raw_schema.sql
-- Слой raw: исходные файлы Berka «как есть», все поля текстом.
-- Это не наша модель, а промежуточная зона загрузки (staging).
-- Из неё на следующих шагах переносим данные в нормализованную схему.

DROP SCHEMA IF EXISTS raw CASCADE;
CREATE SCHEMA raw;

-- Счета
CREATE TABLE raw.account (
    account_id  text,
    district_id text,
    frequency   text,   -- периодичность выписок (POPLATEK MESICNE и т.п.)
    date        text    -- YYMMDD
);

-- Клиенты
CREATE TABLE raw.client (
    client_id    text,
    birth_number text,  -- YYMMDD, у женщин к месяцу прибавлено 50
    district_id  text
);

-- Права клиента на счёт (OWNER / DISPONENT)
CREATE TABLE raw.disp (
    disp_id    text,
    client_id  text,
    account_id text,
    type       text
);

-- Постоянные платёжные поручения
CREATE TABLE raw."order" (
    order_id   text,
    account_id text,
    bank_to    text,
    account_to text,
    amount     text,
    k_symbol   text    -- назначение платежа
);

-- Транзакции (~1,06 млн строк)
CREATE TABLE raw.trans (
    trans_id   text,
    account_id text,
    date       text,   -- YYMMDD
    type       text,   -- PRIJEM приход / VYDAJ расход / VYBER снятие
    operation  text,
    amount     text,
    balance    text,
    k_symbol   text,
    bank       text,
    account    text
);

-- Кредиты
CREATE TABLE raw.loan (
    loan_id    text,
    account_id text,
    date       text,
    amount     text,
    duration   text,   -- срок в месяцах
    payments   text,   -- ежемесячный платёж
    status     text    -- A..D
);

-- Карты
CREATE TABLE raw.card (
    card_id text,
    disp_id text,
    type    text,      -- junior / classic / gold
    issued  text       -- 'YYMMDD 00:00:00'
);

-- Районы с демографией (A1..A16, смысл колонок — в README / описании датасета)
CREATE TABLE raw.district (
    a1 text, a2 text, a3 text, a4 text, a5 text, a6 text, a7 text, a8 text,
    a9 text, a10 text, a11 text, a12 text, a13 text, a14 text, a15 text, a16 text
);
