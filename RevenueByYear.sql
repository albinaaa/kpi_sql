-- 1. Сравнение годовой выручки с предыдущим периодом

DECLARE @Year int = 2013;

WITH RevenueByYear AS
(
    SELECT
        YEAR(OrderDate) AS [Ãîä],
        SUM(TotalDue) AS [Âûðó÷êà]
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate)
)

SELECT
    CurrentYear.[Ãîä],
    CAST(CurrentYear.[Âûðó÷êà] AS DECIMAL(18,2)) AS [Âûðó÷êà],
    CAST(PreviousYear.[Âûðó÷êà] AS DECIMAL(18,2)) AS [Âûðó÷êà çà ïðåäûäóùèé ãîä],
    CAST(CurrentYear.[Âûðó÷êà] - PreviousYear.[Âûðó÷êà] AS DECIMAL(18,2)) AS [Èçìåíåíèå âûðó÷êè],
    CAST(
        (CurrentYear.[Âûðó÷êà] - PreviousYear.[Âûðó÷êà]) * 100.0
        / NULLIF(PreviousYear.[Âûðó÷êà], 0)
        AS DECIMAL(10,2)
    ) AS [Òåìï ðîñòà, %]
FROM RevenueByYear AS CurrentYear
LEFT JOIN RevenueByYear AS PreviousYear
    ON CurrentYear.[Ãîä] = PreviousYear.[Ãîä] + 1
WHERE CurrentYear.[Ãîä] = @Year;
