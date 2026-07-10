CREATE DATABASE IF NOT EXISTS crm_sales_opportunities;
USE crm_sales_opportunities;

DROP TABLE IF EXISTS sales_pipeline;
DROP TABLE IF EXISTS sales_teams;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS data_dictionary;

CREATE TABLE accounts (
    account VARCHAR(100) PRIMARY KEY,
    sector VARCHAR(50) NOT NULL,
    year_established INT NOT NULL,
    revenue DECIMAL(12, 2) NOT NULL,
    employees INT NOT NULL,
    office_location VARCHAR(100) NOT NULL,
    subsidiary_of VARCHAR(100)
);

CREATE TABLE products (
    product VARCHAR(100) PRIMARY KEY,
    series VARCHAR(50) NOT NULL,
    sales_price DECIMAL(12, 2) NOT NULL
);

CREATE TABLE sales_teams (
    sales_agent VARCHAR(100) PRIMARY KEY,
    manager VARCHAR(100) NOT NULL,
    regional_office VARCHAR(50) NOT NULL
);

CREATE TABLE sales_pipeline (
    opportunity_id VARCHAR(20) PRIMARY KEY,
    sales_agent VARCHAR(100) NOT NULL,
    product VARCHAR(100) NOT NULL,
    account VARCHAR(100),
    deal_stage VARCHAR(30) NOT NULL,
    engage_date DATE,
    close_date DATE,
    close_value DECIMAL(12, 2)
);

CREATE TABLE data_dictionary (
    source_table VARCHAR(50) NOT NULL,
    field_name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL
);

LOAD DATA LOCAL INFILE '/Users/tuankhangnguyen/Downloads/CRM+Sales+Opportunities/accounts.csv'
INTO TABLE accounts
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(account, sector, @year_established, @revenue, @employees, office_location, @subsidiary_of)
SET
    year_established = CAST(NULLIF(@year_established, '') AS UNSIGNED),
    revenue = CAST(NULLIF(@revenue, '') AS DECIMAL(12, 2)),
    employees = CAST(NULLIF(@employees, '') AS UNSIGNED),
    subsidiary_of = NULLIF(TRIM(TRAILING '\r' FROM @subsidiary_of), '');

LOAD DATA LOCAL INFILE '/Users/tuankhangnguyen/Downloads/CRM+Sales+Opportunities/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product, series, @sales_price)
SET
    sales_price = CAST(NULLIF(TRIM(TRAILING '\r' FROM @sales_price), '') AS DECIMAL(12, 2));

LOAD DATA LOCAL INFILE '/Users/tuankhangnguyen/Downloads/CRM+Sales+Opportunities/sales_teams.csv'
INTO TABLE sales_teams
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(sales_agent, manager, @regional_office)
SET
    regional_office = TRIM(TRAILING '\r' FROM @regional_office);

LOAD DATA LOCAL INFILE '/Users/tuankhangnguyen/Downloads/CRM+Sales+Opportunities/sales_pipeline.csv'
INTO TABLE sales_pipeline
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(opportunity_id, sales_agent, product, @account, deal_stage, @engage_date, @close_date, @close_value)
SET
    account = NULLIF(@account, ''),
    engage_date = NULLIF(@engage_date, ''),
    close_date = NULLIF(@close_date, ''),
    close_value = CAST(NULLIF(TRIM(TRAILING '\r' FROM @close_value), '') AS DECIMAL(12, 2));

LOAD DATA LOCAL INFILE '/Users/tuankhangnguyen/Downloads/CRM+Sales+Opportunities/data_dictionary.csv'
INTO TABLE data_dictionary
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(source_table, field_name, @description)
SET
    description = TRIM(TRAILING '\r' FROM @description);

SELECT 'accounts' AS table_name, COUNT(*) AS row_count FROM accounts
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sales_teams', COUNT(*) FROM sales_teams
UNION ALL
SELECT 'sales_pipeline', COUNT(*) FROM sales_pipeline
UNION ALL
SELECT 'data_dictionary', COUNT(*) FROM data_dictionary;

-- /usr/local/mysql/bin/mysql -u root -p check whether it is imported.

/*
Enter your password, then inside MySQL run: 
    USE crm_sales_opportunities;
    SHOW TABLES;
*/

/*
LOAD DATA LOCAL INFILE '/Users/tuankhangnguyen/Downloads/CRM+Sales+Opportunities/sales_pipeline.csv'   -- first load the data
INTO TABLE sales_pipeline                                                                              -- Into what table
FIELDS TERMINATED BY ',' ENCLOSED BY '"'                                                               -- Separated by commas
LINES TERMINATED BY '\n'                                                                               -- if it has multiple values(new line)           
IGNORE 1 ROWS                                                                                          -- skip the header
(opportunity_id, sales_agent, product, @account, deal_stage, @engage_date, @close_date, @close_value)  -- column names
SET
    account = NULLIF(@account, ''),                                                                    -- blank -> null, same for others.
    engage_date = NULLIF(@engage_date, ''),
    close_date = NULLIF(@close_date, ''),
    close_value = CAST(NULLIF(TRIM(TRAILING '\r' FROM @close_value), '') AS DECIMAL(12, 2));

*/