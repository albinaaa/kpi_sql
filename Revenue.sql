-- 1. Выручка за период

DECLARE @DateFrom date = '2013-01-01';
DECLARE @DateTo date = '2013-12-31';

SELECT
    SUM(TotalDue) AS Revenue
FROM Sales.SalesOrderHeader
WHERE OrderDate >= @DateFrom
  AND OrderDate < DATEADD(day, 1, @DateTo);
