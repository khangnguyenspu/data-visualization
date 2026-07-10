# CRM Sales Opportunities Schema Diagram

```mermaid
erDiagram
    ACCOUNTS ||--o{ SALES_PIPELINE : "account"
    PRODUCTS ||--o{ SALES_PIPELINE : "product"
    SALES_TEAMS ||--o{ SALES_PIPELINE : "sales_agent"

    ACCOUNTS {
        varchar account PK
        varchar sector
        int year_established
        decimal revenue
        int employees
        varchar office_location
        varchar subsidiary_of
    }

    PRODUCTS {
        varchar product PK
        varchar series
        decimal sales_price
    }

    SALES_TEAMS {
        varchar sales_agent PK
        varchar manager
        varchar regional_office
    }

    SALES_PIPELINE {
        varchar opportunity_id PK
        varchar sales_agent FK
        varchar product FK
        varchar account FK
        varchar deal_stage
        date engage_date
        date close_date
        decimal close_value
    }

    DATA_DICTIONARY {
        varchar source_table
        varchar field_name
        varchar description
    }
```

## Relationship Summary

| Table | Primary Key |
| --- | --- |
| accounts | account |
| products | product |
| sales_teams | sales_agent |
| sales_pipeline | opportunity_id |

| Foreign Key | References |
| --- | --- |
| sales_pipeline.account | accounts.account |
| sales_pipeline.product | products.product |
| sales_pipeline.sales_agent | sales_teams.sales_agent |

`data_dictionary` explains the CSV columns. It does not need a foreign key relationship for basic importing.
