<div align="center">

<img src="logo.png" alt="Database 1 Logo" width="120" />

# Database 1 — SQL Server Coursework

**Personal notes, in-class practice, and assignments for the Database 1 course (SQL Server / T-SQL).**

[![SQL Server](https://img.shields.io/badge/SQL_Server-T--SQL-CC2927?logo=microsoftsqlserver&logoColor=white)](https://learn.microsoft.com/en-us/sql/t-sql/)
[![Database Design](https://img.shields.io/badge/Topic-Database_Design-4479A1?logo=databricks&logoColor=white)](#)
[![Status](https://img.shields.io/badge/Status-Actively_Updated-2E7D32)](#)

</div>

---

## 📁 Structure

| Folder | Content |
|---|---|
| [`Lectures/`](./Lectures) | Main lecture scripts — schema design and query walkthroughs |
| [`Sections/`](./Sections) | TA / recitation section scripts |
| [`Reviews/`](./Reviews) | Cumulative review scripts covering multiple topics |
| [`Practice/`](./Practice) | Self-study practice scripts |
| [`Assignments/`](./Assignments) | Graded homework assignments |
| [`Labs/`](./Labs) | Lab task sheets (PDF) |

## 📚 Lectures

| File | Topic |
|---|---|
| `LEC_09.sql` | Joins — INNER / LEFT / RIGHT / FULL, multi-table joins |
| `LEC_10.sql` | Joins practice (car rental schema) + Aggregate functions (`SUM`, `COUNT`, `MIN`, `MAX`, `AVG`, `GROUP BY`, `HAVING`) |

## 🧑‍🏫 Sections

| File | Topic |
|---|---|
| `SEC_03.sql` | ER diagram → relational schema (Hospital system) |
| `SEC_04.sql` | `ALTER TABLE`, constraints (`CHECK`/`UNIQUE`/`FK`), DML, `ON DELETE CASCADE`, `sp_rename`, joins |
| `SEC_05.sql` | Streaming platform schema + `ALTER TABLE` + `UPDATE`/`DELETE` |
| `SEC_08.sql` | Subqueries — scalar, `IN`, `ANY`/`ALL`, correlated, `EXISTS`, derived tables |

## 🔁 Reviews

| File | Topic |
|---|---|
| `REV_01.sql` | Comprehensive review — constraints, `ALTER TABLE`, DDL/DML across multiple schemas |
| `REV_02.sql` | `SELECT` basics, `WHERE`/`LIKE` patterns, `ORDER BY` + `LEFT`/`RIGHT`/`FULL JOIN` |

## 📝 Practice

| File | Topic |
|---|---|
| `PRA_01_Multi_Schema.sql` | Hotel booking, product inventory, university, airline schemas |
| `PRA_02_Students_Basics.sql` | `SELECT`, `WHERE`, `IN`, `BETWEEN`, `ORDER BY`, `GROUP BY` |
| `PRA_03_Departments_Courses.sql` | Departments/Students with FK constraints; `CHECK`/`DEFAULT`/`IDENTITY` |

## ✅ Notes on this cleanup

- Files were renamed for consistency (e.g. `LEC9.sql` → `LEC_09.sql`, `Section3.sql` → `SEC_03.sql`).
- A duplicate file (`SQLQuery2.sql`, identical to `DB_1.sql`) was removed.
- A few genuine syntax bugs (trailing commas before a closing `)` in `CREATE TABLE`, and one table-name mismatch in `Practice/PRA_01_Multi_Schema.sql`) were fixed so the scripts run end-to-end.
- Query logic and table/column names from the original coursework were otherwise left untouched.
