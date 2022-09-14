USE bank;

SELECT * FROM bank.account;
SELECT * FROM bank.card;
SELECT * FROM bank.disp;

SELECT * FROM bank.order
WHERE amount > 10000;

SELECT * FROM bank.order
WHERE k_symbol = 'SIPO';

SELECT account_id, amount, k_symbol FROM bank.order
WHERE k_symbol = 'SIPO';

SELECT account_id AS 'Account', amount, k_symbol AS 'Type of Payment' FROM bank.order
WHERE (k_symbol = 'SIPO') AND (amount > 1000); 

SELECT account_id AS 'Account', amount, k_symbol AS 'Type of Payment' FROM bank.order
WHERE (k_symbol IN ('SIPO','LEASING','UVER')) AND (amount > 1000); 

SELECT account_id AS 'Account', amount, k_symbol AS 'Type of Payment' FROM bank.order
WHERE (k_symbol = 'SIPO') AND NOT (amount > 1000); 

-- numerics

SELECT * FROM bank.loan;

SELECT *, amount-payments AS balance
FROM bank.loan;

SELECT *, amount-payments AS balance, round((amount-payments)/1000,2) AS 'balance in thousands'
FROM bank.loan;

SELECT * FROM bank.account
LIMIT 10;

SELECT * FROM bank.account
ORDER BY account_id DESC
LIMIT 10;

SELECT DISTINCT frequency FROM bank.account;

SELECT * from bank.district;

SELECT A2 AS district_name, A11 AS average_salary 
FROM bank.district
WHERE A11> 10000;

SELECT * 
FROM card
WHERE type = 'junior'
ORDER BY card_id ASC
LIMIT 10;

SELECT loan_id, account_id, (amount-payments) AS debt FROM loan
WHERE status = 'B';

-- 5
select A2 as district_name, round(A4*A10/100) as urban_population
from bank.district;

-- 6 
select A2 as district_name, round(A4*A10/100) as urban_population
from bank.district
where A10>50;


-- numeric aggregates
SELECT COUNT(*) FROM bank.order;
SELECT COUNT(account_id) FROM bank.order;

SELECT COUNT(DISTINCT account_id) FROM bank.order;

SELECT AVG(amount) FROM bank.order;
SELECT MAX(amount) FROM bank.order;
SELECT MIN(amount) FROM bank.order;

-- strings

SELECT * FROM bank.order;

SELECT *, concat(order_id,account_id) AS 'concat' FROM bank.order;

SELECT *, concat(order_id,account_id,' ',bank_to) AS 'concat' FROM bank.order;

SELECT k_symbol, left(k_symbol,3), right(k_symbol,2) , concat(left(k_symbol,2),right(k_symbol,2)) AS 'standardized_k_symbol' FROM bank.order;


-- case when

SELECT * FROM bank.loan;

SELECT loan_id, account_id,
CASE
WHEN status = 'B' then 'Defaulter - contract finished'
WHEN status = 'A' then 'Good - contract finished'
WHEN status = 'C' then 'Good - contract ongoing'
WHEN status = 'D' then 'In Debt - contract ongoing'
ELSE 'No status'
END AS 'Status Description',status AS 'previous status'
FROM bank.loan;


SELECT loan_id, account_id, amount, status AS 'previous status',
CASE
WHEN status = 'B' then 'Defaulter - contract finished'
WHEN (status = 'A') AND (amount > 100000) then 'Great - contract finished'
WHEN (status = 'A') AND (amount <= 100000) then 'Good - contract finished'
WHEN status = 'C' then 'Good - contract ongoing'
WHEN status = 'D' then 'In Debt - contract ongoing'
ELSE 'No status'
END AS 'Status Description'
FROM bank.loan;

 -- activity 2 solutions
 
 -- 1
select * from bank.card
where issued > 980000 and type = 'junior';

-- 2
select * from bank.trans
where type='VYDAJ' and (operation='VKLAD' or operation='VYBER')
limit 10;

-- 3
select loan_id, account_id, (amount - payments) as debt
from bank.loan
where status = 'B' and (amount - payments) > 1000
order by debt desc;

-- 4
select min(amount) as min_transaction, max(amount) as max_transaction
from bank.trans
where amount > 0;

-- 5
select *, substr(date,1,2) as year from account;

-- datetime

SELECT * FROM bank.account;

SELECT * , CONVERT(date,DATE) FROM bank.account;
SELECT * , CONVERT(date,DATETIME) FROM bank.account;

SELECT * FROM bank.card;

SELECT *,CONVERT(left(issued,6),date) AS 'issued_date' FROM bank.card;

SELECT *, date_format(CONVERT(left(issued,6),date), '%d-%m-%Y') AS 'issued_date' FROM bank.card;

SELECT *, date_format(CONVERT(left(issued,6),date), '%M') AS 'issued_date' FROM bank.card;