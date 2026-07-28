-- 2. Количество заказов за период

DECLARE @DateFrom date = '2013-01-01';
DECLARE @DateTo date = '2013-12-31';

SELECT
    COUNT(*) AS [Количество заказов]
FROM Sales.SalesOrderHeader
WHERE OrderDate >= @DateFrom
  AND OrderDate < DATEADD(day, 1, @DateTo);