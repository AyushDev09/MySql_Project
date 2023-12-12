-- IMPORTING THE DATASET WE ARE GOING TO BE USING

 LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Covid_deaths.csv" INTO TABLE covid_deaths
 FIELDS TERMINATED BY ','
 IGNORE 1 LINES;
 
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Covid_vaccinations.csv" INTO TABLE covid_vaccinations
 FIELDS TERMINATED BY ','
 IGNORE 1 LINES; 

-- SELECTING THE DATA WE ARE GOING TO BE USING

Select
	Location,
	date,
	total_cases,
	new_cases,
	total_deaths,
	population
From 
	portfolio_project.covid_deaths;
    
-- LOOKING AT TOTAL CASES vs TOTAL DEATHS FOR THE WORLD

Select
	Location,
	date,
	total_cases,
	total_deaths,
    population,
    Round((total_deaths/total_cases)*100,4) as DeathPercentage
From 
	portfolio_project.covid_deaths;
    
-- LOOKING AT TOTAL CASES vs TOTAL DEATHS FOR INDIA

Select
	Location,
	date,
	total_cases,
	total_deaths,
    population,
    Round((total_deaths/total_cases)*100,4) as DeathPercentage
From 
	portfolio_project.covid_deaths
Where
    location = "India";
    
-- SHOWING THE PERCENTAGE OF PEOPLE WHO GOT COVID ACCORDING TO THE POPULATION 

Select
	Location,
	date,
	total_cases,
	total_deaths,
    population,
    Round((total_cases/population)*100,4) as InfectedRate
From 
	portfolio_project.covid_deaths;
    
-- SHOWING THE PERCENTAGE OF PEOPLE IN INDIA WHO GOT COVID ACCORDING TO THE POPULATION 

Select
	Location,
	date,
	total_cases,
	total_deaths,
    population,
    Round((total_cases/population)*100,4) as InfectedRate
From 
	portfolio_project.covid_deaths
Where
    location = 'India';
    
-- COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO THE POPULATION

Select
	Location,
    population,
    Max(total_cases) as HighestInfectionCount,
    Max(Round((total_cases/population)*100,4)) as InfectedRate
From 
	portfolio_project.covid_deaths
Group by Location, Population;

-- HIGHEST DEATH COUNT ACCORDING TO THE POPULATION

Select
	Location,
    population,
    Max(total_deaths) as TotalDeathCount
From 
	portfolio_project.covid_deaths
Group by Location, Population;

-- BREAKDOWN BY CONTINENTS
Select
    continent,
    sum(population),
    sum(new_deaths)
From
	portfolio_project.covid_deaths
Where
    continent is not null
Group by
    continent;
    
-- LOOKING AT TOTAL POPULATION vs VACCINATIONS

Select
     dea.continent,
     dea.location,
     dea.date,
     dea.population,
     vac.new_vaccinations,
     sum(vac.new_vaccinations) OVER (partition by dea.location) as Total_Vaccinations  
From
    portfolio_project.covid_deaths dea
Join
    portfolio_project.covid_vaccinations vac
On
    dea.location = vac.location
and
    dea.date = vac.date
Order by
    dea.location,dea.date;
    




