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


/* New merged company*/
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

/*oracle sql
Pivot the Occupation column
*/
select D, P, S, A
  from (
        Select Row_Number() OVER (PARTITION BY occupation ORDER BY name) rownumber, 
               name,
               occupation       
          from occupations
       ) t
pivot(
  min(name)
  for occupation in ('Doctor' D, 'Professor' P, 'Singer' S, 'Actor' A)
)
order by rownumber;

/* Mysql
alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical
*/
SELECT CONCAT(NAME, "(", LEFT(OCCUPATION,1) ,")") as NAME
FROM OCCUPATIONS
ORDER BY NAME;

/*
Query the number of ocurrences of each occupation in OCCUPATIONS.
*/

SELECT CONCAT("There are a total of"," ", COUNT(OCCUPATION), " ", LOWER(OCCUPATION), "s.") FROM OCCUPATIONS GROUP BY OCCUPATION ORDER BY COUNT(OCCUPATION)

/* Mysql 
Type of Triangle*/
SELECT 
CASE WHEN  A + B <= C OR B + C <= A AND C + A <= B THEN "Not A Triangle"
     WHEN A = B AND B = C AND C = A THEN  "Equilateral"
     WHEN A = B OR B = C OR C = A THEN "Isosceles"
     ELSE "Scalene"
END
FROM TRIANGLES

/*
Binary Tree Nodes
*/
SELECT N, CASE WHEN P IS NULL THEN 'Root'
               WHEN N IN (SELECT P FROM BST) THEN 'Inner'
               ELSE 'Leaf'
               END
FROM BST
ORDER BY N
