{{ config(materialized='view', schema='silver') }}

SELECT
    *,
    CONCAT(firstname, ' ', lastname) AS fullname,
    UPPER(firstname) AS firstNameUpper
FROM {{ source('bronze', 'customers') }}