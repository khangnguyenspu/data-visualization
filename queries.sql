USE crm_sales_opportunities;

SELECT DATABASE() AS current_database;

SELECT COUNT(*) AS sales_pipeline_rows
FROM sales_pipeline;

SELECT *
FROM sales_pipeline
LIMIT 20;

SELECT
    deal_stage,
    COUNT(*) AS opportunities,
    SUM(close_value) AS total_value
FROM sales_pipeline
GROUP BY deal_stage
ORDER BY opportunities DESC;

SELECT
    st.regional_office,
    COUNT(*) AS opportunities,
    SUM(sp.close_value) AS total_value
FROM sales_pipeline sp
JOIN sales_teams st
    ON sp.sales_agent = st.sales_agent
GROUP BY st.regional_office
ORDER BY total_value DESC;

SELECT
    p.series,
    COUNT(*) AS opportunities,
    SUM(sp.close_value) AS total_value
FROM sales_pipeline sp
JOIN products p
    ON sp.product = p.product
GROUP BY p.series
ORDER BY total_value DESC;
