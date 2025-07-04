# SQL Server Window Functions – Use Cases and Examples

This repository contains a comprehensive set of **Window Function examples in Microsoft SQL Server**, along with sample datasets and a reference PDF. It is designed to help viewers understand and apply SQL Server's analytic capabilities using `OVER()` and related functions.

## 📁 Project Contents

- `Window function.sql`:  
  A complete SQL script for MS SQL Server that includes:
  - Sample data creation using `CREATE TABLE` and `INSERT INTO`
  - Practical examples demonstrating various window functions

- `Aggregate_Analytical_Functions.pdf`:  
  A compact reference guide summarizing the syntax and use cases of SQL Server window functions.

## ✅ Features & Use Cases Covered

This project demonstrates how to use:

### Ranking & Row Numbering
- `ROW_NUMBER()`  
- `RANK()`  
- `DENSE_RANK()`  

### Value Access
- `LAG()`  
- `LEAD()`  
- `FIRST_VALUE()`  
- `LAST_VALUE()`  

### Aggregation Over Windows
- `SUM()`  
- `AVG()`  
- `MIN()` / `MAX()`  
- Running totals, Rolling total  
- Moving averages  

### Partitioning & Ordering
- `PARTITION BY` and `ORDER BY` within the `OVER()` clause to define logical data windows

## 💻 Getting Started

1. Open **Microsoft SQL Server Management Studio (SSMS)** or any compatible SQL Server IDE.
2. Run the `window_functions_examples.sql` file to create and populate the sample tables.
3. Execute individual queries to observe how different window functions behave.
4. Refer to the `SQL_Window_Functions_Reference.pdf` for quick syntax tips and theoretical understanding.


## 📚 References

- [Microsoft SQL Server Docs – Window Functions](https://learn.microsoft.com/en-us/sql/t-sql/queries/select-over-clause-transact-sql)
- [SQL Server Tutorial – Window Functions](https://www.sqlservertutorial.net/sql-server-window-functions/)

---

🔄 **Feel free to fork, clone, or contribute** to make this even more comprehensive!
