-- Une seule ligne par combinaison client / employé / magasin / statut
SELECT customerid, employeeid, storeid, status, COUNT(*) AS nb
FROM {{ ref('fact_orders') }}
GROUP BY customerid, employeeid, storeid, status
HAVING COUNT(*) > 1
