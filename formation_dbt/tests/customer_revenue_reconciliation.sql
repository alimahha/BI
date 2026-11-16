-- Le revenu total et le nombre de commandes doivent égaler ceux de fact_orders
WITH cr AS (
    SELECT SUM(nb_orders) AS cr_nb, SUM(revenue) AS cr_amt FROM {{ ref('customer_revenue') }}
),
fo AS (
    SELECT SUM(nb_orders) AS fo_nb, SUM(total_amount) AS fo_amt FROM {{ ref('fact_orders') }}
)
SELECT cr_nb, fo_nb, cr_amt, fo_amt
FROM cr, fo
WHERE cr_nb <> fo_nb OR cr_amt <> fo_amt
