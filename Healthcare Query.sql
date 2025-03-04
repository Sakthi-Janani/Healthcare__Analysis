USE HEALTHCARE_

SELECT * FROM Medicare_Charge_Inpatient
SELECT * FROM Medicare_Charge_Outpatient
SELECT * FROM Medicare_Provider_Charge_Inpatient
SELECT * FROM Medicare_Provider_Charge_Outpatient
SELECT * FROM Patient_history_samp
SELECT * FROM Review_patient_history_samp
SELECT * FROM Review_transaction_coo
SELECT * FROM Transaction_coo
SELECT * FROM DRGCodes_Global_proc_id_Mapping

--EDA

--DATA Understanding 

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Medicare_Charge_Inpatient';

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Medicare_Charge_Outpatient';

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Medicare_Provider_Charge_Inpatient';

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Medicare_Provider_Charge_Outpatient';

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Patient_history_samp';

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Review_patient_history_samp';

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Review_transaction_coo';

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Transaction_coo';

--Check no of records

SELECT COUNT (*) No_of_diagnosis_group_of_inpatient FROM Medicare_Charge_Inpatient

SELECT COUNT (*) No_of_ambulatory_payment_for_outpatient FROM Medicare_Charge_Outpatient

SELECT COUNT(Distinct Provider_Id) No_of_providers_for_inpatient FROM Medicare_Provider_Charge_Inpatient

SELECT COUNT(Distinct Provider_Id) No_of_providers_for_outpatient FROM Medicare_Provider_Charge_Outpatient

SELECT
COUNT(Distinct mo.Provider_Id)
FROM Medicare_Provider_Charge_Inpatient MI
inner join Medicare_Provider_Charge_Outpatient MO ON MI.Provider_Id = MO.Provider_Id --common providers for both inpatient's and outpatient's

SELECT COUNT(DISTINCT id) Total_patients FROM Patient_history_samp

SELECT COUNT(DISTINCT id) review_Total_patients FROM Review_patient_history_samp

SELECT COUNT(DISTINCT id) Total_Transaction FROM Transaction_coo

SELECT COUNT(DISTINCT id) review_Total_Transaction FROM Review_transaction_coo

--Finding NULL Values

SELECT
SUM(CASE WHEN DRG_Definition IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Total_Discharges IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Average_Covered_Charges IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Average_Total_Payments IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Average_Medicare_Payments IS NULL THEN 1 ELSE 0 END)
FROM Medicare_Charge_Inpatient

SELECT
SUM(CASE WHEN APC IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Outpatient_Services IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Average_Estimated_Submitted_Charges IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Average_Total_Payments IS NULL THEN 1 ELSE 0 END)
FROM Medicare_Charge_Outpatient

SELECT
SUM(CASE WHEN DRG_Definition IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Provider_Id IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Provider_Name IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Provider_Street_Address IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Provider_City IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Provider_State IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Provider_Zip_Code IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Hospital_Referral_Region_HRR_Description IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Total_Discharges IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Average_Covered_Charges IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Average_Total_Payments IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN Average_Medicare_Payments IS NULL THEN 1 ELSE 0 END)
FROM Medicare_Provider_Charge_Inpatient

SELECT
SUM(CASE WHEN APC IS NULL THEN 1 ELSE 0 END)count_of_null_apc,
SUM(CASE WHEN Provider_Id IS NULL THEN 1 ELSE 0 END)count_of_null_provider_id,
SUM(CASE WHEN Provider_Name IS NULL THEN 1 ELSE 0 END)count_of_null_provider_name,
SUM(CASE WHEN Provider_Street_Address IS NULL THEN 1 ELSE 0 END)count_of_nul_provider_street,
SUM(CASE WHEN Provider_City IS NULL THEN 1 ELSE 0 END) count_of_null_provider_city,
SUM(CASE WHEN Provider_State IS NULL THEN 1 ELSE 0 END)count_of_null_provider_state,
SUM(CASE WHEN Provider_Zip_Code IS NULL THEN 1 ELSE 0 END) count_of_null_provider_zio_code,
SUM(CASE WHEN Hospital_Referral_Region_HRR_Description IS NULL THEN 1 ELSE 0 END) count_of_null_hospital_region,
SUM(CASE WHEN Outpatient_Services IS NULL THEN 1 ELSE 0 END) count_of_null_outpatient_service,
SUM(CASE WHEN Average_Estimated_Submitted_Charges IS NULL THEN 1 ELSE 0 END) count_of_null_submitted_charge,
SUM(CASE WHEN Average_Total_Payments IS NULL THEN 1 ELSE 0 END) count_of_null_total_payment
FROM Medicare_Provider_Charge_Outpatient

SELECT 
SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS NULL_ID,
SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) NULL_Age,--NULL VALUE IS DETECTED
SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) null_gender,
SUM(CASE WHEN income IS NULL THEN 1 ELSE 0 END) null_income--NULL VALUE IS DETECTED
FROM Patient_history_samp

SELECT 
SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END)count_of_null_id,
SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END)count_of_null_age,--NULL VALUE IS DETECTED
SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END)count_of_null_gender,
SUM(CASE WHEN income IS NULL THEN 1 ELSE 0 END) count_of_null_income--NULL VALUE IS DETECTED
FROM Review_patient_history_samp

SELECT 
SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN global_proc_id IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN count IS NULL THEN 1 ELSE 0 END)
FROM Transaction_coo

SELECT 
SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN global_proc_id IS NULL THEN 1 ELSE 0 END),
SUM(CASE WHEN count IS NULL THEN 1 ELSE 0 END)
FROM Review_transaction_coo 

--Handling null values

--Update the null values in the age column with the maximum occured value
Update Patient_history_samp
SET age = (
	SELECT TOP 1
		AGE 
	FROM Patient_history_samp 
	GROUP BY AGE 
	ORDER BY COUNT(*) DESC
	)
WHERE age IS NULL


--Update the null values in the age column with the maximum occured value
Update Patient_history_samp
SET income = (
	SELECT TOP 1
		income 
	FROM Patient_history_samp 
	GROUP BY income 
	ORDER BY COUNT(*) DESC
	)
WHERE income IS NULL

--Average percentage of amount payed out of the total bill amount out of  all the diagnosis
SELECT
	ROUND(Avg(percentage_of_amt_payed_out_of_the_total_bill_amt),0) as Avg_percentage_paid
FROM (
	SELECT 
		DRG_Definition,
		ROUND((Average_Total_Payments *100) /NULLIF(Average_Covered_Charges,0),2) AS percentage_of_amt_payed_out_of_the_total_bill_amt
	FROM Medicare_Charge_Inpatient 
	)result


--Average percentage of medicare amount payed out of the total bill amount out of  all the diagnosis
SELECT
	ROUND(Avg(per_of_medicare_amt_payed_out_of_the_total_bill_amt),0) as Avg_percentage_paid
FROM (
	SELECT 
		DRG_Definition,
		ROUND((Average_Medicare_Payments *100) /NULLIF(Average_Covered_Charges,0),2) AS per_of_medicare_amt_payed_out_of_the_total_bill_amt
	FROM Medicare_Charge_Inpatient 
	)result

-- Out of the total amount payed how much percentage is provided by the medicare
SELECT
	ROUND(Avg(percentage_of_amt_payed_out_of_the_total_bill_amt),0) as Avg_percentage_paid_by_medicare
FROM (
	SELECT 
		DRG_Definition,
		ROUND((Average_Medicare_Payments *100) /NULLIF(Average_Total_Payments,0),2) AS percentage_of_amt_payed_out_of_the_total_bill_amt
	FROM Medicare_Charge_Inpatient 
	)result

--For outpatient what is average % of amount paid out of the total bill amount
SELECT
	ROUND(Avg(percentage_of_amt_payed_out_of_the_total_bill_amt),0) as Avg_percentage_paid
FROM (
	SELECT 
		APC,
		ROUND((Average_Total_Payments *100) /NULLIF(Average_Estimated_Submitted_Charges,0),2) AS percentage_of_amt_payed_out_of_the_total_bill_amt
	FROM Medicare_Charge_Outpatient 
	)result


--No.of providers per diagnosis
SELECT
	DRG_Definition,
	COUNT(Provider_Id) AS Provider_count
FROM Medicare_Provider_Charge_Inpatient
GROUP BY DRG_Definition
ORDER BY Provider_count DESC

--No.of diagnosis service provided by each provider
SELECT
	Provider_Id,
	COUNT(DISTINCT DRG_Definition) AS Diagnosis_count
FROM Medicare_Provider_Charge_Inpatient
GROUP BY Provider_Id


--Avg % of amount provided by medicare for each diagnosis
SELECT
	DRG_Definition,
	ROUND(AVG((Average_Medicare_Payments*100) / NULLIF(Average_Total_Payments,0)),2) AS Avg_Medicare_Coverage_Percentage
FROM Medicare_Provider_Charge_Inpatient
GROUP BY DRG_Definition
ORDER BY Avg_Medicare_Coverage_Percentage DESC


--Avg % of amount provided by each provider
SELECT
	Provider_Id,
	ROUND(AVG((Average_Medicare_Payments*100) / NULLIF(Average_Total_Payments,0)),2) AS Avg_Medicare_Coverage_Percentage
FROM Medicare_Provider_Charge_Inpatient
GROUP BY Provider_Id
ORDER BY Avg_Medicare_Coverage_Percentage DESC

--No.of Diagnosis and providers per state
SELECT
	Provider_State,
	COUNT(DISTINCT Provider_Id) AS No_of_providers,
	COUNT(DRG_Definition) AS No_of_Diagnosis
FROM Medicare_Provider_Charge_Inpatient
GROUP BY Provider_State
ORDER BY No_of_providers DESC

--No.of.Diagnosis and  providers per City
SELECT
	Provider_City,
	COUNT(DISTINCT Provider_Id) AS No_of_providers,
	COUNT(DRG_Definition) AS No_of_Diagnosis
FROM Medicare_Provider_Charge_Inpatient
GROUP BY Provider_City
ORDER BY No_of_providers DESC

--Highest Medicare Coverage provider are from which state and city
SELECT
	result.Provider_Id,
	mi.Provider_State,
	mi.Provider_City,
	mi.Provider_Zip_Code,
	ROUND(AVG(Avg_Medicare_Coverage_Percentage),0) Avg_Medicare_Coverage_Percentage
FROM(
	SELECT
		Provider_Id,
		ROUND(AVG((Average_Medicare_Payments*100) / NULLIF(Average_Total_Payments,0)),2) AS Avg_Medicare_Coverage_Percentage
	FROM Medicare_Provider_Charge_Inpatient
	GROUP BY Provider_Id
	)result
join Medicare_Provider_Charge_Inpatient mi on result.Provider_Id = mi.Provider_Id
Group by result.Provider_Id,mi.Provider_State,mi.Provider_City,mi.Provider_Zip_Code
ORDER BY Avg_Medicare_Coverage_Percentage DESC 

--No.of Diagnosis per Hospital Region
SELECT
	Hospital_Referral_Region_HRR_Description,
	Count(DRG_Definition) AS No_of_Diagnosis
FROM Medicare_Provider_Charge_Inpatient
GROUP BY Hospital_Referral_Region_HRR_Description
ORDER BY No_of_Diagnosis DESC

--No.of providers for each APC
SELECT
	APC,
	COUNT(DISTINCT Provider_Id) AS No_of_providers
FROM Medicare_Provider_Charge_Outpatient
GROUP BY APC
ORDER BY No_of_providers DESC

--Average % of claims provided by each provider
SELECT
	Provider_Id,
	ROUND(AVG((Average_Total_Payments*100)/NULLIF(Average_Estimated_Submitted_Charges,0)),0) AS Avg_percentage_paid
FROM Medicare_Provider_Charge_Outpatient
GROUP BY Provider_Id
ORDER BY Avg_percentage_paid DESC

--Max providers are from which state
SELECT
	Provider_State,
	COUNT(DISTINCT Provider_Id) AS No_of_provider
FROM Medicare_Provider_Charge_Outpatient
GROUP BY Provider_State
ORDER BY No_of_provider DESC

--Max providers are from which City
SELECT
	Provider_City,
	COUNT(DISTINCT Provider_Id) AS No_of_provider
FROM Medicare_Provider_Charge_Outpatient
GROUP BY Provider_City
ORDER BY No_of_provider DESC

--Outpatient served per provider
SELECT
	Provider_Id,
	SUM(Outpatient_Services) AS Total_outpatient_served
FROM Medicare_Provider_Charge_Outpatient
GROUP BY Provider_Id
ORDER BY Total_outpatient_served DESC

--Total Outpatient served by each provider per APC
SELECT
	Provider_Id,
	APC,
	SUM(Outpatient_Services) AS Total_outpatient_served
FROM Medicare_Provider_Charge_Outpatient
GROUP BY Provider_Id,APC
ORDER BY Provider_Id 

--Average amount of claim provided by each provider for each APC
SELECT
	Provider_Id,
	APC,
	ROUND(AVG((Average_Total_Payments*100)/NULLIF(Average_Estimated_Submitted_Charges,0)),0) AS Avg_percentage_paid
FROM Medicare_Provider_Charge_Outpatient
GROUP BY Provider_Id,APC
ORDER BY Provider_Id,APC


--Gender Propotion
SELECT
	gender AS Gender,
	COUNT(gender) AS Total_Patients
FROM Patient_history_samp
GROUP BY gender

--Max age group
SELECT
	age AS Age,
	COUNT(age) AS COUNT_
FROM Patient_history_samp
GROUP BY age
ORDER BY COUNT_ DESC

--Max income range
SELECT
	income AS Income,
	COUNT(income) AS COUNT_
FROM Patient_history_samp
GROUP BY income
ORDER BY COUNT_ DESC 
-----------------------------------------------------------------
--Highly charged Procedure
SELECT TOP 10
	DRG_Definition,
	Average_Covered_Charges
FROM Medicare_Charge_Inpatient
ORDER BY Average_Covered_Charges DESC

--Procedure with highest Discharge rate
SELECT TOP 10
	DRG_Definition,
	Total_Discharges
FROM Medicare_Charge_Inpatient
ORDER BY Total_Discharges DESC


--For which diagnosis the medicare cost is highly paid
SELECT
	DRG_Definition,
	Average_Total_Payments,
	Average_Medicare_Payments,
	ROUND((Average_Medicare_Payments*100)/Average_Total_Payments,2) AS AVG_AMT_PAYED_BY_PATIENT
FROM Medicare_Charge_Inpatient 
ORDER BY AVG_AMT_PAYED_BY_PATIENT DESC

--Top 10 Frequent outpatient service
SELECT TOP 10
	APC,
	Outpatient_Services
FROM Medicare_Charge_Outpatient
ORDER BY Outpatient_Services DESC

--Which outpatient service have highest charge
SELECT TOP 10
	APC,
	Average_Estimated_Submitted_Charges
FROM Medicare_Charge_Outpatient
ORDER BY Average_Estimated_Submitted_Charges DESC

--City with highest outpatient service
SELECT
	Provider_City,
	SUM(Outpatient_Services) AS Total_Outpatient
FROM Medicare_Provider_Charge_Outpatient
GROUP BY Provider_City
ORDER BY Total_Outpatient Desc

--Max outpatient services Hosipital
SELECT
	Hospital_Referral_Region_HRR_Description,
	SUM(Outpatient_Services) AS Total_Outpatients
FROM Medicare_Provider_Charge_Outpatient
GROUP BY Hospital_Referral_Region_HRR_Description
ORDER BY Total_Outpatients DESC

--Frequently Occured Outpatient Service
SELECT
	APC,
	COUNT(APC) AS Frequent_service
FROM Medicare_Provider_Charge_Outpatient
GROUP BY APC
ORDER BY Frequent_service DESC

SELECT*FROM Medicare_Provider_Charge_Outpatient

