{{ config(materialized='view') }}

SELECT
    *,
    CONCAT(firstname, ' ', lastname) AS fullname,
    UPPER(firstname) AS firstNameUpper
FROM bronze.customers