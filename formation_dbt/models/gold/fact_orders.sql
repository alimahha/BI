-- Montant total de chaque commande (somme des lignes)
WITH order_totals AS (
    SELECT
        orderid,
        SUM(TotalPrice) AS order_amount
    FROM {{ ref('OrdersItems') }}
    GROUP BY orderid
)

SELECT
    o.customerid,
    o.employeeid,
    o.storeid,
    o.status,
    o.StatusDescription,
    COUNT(o.orderid)                  AS nb_orders,
    COALESCE(SUM(t.order_amount), 0)  AS total_amount
FROM {{ ref('modeleOrders') }} o
LEFT JOIN order_totals t
    ON o.orderid = t.orderid
GROUP BY
    o.customerid,
    o.employeeid,
    o.storeid,
    o.status,
    o.StatusDescription
