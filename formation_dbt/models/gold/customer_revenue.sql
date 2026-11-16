-- Nombre de commandes et revenu par client (tous employés / magasins / statuts confondus)
WITH orders_by_customer AS (
    SELECT
        customerid,
        SUM(nb_orders)    AS nb_orders,
        SUM(total_amount) AS revenue
    FROM {{ ref('fact_orders') }}
    GROUP BY customerid
)

SELECT
    c.customerid,
    c.fullname,
    COALESCE(o.nb_orders, 0) AS nb_orders,
    COALESCE(o.revenue, 0)   AS revenue
FROM {{ ref('modeleCustomer') }} c
LEFT JOIN orders_by_customer o
    ON c.customerid = o.customerid
