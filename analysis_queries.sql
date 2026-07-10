USE crm_sales_opportunities;

SELECT DATABASE() AS current_database;
-- 1. Clean up the temporary table if it already exists from a previous run
DROP TEMPORARY TABLE IF EXISTS temp_base;

-- 2. Create the temporary table using your base logic
-- base CTE using for all the others
CREATE TEMPORARY TABLE temp_base AS
WITH base AS (
  SELECT
      sp.sales_agent,
      st.regional_office,
      CASE WHEN sp.product = 'GTXPro' THEN 'GTX Pro' ELSE sp.product END AS product,
      p.series,
      a.sector,
      sp.deal_stage,
      sp.close_value
  FROM sales_pipeline sp
  JOIN sales_teams st ON sp.sales_agent = st.sales_agent
  JOIN products p  ON sp.product = p.product
  LEFT JOIN accounts a ON sp.account = a.account
  WHERE sp.deal_stage IN ('Won','Lost')
)

select * from base

-- By region

SELECT regional_office, 
       SUM(CASE WHEN deal_stage='Won' THEN close_value ELSE 0 END) AS total_won_revenue
FROM temp_base GROUP BY regional_office

-- By product

select series, 
       sum(case when deal_stage = 'Won' then close_value else 0 end) as total_won_revenue
from temp_base 
group by series

-- lead agent
select
    sales_agent,
    sum(case when deal_stage = 'Won' then close_value else 0 end) as total_won_revenue,
    round(
        sum(case when  deal_stage = 'Won' then 1 else 0 end) / COUNT(*) * 100,
        2
    ) as win_rate
from temp_base
group by sales_agent

-- by sector

select sector,
       sum(case when deal_stage = 'Won' then close_value else 0 end) as total_won_revenue
from temp_base
group by sector



