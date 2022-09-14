-- Used to write comments
USE bank;
DESCRIBE bank.account;
SELECT * FROM bank.account;
SELECT * FROM bank.card;
SELECT * FROM bank.disp;
SELECT * FROM bank.columns;

SELECT account_id AS 'Account', amount, k_symbol AS 'Type of payment' FROM bank.order
WHERE k_symbol = 'SIPO';

SELECT account_id AS 'Account', amount, k_symbol AS 'Type of payment' FROM bank.order
WHERE k_symbol = 'SIPO' AND amount > 1000;

SELECT account_id AS 'Account', amount, k_symbol AS 'Type of payment' FROM bank.order
WHERE (k_symbol IN ('SIPO' ,'LEASING', 'UVER')) AND (amount > 1000);

SELECT * FROM bank.loan;

SELECT *, amount-payments AS balance;

-- Select districts and salaries (from the district table) where salary is greater than 10000. Return columns as district_name and average_salary.
DESC district;
SELECT * FROM bank.district;

SELECT A3 AS 'District', A11 AS 'Salary' FROM bank.district WHERE A11 > 10000;

-- Select those loans whose contract finished and were not paid. 
-- Hint: You should be looking at the loan column and you will need the extended case study information to tell you which value of status is required.

DESC loan;
SELECT * FROM bank.loan;
SELECT * FROM bank.loan WHERE status = 'B';

-- Select cards of type junior. Return just first 10 in your query.
DESC bank.card;
SELECT * FROM bank.card WHERE type = 'junior'
LIMIT 10;

-- Select those loans whose contract finished and not paid back. Return the debt value from the status you identified in the last activity, together with loan id and account id.
SELECT * FROM bank.loan;
SELECT loan_id, account_id, (amount - payments) AS 'Debt' FROM bank.loan WHERE status = 'B';

-- Calculate the urban population for all districts. 
-- Hint: You are looking for the number of inhabitants and the % of urban inhabitants in each district. Return columns as district_name and urban_population.
SELECT A2 AS 'district_name', ROUND((A4*A10)/100) AS 'urban_population' FROM bank.district;

-- On the previous query result rerun it but filtering out districts where the rural population is greater than 50%.
SELECT A2 AS 'district_name', ROUND((A4*A10)/100) AS 'urban_population' FROM bank.district WHERE A10 <= 50;
SELECT * FROM bank.district;

-- Get all junior cards issued last year. Hint: Use the numeric value (980000).
SELECT * FROM bank.card;
SELECT * FROM bank.card 
WHERE type = 'junior' AND issued >= 980000;

-- Get the first 10 transactions for withdrawals that are not in cash. 
-- You will need the extended case study information to tell you which values are required here, 
-- and you will need to refer to conditions on two columns
SELECT * FROM bank.trans
LIMIT 10;

SELECT * FROM bank.trans 
WHERE operation != 'VYBER' and type = 'VYDAJ' 
ORDER BY date ASC
LIMIT 10;

-- Refine your query from last activity on loans whose contract finished and not paid back.
-- filtered to loans where they were left with a debt bigger than 1000. Return the debt value 
-- together with loan id and account id. Sort by the highest debt value to the lowest.

SELECT * FROM bank.loan;
SELECT loan_id, account_id, (amount - payments) AS 'Debt' FROM bank.loan 
WHERE status = 'B' AND (amount - payments) > 1000
ORDER BY Debt DESC;

-- Get the biggest and the smallest transaction with non-zero values in the database (use the trans table in the bank database).

SELECT MAX(amount), MIN(amount) FROM bank.trans
WHERE amount > 0;

-- Get account information with an extra column year showing the opening year as 'YY'. Eg., 1995 will show as 95.
-- Hint: Look at the first two characters of the string date in the account table. You would have to use function substr. Google is your friend.
SELECT * FROM bank.account
LIMIT 10;

SELECT * FROM bank.card;
SELECT *, CONVERT(issued,DATE) FROM bank.card;

SELECT * FROM bank.trans
LIMIT 10;

SELECT * , CONVERT(issued,DATETIME) FROM bank.card;

SELECT *, SUBSTR(date, 1,2) AS 'Year', SUBSTR(date, 3,2) AS 'Month', SUBSTR(date, 5,2) AS 'Day' 
FROM bank.trans
WHERE Day <= 15 AND Month = 01 AND Year = 93; 

SELECT * FROM bank.trans;
SELECT * FROM bank.trans
WHERE date BETWEEN 930101 AND 930115;
