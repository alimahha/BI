-- Revenu réel vs objectif de ventes, par magasin

-- 1. Revenu réel : on agrège les faits commandes par magasin
WITH revenue_by_store AS (
    SELECT
        storeid,
        SUM(nb_orders)    AS nb_orders,
        SUM(total_amount) AS revenue
    FROM {{ ref('fact_orders') }}
    GROUP BY storeid
),

-- 2. Objectifs : le seed salestarget (CSV chargé avec dbt seed)
targets AS (
    SELECT
        StoreID     AS storeid,
        SalesTarget AS sales_target
    FROM {{ ref('salestarget') }}
)

-- 3. On rapproche les deux et on calcule l'écart
SELECT
    t.storeid,
    COALESCE(r.nb_orders, 0)                                AS nb_orders,
    COALESCE(r.revenue, 0)                                  AS revenue,
    t.sales_target,
    COALESCE(r.revenue, 0) - t.sales_target                 AS ecart,
    ROUND(COALESCE(r.revenue, 0) * 100 / t.sales_target, 2) AS taux_atteinte_pct
FROM targets t
LEFT JOIN revenue_by_store r
    ON r.storeid = t.storeid
