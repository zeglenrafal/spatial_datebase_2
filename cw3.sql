USE AdventureWorksDW2019;
GO

CREATE OR ALTER PROCEDURE dbo.GetCurrencyRatesYearsAgo
    @YearsAgo INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateLimit DATE;
    SET @DateLimit = DATEADD(YEAR, -@YearsAgo, CAST(GETDATE() AS DATE));

    SELECT
        f.CurrencyKey,
        d.CurrencyAlternateKey,
        f.Date AS CurrencyDate,
        f.AverageRate,
        f.EndOfDayRate
    FROM dbo.FactCurrencyRate AS f
    INNER JOIN dbo.DimCurrency AS d
        ON f.CurrencyKey = d.CurrencyKey
    WHERE
        d.CurrencyAlternateKey IN ('GBP', 'EUR')
        AND f.Date <= @DateLimit
    ORDER BY
        f.Date;
END;
GO
