/*
Query the list which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
*/

SELECT DISTINCT CITY
FROM
STATION
WHERE 
CITY RLIKE '^[aeiou]' AND CITY RLIKE '[aeiou]$'  
