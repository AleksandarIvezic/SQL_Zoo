--SELECT Basics

-- 1
SELECT name, population
  FROM world
 WHERE population BETWEEN 1000000 AND 1250000

 --2
 Albania 	3200000
Algeria 	32900000

--3
 
SELECT name FROM world
 WHERE name LIKE '%a' OR name LIKE '%l'

 --4

 name	length(name)
Italy	5
Malta	5
Spain	5

--5
Andorra	936 

--6
SELECT name, area, population
  FROM world
 WHERE area > 50000 AND population < 10000000

 --7
 SELECT name, population/area
  FROM world
 WHERE name IN ('China', 'Nigeria', 'France', 'Australia')

-- SELECT from world

-- 1.
SELECT name
  FROM world
 WHERE name LIKE 'U%'

-- 2.
SELECT population
  FROM world
 WHERE name = 'United Kingdom'

-- 3.
'name' should be name

-- 4.
Nauru	990

-- 5.
SELECT name, population
  FROM world
 WHERE continent IN ('Europe', 'Asia')

-- 6.
SELECT name FROM world
 WHERE name IN ('Cuba', 'Togo')

-- 7.
Brazil
Colombia