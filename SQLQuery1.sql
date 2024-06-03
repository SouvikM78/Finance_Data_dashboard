
Use bank_loan;     -- To start using the database   


select * from financial_loan;
select issue_date, id from financial_loan where day(issue_date) = 12;
select count(id) as MTD_Applications from financial_loan where day(issue_date) = 12;

ALTER TABLE financial_loan ADD issue_month varchar(20) NULL 
UPDATE financial_loan SET issue_month = day(issue_date);

Select COUNT(id) as Total_Applications from financial_loan;
Select COUNT(id) as MTD_Applications from financial_loan where issue_month=12;
Select COUNT(id) as PMTD_Applications from financial_loan where issue_month=11;

Select sum(loan_amount) as Total_Loan_Amount from financial_loan;
Select sum(loan_amount) as MTD_Total_Loan_Amount from financial_loan Where issue_month=12;
Select sum(loan_amount) as PMTD_Total_Loan_Amount from financial_loan Where issue_month=11;

Select sum(total_payment) as Total_Amount_Received from financial_loan;
Select sum(total_payment) as MTD_Total_Amount_Received from financial_loan Where issue_month=12;
Select sum(total_payment) as PMTD_Total_Amount_Received from financial_loan Where issue_month=11;

Select AVG(int_rate)*100 as Avg_Int_Rate from financial_loan;
Select Round(AVG(int_rate)*100, 2) as Avg_Int_Rate from financial_loan;
Select Round(AVG(int_rate)*100, 2) as MTD_Avg_Int_Rate from financial_loan Where issue_month=12; --beneficial for bank in later month
Select Round(AVG(int_rate)*100, 2) as PMTD_Avg_Int_Rate from financial_loan Where issue_month=11;

Select AVG(dti)*100 as Avg_Debt_To_Income from financial_loan;
Select Round(AVG(dti)*100, 2) as Avg_Debt_To_Income from financial_loan;
Select Round(AVG(dti)*100, 2) as MTD_Avg_Debt_To_Income from financial_loan Where issue_month=12;
Select Round(AVG(dti)*100, 2) as PMTD_Avg_Debt_To_Income from financial_loan Where issue_month=11; --DTI(Debt To Income) for bank should not be much higher much lower

--GOOD LOAN--

Select (count(case when loan_status='Fully Paid' or loan_status='Current' then id end)*100.0)/count(id) -- good loan percentage calculation 
       as Good_Loan_Percentage from financial_loan;

Select count(id) from financial_loan Where loan_status='Fully Paid' or loan_status='Current';  -- good loan applications count

Select sum(loan_amount) as good_loan_funded_amount from financial_loan Where loan_status='Fully Paid' or loan_status='Current';  -- good loan funded

Select sum(total_payment) as good_loan_received_amount from financial_loan Where loan_status='Fully Paid' or loan_status='Current';  -- good loan received from customer

--BAD LOAN--

Select (count(case when loan_status='Charged Off' then id end)*100.0)/count(id) -- bad loan percentage calculation 
       as Bad_Loan_Percentage from financial_loan;

Select count(id) from financial_loan Where loan_status='Charged Off';  -- bad loan applications count

Select sum(loan_amount) as bad_loan_funded_amount from financial_loan Where loan_status='Charged Off';  -- bad loan funded

Select sum(total_payment) as bad_loan_received_amount from financial_loan Where loan_status='Charged Off';  -- bad loan received from customer

Select 
	loan_status,
	count(id) as TotalLoanApplications,
	sum(loan_amount) as TotalFundedAmount,
	sum(total_payment) as TotalAmountReceived,
	avg(int_rate*100) as AverageInterestRate,
	avg(DTI*100) as AverageDebtToIncome
from financial_loan
group by loan_status; --you will always have to group it by dimension field when you are extracting data dimension field and measure field, here loan status is dimension

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE issue_month = 12 
GROUP BY loan_status       --For month to date data  



Alter Table financial_loan Alter Column issue_month int null;  --change the datatype of issue month from varchar to int

--Group by MONTH
SELECT 
	issue_month AS Month_Number, 
	DATENAME(MONTH, DATEADD(Month, issue_month,-1)) AS Month_Name, --As I wanted to change the integer value to respective month
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY issue_month, DATENAME(MONTH, DATEADD(Month, issue_month,-1)) --we will have to select all dimensions for group by
ORDER BY issue_month

ALTER TABLE financial_loan ADD issue_month_name varchar(20) NULL; 
UPDATE financial_loan SET issue_month_name = DATENAME(MONTH, DATEADD(Month, issue_month,-1)); 

--Group by State
SELECT 
	address_state, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state --we will have to select all dimensions for group by
ORDER BY count(id) Desc;

--Group by Loan Terms
SELECT 
	term as Loan_Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term --we will have to select all dimensions for group by
ORDER BY term;

--Group by Employe_Length, Loan issued depending on the bank employee experience
SELECT 
	emp_length as Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length --we will have to select all dimensions for group by
ORDER BY emp_length;

-- Group by Loan Purpose
SELECT 
	purpose as Loan_Purpose, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose --we will have to select all dimensions for group by
ORDER BY Count(id) Desc;

--Group By Home Ownership
SELECT 
	home_ownership as Property_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership --we will have to select all dimensions for group by
ORDER BY home_ownership;

-- Using Filter in same data
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
WHERE grade = 'A' -- using a filter according to 'Grade' Column
GROUP BY purpose
ORDER BY purpose


Select * from financial_loan

