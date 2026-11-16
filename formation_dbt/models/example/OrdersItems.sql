{{ config(materialized='view', schema='silver') }}

SELECT *, quantity*unitprice AS TotalPrice
FROM bronze.orderitems