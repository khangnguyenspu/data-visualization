### CRM Sales Opportunities Dashboard

A SQL and Tableau sales analytics project that transforms CRM opportunity data into an interactive dashboard. The analysis compares won revenue across products, regions, sales agents, and customer sectors while measuring agent win rates and product sales.
Project Goals

* Build a relational MySQL database from CRM CSV files.
* Clean and join sales pipeline, product, account, and sales-team data.
* Calculate sales performance metrics using SQL.
* Export query results for visualization.
* Create a Tableau dashboard for business decision-making.

Key Metrics

* Total Won Revenue: Revenue from opportunities with a Won deal stage.
* Win Rate: Percentage of completed opportunities that were won.
* Units Sold: Number of won opportunities by product.
* Revenue by Product Series: Won revenue grouped into GTK, GTX, and MG.
* Revenue by Region: Won revenue across Central, East, and West offices.
* Revenue by Sector: Won revenue generated from each customer industry.
* Lead Agent Performance: Comparison of agent win rate and total won revenue.

Dashboard Highlights

* GTX generated the most won revenue at approximately $3.83 million.
* West was the highest-performing region with approximately $2.45 million in won revenue.
* Retail was the strongest customer sector with approximately $1.21 million in won revenue.
* Darcel Schlecht generated the highest won revenue among the displayed agents at $380,085.
* Hayden Neloms had the highest displayed win rate at 70.39%.
* MG Special was the top-selling product with 41,094 units sold.

crm-sales-opportunities/
├── README.md
├── dashboard.jpeg
├── import_crm_sales.sql
├── analysis_queries.sql
├── queries.sql
├── schema_diagram.md
├── byproducts.csv
├── byregion.csv
├── bysectors.csv
└── leadAgents.csv
