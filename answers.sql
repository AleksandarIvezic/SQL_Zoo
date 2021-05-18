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

-- 1 Winners from 1950
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- 2. 1962 Literature
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

-- 3. Albert Einstein
SELECT yr, subject 
FROM nobel
WHERE winner = 'Albert Einstein';

-- 4. Recent Peace Prizes
SELECT winner 
FROM nobel
WHERE subject = 'Peace'
AND yr >= 2000; 

-- 5. Literature in the 1980's
SELECT * 
FROM nobel
WHERE yr BETWEEN 1980 AND 1989
AND subject = 'Literature';

-- 6. Only Presidents
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

-- 7. John
SELECT winner 
FROM nobel
WHERE winner LIKE 'John%';

-- 8. Chemistry and Physics from different years
SELECT * 
FROM nobel
WHERE (yr = 1980
AND subject = 'Physics')
OR (yr = 1984 
AND subject = 'Chemistry');

-- 9. Exclude Chemists and Medics
SELECT * 
FROM nobel
WHERE subject NOT IN ('Chemistry', 'Medicine')
AND yr = 1980;

-- 10. Early Medicine, Late Literature
SELECT * 
FROM nobel
WHERE (subject = 'Medicine'
AND yr < 1910)
OR (subject = 'Literature'
AND yr >=2004)

-- 11. Harder Questions
SELECT * 
FROM nobel
WHERE winner = 'PETER GRÜNBERG';

-- 12. Apostrophe
SELECT * 
FROM nobel
WHERE winner = 'EUGENE O''NEILL';

-- 13. Knights of the realm
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner ASC;

-- 14. Chemistry and Physics last
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY CASE WHEN subject IN ('Physics', 'Chemistry') THEN 1 ELSE 0 END,subject,winner;


