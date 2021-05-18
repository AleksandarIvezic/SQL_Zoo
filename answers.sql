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


-- SELECT within SELECT

-- 1.Bigger than Russia
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- 2.Richer than UK
SELECT name
FROM world
WHERE continent= 'Europe'
AND gdp/population >(SELECT gdp/population FROM world 
                             WHERE name='United Kingdom');

-- 3.Neighbours of Argentina and Australia
SELECT name, continent 
FROM world
WHERE continent IN (SELECT DISTINCT continent FROM world 
                   WHERE name IN ('Argentina', 'Australia'));

-- 4.Between Canada and Poland
SELECT name, population
FROM world 
WHERE population BETWEEN
(SELECT population FROM world WHERE name = 'Canada')+1
AND 
(SELECT population FROM world WHERE name = 'Poland')-1

-- 5.Percentages of Germany
SELECT name, 
CONCAT( CAST (ROUND(population*100/(SELECT population FROM world WHERE name = 'Germany'), 0)AS INT)
, '%')
 AS percentage
FROM world
WHERE continent = 'Europe'

-- 6.Bigger than every country in Europe
SELECT name 
FROM world
WHERE gdp > (SELECT MAX(gdp)FROM world WHERE continent = 'Europe');

-- 7.Largest in each continent
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent)

-- 8.First country of each continent (alphabetically)
SELECT continent, name FROM world x
  WHERE name <= ALL
    (SELECT name FROM world y
        WHERE y.continent=x.continent)

-- 9.Difficult Questions That Utilize Techniques Not Covered In Prior Sections
SELECT name, continent, population 
FROM world x
WHERE 25000000 >= ALL (SELECT population FROM world y
                         WHERE x.continent = y.continent ) 

-- 10.Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent
FROM world x
WHERE population/3 >= ALL (SELECT population from world y
                           WHERE x.continent = y.continent 
                           AND x.population != y.population)


-- SUM and COUNT

-- 1.Total world population
SELECT SUM(population)
FROM world

-- 2.List of continents
SELECT DISTINCT continent
FROM world;

-- 3.GDP of Africa
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa'

-- 4.Count the big countries
SELECT COUNT(*)
FROM world
WHERE area>=1000000

-- 5.Baltic states population
SELECT SUM (population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

-- 6.Counting the countries of each continent
SELECT continent, COUNT(name)
FROM world
GROUP BY continent;

-- 7.Counting big countries in each continent
SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent;

-- 8.Counting big continents
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;