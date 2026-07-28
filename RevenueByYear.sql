DECLARE @Year int = 2013;

WITH RevenueByYear AS
(
    SELECT
        YEAR(OrderDate) AS [Год],
        SUM(TotalDue) AS [Выручка]
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate)
)

SELECT
    CurrentYear.[Год],
    CAST(CurrentYear.[Выручка] AS DECIMAL(18,2)) AS [Выручка],
    CAST(PreviousYear.[Выручка] AS DECIMAL(18,2)) AS [Выручка за предыдущий год],
    CAST(CurrentYear.[Выручка] - PreviousYear.[Выручка] AS DECIMAL(18,2)) AS [Изменение выручки],
    CAST(
        (CurrentYear.[Выручка] - PreviousYear.[Выручка]) * 100.0
        / NULLIF(PreviousYear.[Выручка], 0)
        AS DECIMAL(10,2)
    ) AS [Темп роста, %]
FROM RevenueByYear AS CurrentYear
LEFT JOIN RevenueByYear AS PreviousYear
    ON CurrentYear.[Год] = PreviousYear.[Год] + 1
WHERE CurrentYear.[Год] = @Year;