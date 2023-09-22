/* ## Task 2: Create Fact Tables
Identify fact Tables based on key performance indicators (KPIs) or metrics of you think would be useful for the data consumers.
Create and populate the initial fact tables using the cleaned and transformed data.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day2-task2.sql).
*/

/*
CREATE SOIL FACTS TABLE
*/

-- Create the fact table for KPI results
CREATE TABLE soil_fact_metrics (
    factId SERIAL PRIMARY KEY,
    TimeId INT REFERENCES Time(timekey),
    SoilId INT REFERENCES SoilDimension(SoilId),
    CropId INT REFERENCES CropDimension(CropId),
    SensorId INT REFERENCES SensorDimension(SensorId),
    IrrigationId INT REFERENCES IrrigationDimension(IrrigationId),
    WeatherId INT REFERENCES WeatherDimension(WeatherId),
    Soil_Health_Index NUMERIC,
    Nutrient_Balance NUMERIC,
    Nutrient_Available_Index NUMERIC
);

/* create temporary table for values */
CREATE TABLE Soil_Fact_Table (
    date DATE,
    SoilId INT,
    CropId INT,
    Crop_Yield DECIMAL(10, 2),
    Growth_Stage VARCHAR(255),
    Pest_Issue VARCHAR(255),
    Temperature_F DECIMAL(10, 2),
    Humidity DECIMAL(10, 2),
    Light_Intensity DECIMAL(10, 2),
    IrrigationId INT,
    Weather_Condition VARCHAR(255),
    Wind_Speed DECIMAL(10, 2),
    Precipitation DECIMAL(10, 2),
    Irrigation_Duration_Min DECIMAL(10, 2),
    Soil_Health_Index DECIMAL(10, 2),
    Nutrient_Balance DECIMAL(10, 2)
);

/* Loop over the record to insert in the temporary table above */
DO $$ 
DECLARE 
    BatchSize INT := 1000;
    RowCount INT := 0;
    Done BOOLEAN := FALSE;

    -- Declare a cursor for your SELECT statement
    cur CURSOR FOR
        SELECT
            td.date,
            so.SoilId,
            cr.CropId,
            cr.Crop_Yield,
            cr.Growth_Stage,
            cr.Pest_Issue,
            se.Temperature_F,
            se.Humidity,
            se.Light_Intensity,
            ir.IrrigationId,
            we.Weather_Condition,
            we.Wind_Speed,
            we.Precipitation,
            ir.Irrigation_Duration_Min,
            (so.Soil_Moisture + so.Organic_Matter) / 2 AS Soil_Health_Index,
            (so.nitrogen_level - so.phosphorus_level) AS Nutrient_Balance
        FROM
            Time td
        LEFT JOIN
            SoilDimension so ON DATE(so.timestamp) = td.date
        LEFT JOIN
            CropDimension cr ON DATE(cr.timestamp) = td.date
        LEFT JOIN
            SensorDimension se ON DATE(se.timestamp) = td.date
        LEFT JOIN
            IrrigationDimension ir ON DATE(ir.timestamp) = td.date
        LEFT JOIN
            WeatherDimension we ON DATE(we.timestamp) = td.date;
BEGIN
    -- Loop to fetch and insert data in batches
    FOR row_data IN cur
    LOOP
        -- Check if any rows were fetched, and break the loop if none were fetched
        IF NOT FOUND THEN
            Done := TRUE;
            EXIT;
        END IF;

        -- Insert the fetched row into YourTargetTable
        INSERT INTO Soil_Fact_Table (
            date,
            SoilId,
            CropId,
            Crop_Yield,
            Growth_Stage,
            Pest_Issue,
            Temperature_F,
            Humidity,
            Light_Intensity,
            IrrigationId,
            Weather_Condition,
            Wind_Speed,
            Precipitation,
            Irrigation_Duration_Min,
            Soil_Health_Index,
            Nutrient_Balance
        ) VALUES (
            row_data.date_col,
            row_data.SoilId_col,
            row_data.CropId_col,
            row_data.Crop_Yield_col,
            row_data.Growth_Stage_col,
            row_data.Pest_Issue_col,
            row_data.Temperature_F_col,
            row_data.Humidity_col,
            row_data.Light_Intensity_col,
            row_data.IrrigationId_col,
            row_data.Weather_Condition_col,
            row_data.Wind_Speed_col,
            row_data.Precipitation_col,
            row_data.Irrigation_Duration_Min_col,
            row_data.Soil_Health_Index_col,
            row_data.Nutrient_Balance_col
        );

        -- Increment the row count
        RowCount := RowCount + 1;

        -- Add a delay if necessary to avoid overwhelming the system
        -- PERFORM pg_sleep(1); -- Uncomment this line and adjust the delay as needed

        -- Exit the loop if the desired batch size is reached
        IF RowCount >= BatchSize THEN
            EXIT;
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END $$;

