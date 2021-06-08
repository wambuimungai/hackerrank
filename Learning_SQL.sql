/*
Query the list which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
*/

SELECT DISTINCT CITY
FROM
STATION
WHERE 
CITY RLIKE '^[aeiou]' AND CITY RLIKE '[aeiou]$'; 


SELECT 
DISTINCT CITY
FROM
STATION
WHERE
CITY NOT RLIKE '^[aeiou]' OR CITY NOT RLIKE '[aeiou]$';

SELECT DISTINCT  ct.company_Code, ct.founder,  
    COUNT(DISTINCT lmt.lead_manager_code) as total_lead_manager,  
    COUNT(DISTINCT smt.senior_manager_code) as total_senior_manager,  
    COUNT(DISTINCT mt.manager_code) as total_manager, 
    COUNT( DISTINCT et.employee_code) as total_employee  
FROM Company ct  
LEFT JOIN Lead_Manager lmt  
ON lmt.company_code = ct.company_code  
LEFT JOIN Senior_Manager smt  
ON smt.lead_manager_code = lmt.lead_manager_code  
AND ct.company_code = lmt.company_code  
LEFT JOIN Manager mt 
ON mt.senior_manager_code = smt.senior_manager_code 
AND mt.lead_manager_code = lmt.lead_manager_code
AND mt.company_code = ct.company_code 
LEFT JOIN Employee et 
ON et.manager_code = mt.manager_code 
AND et.senior_manager_code = smt.senior_manager_code 
AND et.lead_manager_code = lmt.lead_manager_code 
AND et.company_code = ct.company_code 
GROUP BY ct.company_Code, ct.founder 
ORDER BY Company_Code ASC ; 
