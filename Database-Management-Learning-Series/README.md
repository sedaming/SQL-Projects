# Database Management & SQL — A Practical Learning Series

![Tool](https://img.shields.io/badge/Tool-SQL%20Server%20(T--SQL)-CC2927?style=flat&logo=microsoft-sql-server&logoColor=white)
![Practice](https://img.shields.io/badge/Practice-Google%20Colab%20%2B%20SQLite-F9AB00?style=flat&logo=googlecolab&logoColor=white)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![Type](https://img.shields.io/badge/Type-Learning%20Series-blue)
![Location](https://img.shields.io/badge/Location-Canada-red)

A hands-on learning series on **database management and design** — from understanding business needs, through conceptual modelling (UML), all the way to writing SQL on real databases. Based on *Database Management and Design* (Gove Allen, PhD · Gary Hansen, PhD · Robert Jackson, PhD).

Each topic comes in two formats:

- 📖 **Reading copy** (Word document) — full theory with figures and examples
- ▶️ **Practice notebook** (Google Colab) — the same content with **live, runnable SQL**: one click, no installation, a built-in sample database

---

## Series Roadmap

| # | Notebook | Read | Practice (live code) |
|---|----------|------|----------------------|
| **1 — Fundamentals** | | | |
| 1 | Introduction: The Database Is the Heart of Information Systems | [Word](reading-copies/Notebook-1-Introduction.docx) | — (theory only) |
| **2 — Database Management** | | | |
| 2.1 | Conceptual Data Model: From Conceptual Design to a Relational Model | [Word](reading-copies/Notebook-2.1-Conceptual-Data-Model.docx) | — (theory only) |
| 2.2 | Database Design: From Schema Creation to Data Management | [Word](reading-copies/Notebook-2.2-Database-Design.docx) | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/sedaming/SQL-Projects/blob/main/Database-Management-Learning-Series/notebooks/Notebook-2.2-Database-Design-PRACTICE.ipynb) |
| **3 — SQL & Data Analysis** | | | |
| 3.1 | Beginner: SELECT, FROM, WHERE, ORDER BY | [Word](reading-copies/Notebook-3.1-SQL-Beginner.docx) | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/sedaming/SQL-Projects/blob/main/Database-Management-Learning-Series/notebooks/Notebook-3.1-SQL-Beginner-PRACTICE.ipynb) |
| 3.2 | Intermediate: Functions, GROUP BY, HAVING | [Word](reading-copies/Notebook-3.2-SQL-Intermediate.docx) | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/sedaming/SQL-Projects/blob/main/Database-Management-Learning-Series/notebooks/Notebook-3.2-SQL-Intermediate-PRACTICE.ipynb) |
| 3.3 | Advanced I: Joining Tables — Inner & Outer Joins | [Word](reading-copies/Notebook-3.3-SQL-Advanced-I-Joins.docx) | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/sedaming/SQL-Projects/blob/main/Database-Management-Learning-Series/notebooks/Notebook-3.3-SQL-Advanced-I-Joins-PRACTICE.ipynb) |
| 3.4 | Advanced II: Subqueries, Views, Temp Tables, CTEs | [Word](reading-copies/Notebook-3.4-SQL-Advanced-II.docx) | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/sedaming/SQL-Projects/blob/main/Database-Management-Learning-Series/notebooks/Notebook-3.4-SQL-Advanced-II-PRACTICE.ipynb) |
| 3.5 | Data Cleaning with SQL | *coming soon* | *coming soon* |
| **4 — Data Mining** | | | |
| 4.1 | SQL in Data Mining | *coming soon* | *coming soon* |

📎 See the [Book Coverage Map](reading-copies/Book-Coverage-Map.docx) for exactly which textbook chapters and sections each notebook covers.

---

## SQL Techniques Covered

- **DDL / DML:** `CREATE TABLE` (keys, constraints, `ON DELETE` options), `ALTER TABLE`, `DROP`, `INSERT`, `UPDATE`, `DELETE`, archiving patterns
- **Querying:** `SELECT`, `WHERE`, `ORDER BY`, `DISTINCT`, operator precedence with `AND`/`OR`
- **Aggregation:** `GROUP BY`, `HAVING`, aggregate & string functions, `PARTITION BY` window functions
- **Joins:** inner, left/right/full outer, self-joins, multi-table joins, join pitfalls
- **Advanced:** correlated & non-correlated subqueries, `IN` vs `EXISTS`, views, temp tables, CTEs, `ROW_NUMBER() OVER (PARTITION BY ...)`

---

## How to Run

1. Click any **Open in Colab** badge above (Google account required — nothing to install)
2. Run the first cell — it builds a small practice database (SQLite) with the tables used in the series
3. Run each query cell as you read; change the queries and experiment
4. To start fresh, just re-run the setup cell

> **Note on dialects:** the reading copies use **SQL Server (T-SQL)** syntax; the practice notebooks run on **SQLite** (built into Colab). Wherever the two differ (`TOP` vs `LIMIT`, `+` vs `||`, `#temp` vs `CREATE TEMP TABLE`), the notebook shows both versions.

---

## File Structure

```
Database-Management-Learning-Series/
|
+-- notebooks/                        <- Live practice notebooks (Colab)
|   +-- Notebook-2.2-Database-Design-PRACTICE.ipynb
|   +-- Notebook-3.1-SQL-Beginner-PRACTICE.ipynb
|   +-- Notebook-3.2-SQL-Intermediate-PRACTICE.ipynb
|   +-- Notebook-3.3-SQL-Advanced-I-Joins-PRACTICE.ipynb
|   +-- Notebook-3.4-SQL-Advanced-II-PRACTICE.ipynb
|
+-- reading-copies/                   <- Full theory (Word documents)
|   +-- Notebook-1-Introduction.docx
|   +-- Notebook-2.1-Conceptual-Data-Model.docx
|   +-- Notebook-2.2-Database-Design.docx
|   +-- Notebook-3.1-SQL-Beginner.docx
|   +-- Notebook-3.2-SQL-Intermediate.docx
|   +-- Notebook-3.3-SQL-Advanced-I-Joins.docx
|   +-- Notebook-3.4-SQL-Advanced-II.docx
|   +-- Notebook-3.5-Data-Cleaning.docx        (in progress)
|   +-- Notebook-4.1-SQL-in-Data-Mining.docx   (in progress)
|   +-- Book-Coverage-Map.docx
|
+-- README.md
```

---

## About

**Amin Amirkhalili** Aspiring Business & Data Analyst | SQL . Excel . Power BI . Python
Location: St. John's / Toronto, Canada
GitHub: <https://github.com/sedaming> LinkedIn: <https://www.linkedin.com/in/sedamin/>

---

*Notebooks 3.5 (Data Cleaning) and 4.1 (SQL in Data Mining) coming soon.*
