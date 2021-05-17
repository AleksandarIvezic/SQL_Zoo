--SELECT basics

--1
population
80716000

--2
name	population
Denmark	5634437
Norway	5124383
Sweden	9675885

--3
name	area
Belarus	207600
Ghana	238533
Guinea	245857
Guyana	214969
Laos	236800
Romania	238391
Uganda	241550
United Kingdom	242900

--SELECT from WORLD 

-- 1
SELECT name, continent, population FROM world;

-- 2
SELECT name
FROM world
WHERE population >= 200000000;

--  3
SELECT name, gdp/population
FROM  world
WHERE population >= 200000000;

-- 4
SELECT name, population/1000000 AS population_in_milions
FROM world
WHERE continent = 'South America';

-- 5
SELECT name, population
FROM world 
WHERE name IN ('France', 'Germany', 'Italy');

-- 6
SELECT name 
FROM world
WHERE name LIKE '%united%';

-- 7
SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000;

-- 8
-- SELECT name, population, area
-- FROM world
-- WHERE area > 3000000 XOR population > 250000000;
-- XOR operator doesn't work for some reason
SELECT name, population, area
FROM world
WHERE (area > 3000000 AND population < 250000000) OR (area < 3000000 AND population > 250000000);

-- 9
SELECT 
name, 
ROUND(population/1000000, 2) AS pop_in_mill, 
ROUND(gdp/1000000000, 2) AS gdp_in_bill
FROM world
WHERE continent LIKE 'South America';

-- 10
SELECT name, ROUND(gdp/population, -3) AS gdp_per_capita
FROM world
WHERE gdp >= 1000000000000

-- 11
SELECT name, capital
 FROM world
 WHERE LEN(name) LIKE LEN(capital);

-- 12
SELECT name, capital
FROM world
WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital;

-- 13
SELECT name
   FROM world
WHERE name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';



--SELECT from Nobel