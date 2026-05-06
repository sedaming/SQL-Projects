-- ***********************************************************************
---************************ Data Analysis Project-Intro*******************
---**********************************************************************
-- **
-- ***
-- ****
--******************************** Covideaths Table****************************************
-- 1. General info
--1.1. looking at the number of rows 
--1.2. looking at all attributes for all rows
--1.3. looking at the all attributes for top 20 rows
--1.4. looking at selevtice attributes for top 20 rows
--1.5. looking at the number of countries in the dataset
--1.6. looking at the number of continent in the dataset
--1.7 looking at the number of days in the dataset
**********************************
--1.1
select count (*) from CovidDeaths
--1.2
select * from CovidDeaths
--1.3
select top 20 * from CovidDeaths
--1.4
select top 20 continent, location, total_cases, new_cases, total_deaths, new_cases
from CovidDeaths
--1.5
select count (distinct (location)) from CovidDeaths
--1.6
select count (distinct (continent)) from CovidDeaths
--1.7
select count (distinct (date)) from CovidDeaths
-- *
-- **
-- ***
-- ****
--2. Looking at Measures
-- 2.1. Looing at the death rate by population: ratio of total_deaths / population
-- 2.2. looking at the inceftion rate by population: ratio of total_cases/ population
-- 2.3. Looking at the ratio of death per cases
-- 2.4. looking at the maximum rate of death per country
-- 2.5. looking at the maximum rate of infection per country
-- 2.6. same query more profesional using partition --CTE (Common Table Expression)


--2.1
select location, date, total_deaths, population,
(cast (total_deaths as decimal (16, 8)) / nullif(population,0) ) * 100 as totalDeathsPerPop
from CovidDeaths
where continent is not null

--2.2
select location, date, total_cases, population,
(cast (total_cases as decimal (16, 8)) / nullif(population,0) ) * 100 as totalCasePerPop
from CovidDeaths
where continent is not null 


--2.3
select location, date, total_deaths, total_cases,
(cast (total_deaths as decimal (16, 8)) / nullif(total_cases,0)) * 100 as totalDeathsPerCases
from CovidDeaths
where continent is not null

--2.4
select 
    location,
    max((cast(total_deaths as decimal(16,8)) / nullif(population,0)) * 100) as MaxTotalDeathsPerPop
from CovidDeaths
where continent is not null
group by location
order by MaxTotalDeathsPerPop desc;


--2.5
select 
    location,
    max((cast(total_cases as decimal(16,8)) / nullif(population,0)) * 100) as MaxTotalCasesPerPop
from CovidDeaths
where continent is not null
group by location
order by MaxTotalCasesPerPop desc;


--2.6
WITH Latest AS (
    SELECT
        location,
        continent,
        date,
        total_cases,
        population,
        ROW_NUMBER() OVER (PARTITION BY location ORDER BY date DESC) AS rn
    FROM CovidDeaths
)
SELECT 
    location,
    date,
    (CAST(total_cases AS DECIMAL(16,8)) / NULLIF(population,0)) * 100 AS LatestInfectionRate
FROM Latest
WHERE continent IS NOT NULL
  AND rn = 1
ORDER BY LatestInfectionRate DESC;

-- *
-- **
-- ***
-- ****
--******************************** CovidVaccination Table****************************************
-- 1. General info
--1.1. looking at the number of rows 
--1.2. looking at all attributes for all rows
--1.3. looking at the all attributes for top 20 rows 
--1.4. looking at selevtice attributes for top 20 rows
--1.4. looking at the number of countries in the dataset
--1.5. looking at the number of continent in the dataset
--1.6 looking at the number of days in the dataset
--1.7 looing at the ration of row completeness

--1.1
select count (*) from
CovidVaccination
--1.2
select * from CovidVaccination
--1.3
select top 20 * from CovidVaccination
--1.4
select top 20 continent, location, date, new_tests, total_tests, total_vaccinations, 
people_vaccinated, people_fully_vaccinated, new_vaccinations
from CovidVaccination
ORDER BY location, date;
--1.5 
select count (distinct (location)) as totalCountries from CovidVaccination
--1.6
select count (distinct (date)) as numberOfDates from CovidVaccination

-- 1.7
SELECT
    COUNT(*) AS totalRows,
    cast(COUNT(new_vaccinations) as decimal (18, 6)) / COUNT(*) * 100 AS newVaccinationsNotNull,
    cast(count(total_vaccinations) as decimal (18, 6)) /COUNT(*) * 100 AS totalVaccinationsNotNull,
    cast(count(people_vaccinated) as decimal (18, 6)) /COUNT(*) * 100 AS peopleVaccinatedNotNull,
    cast(count(people_fully_vaccinated) as decimal (18, 6))/ COUNT(*) * 100 AS peopleFullyVaccinatedNotNull
FROM CovidVaccination;


 select count (*) from covidvaccination 
 where total_vaccinations is not null and people_vaccinated is not null and
 people_fully_vaccinated is not null and new_vaccinations is not null and continent is not null 
-- *
-- **
-- ***
-- ****
--2. Looking at Measures
-- 2.1. Looing at the Sum of new vaccinations
-- 2.2. looing at the completeness rate of new vaccinations (too many null info results in wrong estimation)
-- 2.3. Looing at the daily average vaccniation per country (Using CTE)
-- 2.4. looking at the maximum level of total vaccination per country (using CTE & EXISTS)
-- 2.5. looking at the maximum number of vaccinated people per country


--2.1 
select location, sum (new_vaccinations) sumNewVaccination from CovidVaccination
where continent is not null
group by location
order by sumNewVaccination desc

-- 2.2
SELECT
location,
    COUNT(*) AS totalRows,
    COUNT(new_vaccinations) AS notNullRows,
    COUNT(*) - COUNT(new_vaccinations) AS nullRows,
    CAST(COUNT(new_vaccinations) AS DECIMAL(10,2)) / COUNT(*) * 100 AS completenessPercent
FROM CovidVaccination
group by location
having CAST(COUNT(new_vaccinations) AS DECIMAL(10,2)) / COUNT(*) * 100 > 20
order by completenessPercent desc


--2.3
With AVGvag as (
    select
        location,
        avg (new_vaccinations) as AverageVaccinationnum 
    from CovidVaccination
    where new_vaccinations is not null
    group by location) 

select 
    location,
    format ( AverageVaccinationnum, 'N0') as AverageVaccinationT 
from AVGvag
order by AverageVaccinationnum desc


--2.4
-- Creating CTE
With TOTALVAC as (
    select 
        location,
        max (total_vaccinations) as maxVaccination
    from CovidVaccination
    where total_vaccinations is not null
    group by location)
 
 -- formating the output while making sure the date is related to countires not continent
 -- Using EXISTS
    select 
        tov.location,
        format (tov.maxVaccination, 'N0') as MAXVACCIN
        from TOTALVAC tov
        where exists (select
                            1
                      from
                      CovidDeaths cd
                      where Tov.location = cd.location
                      and
                      cd.continent is not null)
    order by tov.maxVaccination desc


--2.5
-- Creating CTE
With TOTALVACPEP as (
    select 
        location,
        max (people_vaccinated) as maxVaccinatedPeople
    from CovidVaccination
    where people_vaccinated is not null
    group by location)
 
 -- formating the output while making sure the date is related to countires not continent
 -- Using EXISTS
    select 
        tovpp.location,
        format (tovpp.maxVaccinatedPeople, 'N0') as MAXVACCINPEP
        from TOTALVACPEP tovpp
        where exists (select
                            1
                      from
                      CovidDeaths cd
                      where tovpp.location = cd.location
                      and
                      cd.continent is not null)
    order by tovpp.maxVaccinatedPeople desc
-- *
-- **
-- ***
-- ****
--******************************** Joining CovidDeaths & CovidVaccination Table****************************************

-- 1. looking at both tables together
-- 2. Percentage of vaccinated people per population
-- 3. Maximum percentage of fully vaccinted people per population
-- 4. Maximum percentage of vaccinted people per population



-- 1.
 select 
            * from CovidDeaths d 
              join CovidVaccination v 
              on d.date = v.date and d.location = v.location


--2.1 simple format:

SELECT
    d.location,
    d.date,
    d.population,
    v.people_vaccinated,
    CAST(v.people_vaccinated AS DECIMAL(18,6)) / NULLIF(d.population,0) * 100 AS vaccinationRate
FROM CovidDeaths d
JOIN CovidVaccination v
    ON d.location = v.location
   AND d.date = v.date
WHERE d.continent IS NOT NULL;


-- 2.2. More professional Version: (usuing CTE)

with t as (
select 
    code.location,
    code.date,
    code.population, 
    covac.people_vaccinated, 
    cast (covac.people_vaccinated as decimal (18, 6)) / nullif (code.population, 0) * 100 as Rati
    from CovidDeaths code
    join CovidVaccination covac
        on code.location = covac.location 
           and code.date = covac.date
    where people_vaccinated is not null 
    and code.continent is not null)


select location, population, people_vaccinated, format (rati, 'N3') as RatioVaccinatedPeop
from t


--3.1 simple format:

SELECT
    d.location,
    max (CAST(v.people_fully_vaccinated AS DECIMAL(18,6)) / NULLIF(d.population,0)) * 100 AS maxFullyVaccinationRate
FROM CovidDeaths d
JOIN CovidVaccination v
    ON d.location = v.location
   AND d.date = v.date
where v.people_fully_vaccinated is not null and
d.continent IS NOT NULL
group by d.location 
order by maxFullyVaccinationRate desc

-- 3.2. More professional Version: (usuing CTE)

;with fullpop as (
select 
    code.location,
    max (cast (covac.people_fully_vaccinated as decimal (18, 6)) / nullif (code.population, 0)) * 100 as maxFullPopvac
    from CovidDeaths code
    join CovidVaccination covac
        on code.location = covac.location 
           and code.date = covac.date
    where people_fully_vaccinated is not null 
    and code.continent is not null
    group by 
    code.location
    )

select location, format (maxFullPopvac, 'N3') as MaxFullyVaccinatedPeop
from fullpop 
order by maxFullPopvac desc


-- 4.

;with t as (
    select 
    code.location,
    max(cast (covac.people_vaccinated as decimal (18, 6)) / nullif (code.population, 0) * 100) as maxi
    from CovidDeaths code
    join CovidVaccination covac
        on code.location = covac.location 
           and code.date = covac.date
    where code.continent is not null
    group by 
    code.location
    )

select location, format (maxi, 'N3') as maxVaccinatedPeop
from t
ORDER BY maxi DESC;

-- DONE BY AMIN AMIRKHALILI
-- LINKEDIN: https://www.linkedin.com/in/sedamin/
