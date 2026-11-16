-- Le test échoue s'il renvoie des lignes :
-- le nombre de commandes et le montant total du fact doivent égaler la source.
WITH fact AS (
    SELECT SUM(nb_orders) AS nb, SUM(total_amount) AS amt
    FROM {{ ref('fact_orders') }}
),
src AS (
    SELECT
        (SELECT COUNT(*) FROM {{ source('bronze', 'orders') }}) AS nb,
        (SELECT SUM(quantity * unitprice) FROM {{ source('bronze', 'orderitems') }}) AS amt
)
SELECT fact.nb AS fact_nb, src.nb AS src_nb, fact.amt AS fact_amt, src.amt AS src_amt
FROM fact, src
WHERE fact.nb <> src.nb OR fact.amt <> src.amt
