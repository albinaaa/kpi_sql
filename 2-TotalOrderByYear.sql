-- 2. Сравнение годового количества заказов с предыдущим периодом

WITH OrdersByYear AS
(
    SELECT
        YEAR(OrderDate) AS [Год],
        COUNT(*) AS [Количество заказов]
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate)
)

SELECT
    CurrentYear.[Год],
    CurrentYear.[Количество заказов],
    PreviousYear.[Количество заказов] AS [Заказы за предыдущий год],
    CurrentYear.[Количество заказов] - PreviousYear.[Количество заказов] AS [Изменение количества заказов],
    CAST(
        (CurrentYear.[Количество заказов] - PreviousYear.[Количество заказов]) * 100.0
        / NULLIF(PreviousYear.[Количество заказов], 0)
        AS DECIMAL(10,2)
    ) AS [Темп роста, %]
FROM OrdersByYear AS CurrentYear
LEFT JOIN OrdersByYear AS PreviousYear
    ON CurrentYear.[Год] = PreviousYear.[Год] + 1
WHERE CurrentYear.[Год] = 2013;