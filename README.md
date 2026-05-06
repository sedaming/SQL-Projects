# SQL Projects Portfolio

![SQL Server](https://img.shields.io/badge/Tool-SQL%20Server%20(T--SQL)-CC2927?style=flat&logo=microsoft-sql-server&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![Type](https://img.shields.io/badge/Type-Personal%20Projects-blue)
![Location](https://img.shields.io/badge/Location-Canada-red)

A collection of SQL data analysis and data cleaning projects built using **Microsoft SQL Server (T-SQL)**. Each project demonstrates real-world analytical thinking, query optimization, and data wrangling skills.

---

## Projects

### 1. COVID-19 Data Exploration

**File:** [`COVID-19-Data-Exploration/covid_data_exploration.sql`](./COVID-19-Data-Exploration/covid_data_exploration.sql)

**Dataset:** [Alex The Analyst - Portfolio Projects](https://github.com/AlexTheAnalyst/PortfolioProjects) | Tables: `CovidDeaths` + `CovidVaccination`

#### Overview
End-to-end exploratory analysis of global COVID-19 data covering deaths, infection rates, and vaccination progress across 200+ countries using two joined datasets.

#### SQL Techniques Used
- `JOIN` across two large tables on location and date
- `CTE` (Common Table Expressions) for multi-step aggregations
- `ROW_NUMBER() OVER (PARTITION BY ...)` for latest-record isolation
- `EXISTS` subquery to filter continents from country-level data
- `CAST`, `NULLIF` for safe division and type conversion
- `FORMAT` for readable number output
- Aggregate functions: `MAX`, `SUM`, `AVG`, `COUNT`

#### Key Queries
| Query | Purpose |
|---|---|
| Death rate by population | Total deaths / population per country |
| Infection rate by population | Total cases / population over time |
| Death-to-case ratio | Likelihood of dying if infected |
| Max infection rate per country | Country-level peak infection ranking |
| Rolling vaccination rate | % of population vaccinated over time |
| Max fully vaccinated % | Countries with highest full vaccination coverage |

#### Key Findings
- Countries with highest death-per-case ratios were concentrated in regions with limited healthcare access
- Vaccination completeness data was sparse: only ~20-40% of rows had non-null vaccination figures for many countries
- North America and Europe showed the highest max vaccination rates relative to population

---

### 2. Nashville Housing Data Cleaning

**File:** [`Nashville-Housing-Data-Cleaning/nashville_data_cleaning.sql`](./Nashville-Housing-Data-Cleaning/nashville_data_cleaning.sql)

**Dataset:** [Alex The Analyst - Portfolio Projects](https://github.com/AlexTheAnalyst/PortfolioProjects) | Table: `NashvilleHousingData`

#### Overview
A complete data cleaning workflow applied to a Nashville real estate dataset. Demonstrates industry-standard SQL techniques for preparing raw data for analysis.

#### SQL Techniques Used
- `ALTER TABLE / UPDATE` for column creation and value transformation
- `CASE` statement for binary value standardization (Y/N to Yes/No)
- `ISNULL` with self-`JOIN` to fill NULL property addresses using matching ParcelIDs
- `SUBSTRING` + `CHARINDEX` to split combined address fields
- `PARSENAME` + `REPLACE` to parse owner address into street, city, state
- `ROW_NUMBER() OVER (PARTITION BY ...))` inside a CTE to identify and delete duplicate rows
- `DROP COLUMN` to remove redundant fields after cleaning

#### Cleaning Steps Performed
| Step | Technique | Column(s) Affected |
|---|---|---|
| 1. Standardize date format | `TRY_CONVERT` | SaleDate |
| 2. Standardize binary values | `CASE` / `REPLACE` | SoldAsVacant |
| 3. Fill NULL addresses | Self-`JOIN` + `ISNULL` | PropertyAddress |
| 4. Split address fields | `SUBSTRING` + `CHARINDEX` | PropertyAddress -> Street + City |
| 5. Parse owner address | `PARSENAME` + `REPLACE` | OwnerAddress -> Street + City + State |
| 6. Remove duplicates | `ROW_NUMBER()` CTE + `DELETE` | All columns |
| 7. Drop unused columns | `DROP COLUMN` | TaxDistrict, redundant columns |

---

## File Structure

```
SQL-Projects/
|
+-- COVID-19-Data-Exploration/
|   +-- CovidDeaths.xlsx          <- Source dataset (deaths & cases)
|   +-- CovidVaccinations.xlsx    <- Source dataset (vaccinations)
|   +-- covid_data_exploration.sql
|
+-- Nashville-Housing-Data-Cleaning/
|   +-- nashville_data_cleaning.sql
|
+-- README.md
```

---

## How to Run

1. Import the dataset files into **Microsoft SQL Server** or **Azure Data Studio**
2. Create a database and import `CovidDeaths.xlsx` and `CovidVaccinations.xlsx` as tables
3. Open the `.sql` file and run queries section by section (each is labeled)
4. For the Nashville project, ensure `NashvilleHousingData` table is loaded before running

---

## About

**Amin Amirkhalili**
Aspiring Business & Data Analyst | SQL . Excel . Power BI . Python
Location: St. John's / Toronto, Canada
GitHub: https://github.com/sedaming
LinkedIn: https://www.linkedin.com/in/sedamin/

---

*More SQL projects coming soon.*
