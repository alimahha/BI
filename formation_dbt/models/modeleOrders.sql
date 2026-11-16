{{ config(materialized='view', schema='silver') }}

SELECT *,
    CASE status
        WHEN '01' THEN 'En cours'
        WHEN '02' THEN 'Terminée'
        WHEN '03' THEN 'Annulée'
    END AS StatusDescription
FROM {{ source('bronze', 'orders') }}