CREATE DATABASE bank_loan_analytics;
USE bank_loan_analytics;

select count(id) from finance_1;
select count(id) from finance_2;

select * from finance_1;
select * from finance_2;

-- KPI 
-- total loans 
select count(id) from finance_1;

-- loan amount 
select sum(loan_amnt) from finance_1;

-- interest rate 
select avg(int_rate) from finance_1;

-- revolove balance
select sum(revol_bal) from finance_2;

-- average loan amount  
select avg(loan_amnt) from finance_1;

-- average dti 
select avg(dti) from finance_1;

-- check date format

SELECT issue_d
FROM finance_1
LIMIT 10;

-- Q1 Year wise loan amount 

SELECT
    YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS loan_year,
    SUM(loan_amnt) AS total_loan_amount
FROM finance_1
GROUP BY loan_year
ORDER BY loan_year;


SELECT
    YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS loan_year,
    COUNT(id) AS total_loans,
    SUM(loan_amnt) AS total_loan_amount,
    AVG(loan_amnt) AS average_loan_amount
FROM finance_1
GROUP BY loan_year
ORDER BY loan_year;

-- Q2 Grade & sub grade wise revolving balance

SELECT
    f1.grade,
    f1.sub_grade,
    SUM(f2.revol_bal) AS total_revol_bal
FROM finance_1 f1
JOIN finance_2 f2
    ON f1.id = f2.id
GROUP BY
    f1.grade,
    f1.sub_grade
ORDER BY
    f1.grade,
    f1.sub_grade;

-- Q3 total payments verified vs non-verified

SELECT DISTINCT verification_status
FROM finance_1;


SELECT
    f1.verification_status,
    SUM(f2.total_pymnt) AS total_payment
FROM finance_1 f1
JOIN finance_2 f2
    ON f1.id = f2.id
WHERE f1.verification_status IN
      ('Verified', 'Not Verified')
GROUP BY f1.verification_status;

-- Q4 state wise & month wise loan status
-- check states
SELECT DISTINCT addr_state
FROM finance_1
ORDER BY addr_state;

-- check loan status
SELECT DISTINCT loan_status
FROM finance_1;

-- check issue date
SELECT issue_d
FROM finance_1
LIMIT 10;

-- state wise loan 
SELECT
    addr_state,
    loan_status,
    COUNT(id) AS total_loans
FROM finance_1
GROUP BY
    addr_state,
    loan_status
ORDER BY
    addr_state,
    total_loans DESC;

-- month wise loan 
SELECT
    MONTH(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS loan_month,
    loan_status,
    COUNT(id) AS total_loans
FROM finance_1
GROUP BY
    loan_month,
    loan_status
ORDER BY
    loan_month;
    
-- Q5 Home ownership vs Last payment date
-- check home ownership 
SELECT DISTINCT home_ownership
FROM finance_1;

-- check last payment date
SELECT last_pymnt_d
FROM finance_2
LIMIT 10;

SELECT
    f1.home_ownership,
    STR_TO_DATE(f2.last_pymnt_d, '%d-%m-%Y') AS last_payment_date,
    COUNT(f1.id) AS total_loans,
    SUM(f2.total_pymnt) AS total_payment
FROM finance_1 f1
JOIN finance_2 f2
    ON f1.id = f2.id
WHERE f2.last_pymnt_d IS NOT NULL
GROUP BY
    f1.home_ownership,
    last_payment_date
ORDER BY
    last_payment_date;
    
    
    
    SELECT
    f1.home_ownership,
    YEAR(STR_TO_DATE(f2.last_pymnt_d, '%d-%m-%Y')) AS payment_year,
    COUNT(f1.id) AS total_loans,
    SUM(f2.total_pymnt) AS total_payment
FROM finance_1 f1
JOIN finance_2 f2
    ON f1.id = f2.id
WHERE f2.last_pymnt_d IS NOT NULL
GROUP BY
    f1.home_ownership,
    payment_year
ORDER BY
    payment_year,
    f1.home_ownership;
    
    
    
