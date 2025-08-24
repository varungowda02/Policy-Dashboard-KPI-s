use policy;
-- 1-Total Policy
SELECT COUNT(*) AS Total_Policies
FROM policydetails;

-- 2-Total Customers
SELECT COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM policydetails;

-- 3-Age Bucket Wise Policy Count
SELECT 
    CASE 
        WHEN c.age BETWEEN 18 AND 25 THEN '18-25'
        WHEN c.age BETWEEN 26 AND 35 THEN '26-35'
        WHEN c.age BETWEEN 36 AND 45 THEN '36-45'
        WHEN c.age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS Age_Bucket,
    COUNT(p.`Policy ID`) AS Policy_Count
FROM policydetails p
JOIN customerinformation c ON p.`Customer ID` = c.`Customer ID`
GROUP BY Age_Bucket
ORDER BY Age_Bucket;

-- 4-Gender Wise Policy Count
SELECT c.gender, COUNT(p.`Policy ID`) AS Policy_Count
FROM policydetails p
JOIN customerinformation c ON p.`Customer ID` = c.`Customer ID`
GROUP BY c.gender;

-- 5-Policy Type Wise Policy Count
SELECT `Policy Type`, COUNT(`Policy ID`) AS Policy_Count
FROM policydetails
GROUP BY `Policy Type`;

-- 6-Policy Expire This Year
SELECT COUNT(`Policy ID`) AS Expiring_Policies
FROM policydetails
WHERE YEAR(`Policy End Date`) = YEAR(CURDATE());

-- 7-Premium Growth Rate
SELECT 
    ((SUM(CASE WHEN YEAR(`Policy End Date`) = YEAR(CURDATE()) THEN `Premium Amount` ELSE 0 END) -
      SUM(CASE WHEN YEAR(`Policy Start Date`) = YEAR(CURDATE()) - 1 THEN `Premium Amount` ELSE 0 END)
     ) / NULLIF(SUM(CASE WHEN YEAR(`Policy Start Date`) = YEAR(CURDATE()) - 1 THEN `Premium Amount` ELSE 0 END), 0) * 100
    ) AS Premium_Growth_Rate_Percent
FROM policydetails;

-- 8-Claim Status Wise Policy Count
select * from claims;
SELECT `Claim Status` as status, COUNT(`Policy ID`) AS Policy_Count
FROM claims
GROUP BY status;

-- 9-Payment Status Wise Policy Count
SELECT ph.`Payment Status`, COUNT(DISTINCT p.`Policy ID`) AS Policy_Count
FROM policydetails p
JOIN paymenthistory ph ON p.`Policy ID` = ph.`Policy ID`
GROUP BY ph.`Payment Status`;

-- 10-Total Claim Amount
SELECT SUM(`Claim Amount`) AS Total_Claim_Amount
FROM claims;









