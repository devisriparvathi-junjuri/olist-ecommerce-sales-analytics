# Project Architecture

## Architecture Overview

```text
                 Olist E-commerce Dataset
                           │
                           ▼
                   PostgreSQL Database
                           │
        ┌──────────────────┼──────────────────┐
        ▼                  ▼                  ▼
     raw Schema      analytics Schema   reporting Schema
                           │
                           ▼
                    SQL Data Analysis
                           │
                           ▼
                   Business Insights
                           │
                           ▼
                  Tableau Dashboard
                           │
                           ▼
                    Executive Reports
```

---

## Workflow

```
Dataset
   ↓
Database Design
   ↓
Table Creation
   ↓
Data Import
   ↓
Data Validation
   ↓
Business Analysis
   ↓
Advanced SQL
   ↓
Dashboard
   ↓
Documentation
```

---

## Technology Stack

| Component       | Technology    |
|-----------------|---------------|
| Database        | PostgreSQL 18 |
| Database Client | pgAdmin 4     |
| Development     | VS Code       |
| SQL             | PostgreSQL    |
| ER Diagram      | dbdiagram.io  |
| Dashboard       | Tableau Public|
| Version Control | Git & GitHub  |