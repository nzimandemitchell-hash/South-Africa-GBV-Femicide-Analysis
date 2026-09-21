SELECT *
FROM GBV_data;

SELECT * 
FROM Femicide_data;


-- FINDING DUPLICATES -----------

SELECT *,
       COUNT(*) OVER (
           PARTITION BY ID
       ) AS Duplicate_Count
FROM GBV_data


SELECT *,
       COUNT(*) OVER (
           PARTITION BY ID
       ) AS Duplicate_Count
FROM Femicide_data;


-- GBV NULL CHECK ------
SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Province IS NULL THEN 1 ELSE 0 END) AS Missing_Province,
    SUM(CASE WHEN Financial_Year IS NULL THEN 1 ELSE 0 END) AS Missing_Financial_Year,
    SUM(CASE WHEN Calendar_Month IS NULL THEN 1 ELSE 0 END) AS Missing_Month,
    SUM(CASE WHEN Total_Selected_GBV_Reports IS NULL THEN 1 ELSE 0 END) AS Missing_GBV_Total
FROM GBV_data;


-- Femicide NULL CHECK -------

SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Province IS NULL THEN 1 ELSE 0 END) AS Missing_Province,
    SUM(CASE WHEN Financial_Year IS NULL THEN 1 ELSE 0 END) AS Missing_Financial_Year,
    SUM(CASE WHEN Calendar_Month IS NULL THEN 1 ELSE 0 END) AS Missing_Month,
    SUM(CASE WHEN Analytical_Femicide_Count IS NULL THEN 1 ELSE 0 END) AS Missing_Femicide_Count
FROM Femicide_data;



---GBV OVERVIEW --

SELECT
    SUM(Women_murdered) AS Women_Murdered,
    SUM(Attempted_Women_murder) AS Attempted_Women_Murder,
    SUM(Rape_Reported) AS Rape_Reported,
    SUM(Sexual_Assault_Reported) AS Sexual_Assault_Reported,
    SUM(Assault_GBH_Women) AS Assault_GBH_Women,
    SUM(Common_Assault_Women_18Plus) AS Common_Assault_Women_18Plus,
    SUM(Total_Selected_GBV_Reports) AS Total_GBV_Reports
FROM GBV_data;

--- GBV BY PROVINCE --- 

SELECT
    Province,
    SUM(Total_Selected_GBV_Reports) AS Total_GBV_Reports
FROM GBV_data
GROUP BY Province
ORDER BY Total_GBV_Reports DESC;




--- PROVINCIAL SHARE OF NATIONAL GBV ---

WITH Provincial_GBV AS
(
    SELECT
        Province,
        SUM(Total_Selected_GBV_Reports) AS Total_GBV_Reports
    FROM GBV_data
    GROUP BY Province
)

SELECT
    Province,
    Total_GBV_Reports,
    ROUND(
        100.0 * Total_GBV_Reports /
        SUM(Total_GBV_Reports) OVER (),
        2
    ) AS Percentage_of_National_GBV
FROM Provincial_GBV
ORDER BY Total_GBV_Reports DESC;



--- PROVINCIAL RANKING ---

WITH Provincial_GBV AS
(
    SELECT
        Province,
        SUM(Total_Selected_GBV_Reports) AS Total_GBV_Reports
    FROM GBV_data
    GROUP BY Province
)

SELECT
    Province,
    Total_GBV_Reports,
    RANK() OVER (
        ORDER BY Total_GBV_Reports DESC
    ) AS Province_Rank
FROM Provincial_GBV
ORDER BY Province_Rank;



---  FEMICIDE BY PROVINCE AND FINANCIAL YEAR --- 

SELECT
    Province,
    Financial_Year,
    SUM(Analytical_Femicide_Count) AS Total_Femicide
FROM Femicide_data
GROUP BY
    Province,
    Financial_Year
ORDER BY
    Province,
    Financial_Year;


---  FEMICIDE METHODS ----


SELECT
    SUM(Firearm) AS Firearm,
    SUM(Sharp_Instrument) AS Sharp_Instrument,
    SUM(Blunt_Force) AS Blunt_Force,
    SUM(Other_Method) AS Other_Method
FROM Femicide_data;



--- CASE OUTCOMES --- 

SELECT
    SUM(Analytical_Femicide_Count) AS Total_Femicide,
    SUM(Cases_Solved_or_Charged) AS Cases_Solved_or_Charged,
    SUM(Convictions_Recorded) AS Convictions_Recorded,

    ROUND(
        100.0 * SUM(Cases_Solved_or_Charged)
        / NULLIF(SUM(Analytical_Femicide_Count), 0),
        2
    ) AS Solved_or_Charged_Percentage,

    ROUND(
        100.0 * SUM(Convictions_Recorded)
        / NULLIF(SUM(Analytical_Femicide_Count), 0),
        2
    ) AS Conviction_Percentage

FROM Femicide_data;



  --- PROVINCIAL GBV + FEMICIDE SUMMARY ----
 

SELECT
    g.Province,

    SUM(g.Total_Selected_GBV_Reports) AS Total_GBV_Reports,

    SUM(g.Rape_Reported) AS Total_Rape_Reports,

    SUM(g.Sexual_Assault_Reported) AS Total_Sexual_Assault,

    SUM(g.Assault_GBH_Women) AS Total_Assault_GBH,

    SUM(f.Analytical_Femicide_Count) AS Total_Femicide

FROM GBV_data g

LEFT JOIN Femicide_data f
    ON g.Province_Code = f.Province_Code
    AND g.Financial_Year = f.Financial_Year
    AND g.Calendar_Month = f.Calendar_Month

GROUP BY g.Province

ORDER BY Total_GBV_Reports DESC;



--- GBV VS FEMICIDE YEARLY TREND
 

SELECT
    g.Financial_Year,

    SUM(g.Total_Selected_GBV_Reports) AS Total_GBV_Reports,

    SUM(f.Analytical_Femicide_Count) AS Total_Femicide

FROM GBV_data g

LEFT JOIN Femicide_data f
    ON g.Province_Code = f.Province_Code
    AND g.Financial_Year = f.Financial_Year
    AND g.Calendar_Month = f.Calendar_Month

GROUP BY g.Financial_Year

ORDER BY g.Financial_Year;


--- GBV + FEMICIDE ANALYTICAL VIEW


CREATE VIEW vw_GBV_Femicide_Analytics
AS

WITH GBV_Monthly AS
(
    SELECT
        Province,
        Province_Code,
        Financial_Year,
        Calendar_Month,

        SUM(Women_murdered) AS Women_Murdered,
        SUM(Attempted_Women_murder) AS Attempted_Women_Murder,
        SUM(Rape_Reported) AS Rape_Reported,
        SUM(Sexual_Assault_Reported) AS Sexual_Assault_Reported,
        SUM(Assault_GBH_Women) AS Assault_GBH_Women,
        SUM(Common_Assault_Women_18Plus) AS Common_Assault_Women_18Plus,
        SUM(Total_Selected_GBV_Reports) AS Total_GBV_Reports

    FROM GBV_data

    GROUP BY
        Province,
        Province_Code,
        Financial_Year,
        Calendar_Month
),

Femicide_Monthly AS
(
    SELECT
        Province,
        Province_Code,
        Financial_Year,
        Calendar_Month,

        SUM(Analytical_Femicide_Count) AS Femicide_Count,
        SUM(Intimate_Partner_Femicide) AS Intimate_Partner_Femicide,
        SUM(Family_Member_Femicide) AS Family_Member_Femicide,
        SUM(Stranger_Femicide) AS Stranger_Femicide,

        SUM(Firearm) AS Firearm,
        SUM(Sharp_Instrument) AS Sharp_Instrument,
        SUM(Blunt_Force) AS Blunt_Force,
        SUM(Other_Method) AS Other_Method,

        SUM(Cases_Solved_or_Charged) AS Cases_Solved_or_Charged,
        SUM(Convictions_Recorded) AS Convictions_Recorded

    FROM Femicide_data

    GROUP BY
        Province,
        Province_Code,
        Financial_Year,
        Calendar_Month
)

SELECT

    -- Dimensions
    g.Province,
    g.Province_Code,
    g.Financial_Year,
    g.Calendar_Month,

    -- GBV metrics
    g.Women_Murdered,
    g.Attempted_Women_Murder,
    g.Rape_Reported,
    g.Sexual_Assault_Reported,
    g.Assault_GBH_Women,
    g.Common_Assault_Women_18Plus,
    g.Total_GBV_Reports,

    -- Femicide metrics
    f.Femicide_Count,
    f.Intimate_Partner_Femicide,
    f.Family_Member_Femicide,
    f.Stranger_Femicide,

    -- Methods
    f.Firearm,
    f.Sharp_Instrument,
    f.Blunt_Force,
    f.Other_Method,

    -- Case outcomes
    f.Cases_Solved_or_Charged,
    f.Convictions_Recorded

FROM GBV_Monthly g

LEFT JOIN Femicide_Monthly f
    ON g.Province_Code = f.Province_Code
    AND g.Financial_Year = f.Financial_Year
    AND g.Calendar_Month = f.Calendar_Month;


