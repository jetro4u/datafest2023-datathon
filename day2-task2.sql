/* ## Task 2: Create Fact Tables
Identify fact Tables based on key performance indicators (KPIs) or metrics of you think would be useful for the data consumers.
Create and populate the initial fact tables using the cleaned and transformed data.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day2-task2.sql).
*/

/*
CREATE SOIL FACTS TABLE
*/
/* create temporary table for values */

CREATE TABLE Soil_Fact_Metrics (
    FactId BIGSERIAL PRIMARY KEY,
    fulldate TIMESTAMP,
    date DATE,
    Soil_Comp VARCHAR(255),
    Soil_Moisture DECIMAL(5, 2),
    Soil_PH DECIMAL(4, 2),
    Nitrogen_Level DECIMAL(5, 2),
    Phosphorus_Level DECIMAL(5, 2),
    Organic_Matter DECIMAL(5, 2),
    Crop_Type VARCHAR(50),
    Crop_Yield DECIMAL(10, 2),
    Growth_Stage VARCHAR(255),
    Pest_Issue TEXT,
    Temperature_F DECIMAL(10, 2),
    Humidity DECIMAL(10, 2),
    Light_Intensity DECIMAL(10, 2),
    Sensor_Soil_Moisture DECIMAL(5, 2),
    Weather_Condition VARCHAR(255),
    Wind_Speed DECIMAL(10, 2),
    Precipitation DECIMAL(10, 2),
    Irrigation_Method VARCHAR(20),
    Water_Source VARCHAR(20),
    Irrigation_Duration_Min NUMERIC
);

 INSERT INTO Soil_Fact_Metrics (
    fulldate,
    date,
    Soil_Comp,
    Soil_Moisture,
    Soil_PH,
    Nitrogen_Level,
    Phosphorus_Level,
    Organic_Matter,
    Crop_Type,
    Growth_Stage,
    Pest_Issue,
    Crop_Yield,
    Temperature_F,
    Humidity,
    Light_Intensity,
    Sensor_Soil_Moisture,
    Irrigation_Method,
    Water_Source,
    Irrigation_Duration_Min,
    Weather_Condition,
    Wind_Speed,
    Precipitation
)
SELECT 
    td.fulldate AS timestamp,
    td.date AS date,
    sd.Soil_Comp AS soilcomp,
    sd.Soil_Moisture AS soilmoisture,
    sd.Soil_PH AS soilph,
    sd.Nitrogen_Level AS nitrogenlevel,
    sd.Phosphorus_Level AS phosphoruslevel,
    sd.Organic_Matter AS organicmatter,
    cd.Crop_Type AS croptype,
    cd.Growth_Stage AS growthstage,
    cd.Pest_Issue AS pestissue,
    cd.Crop_yield AS cropyield,
    se.Temperature_F AS temperature,
    se.Humidity AS humidity,
    se.Light_Intensity AS lightintensity,
    se.Soil_Moisture AS sensorsoilmoisture,
    ir.Irrigation_Method AS irrigationmethod,
    ir.Water_Source AS watersource,
    ir.Irrigation_Duration_Min AS irrigationdurationmin,
    we.Weather_Condition AS weathercondition,
    we.Wind_Speed AS windspeed,
    we.Precipitation AS precipitation
FROM Time td
LEFT JOIN SoilDimension sd ON sd.timestamp = td.fulldate
LEFT OUTER JOIN CropDimension cd ON cd.timestamp = td.fulldate
LEFT OUTER JOIN SensorDimension se ON se.timestamp = td.fulldate
LEFT OUTER JOIN IrrigationDimension ir ON ir.timestamp = td.fulldate
LEFT OUTER JOIN WeatherDimension we ON we.timestamp = td.fulldate
ORDER BY td.fulldate ASC;


======================================
/*
CREATE CROP FACTS TABLE
*/
/* create temporary table for values */
CREATE TABLE Crop_Fact_Table (
    FactId BIGSERIAL PRIMARY KEY,
    fulldate TIMESTAMP,
    date DATE,
    Crop_Type VARCHAR(50),
    Growth_Stage VARCHAR(255),
    Pest_Issue TEXT,
    Crop_Yield DECIMAL(10, 2),
	Pest_Type VARCHAR(20),
	Pest_Description TEXT,
	Pest_Severity VARCHAR(20),
    Soil_Comp VARCHAR(255),
    Soil_Moisture DECIMAL(5, 2),
    Soil_PH DECIMAL(4, 2),
    Nitrogen_Level DECIMAL(5, 2),
    Phosphorus_Level DECIMAL(5, 2),
    Organic_Matter DECIMAL(5, 2),
    Temperature_F DECIMAL(10, 2),
    Humidity DECIMAL(10, 2),
    Light_Intensity DECIMAL(10, 2),
    Sensor_Soil_Moisture DECIMAL(5, 2),
    Weather_Condition VARCHAR(255),
    Wind_Speed DECIMAL(10, 2),
    Precipitation DECIMAL(10, 2),
    Irrigation_Method VARCHAR(20),
    Water_Source VARCHAR(20),
    Irrigation_Duration_Min NUMERIC
);

INSERT INTO Crop_Fact_Table (
    fulldate,
    date,
    Crop_Type,
    Growth_Stage,
    Pest_Issue,
    Crop_Yield,
    Pest_Type,
	Pest_Description,
	Pest_Severity,
    Soil_Comp,
    Soil_Moisture,
    Soil_PH,
    Nitrogen_Level,
    Phosphorus_Level,
    Organic_Matter,
    Temperature_F,
    Humidity,
    Light_Intensity,
    Sensor_Soil_Moisture,
    Irrigation_Method,
    Water_Source,
    Irrigation_Duration_Min,
    Weather_Condition,
    Wind_Speed,
    Precipitation
)
SELECT 
    td.fulldate AS timestamp,
    td.date AS date,
    cd.Crop_Type AS croptype,
    cd.Growth_Stage AS growthstage,
    cd.Pest_Issue AS pestissue,
    cd.Crop_yield AS cropyield,
    pe.Pest_Type AS pesttype,
	pe.Pest_Description AS pestdescription,
	pe.Pest_Severity AS pestdescription,
    sd.Soil_Comp AS soilcomp,
    sd.Soil_Moisture AS soilmoisture,
    sd.Soil_PH AS soilph,
    sd.Nitrogen_Level AS nitrogenlevel,
    sd.Phosphorus_Level AS phosphoruslevel,
    sd.Organic_Matter AS organicmatter,
    se.Temperature_F AS temperature,
    se.Humidity AS humidity,
    se.Light_Intensity AS lightintensity,
    se.Soil_Moisture AS sensorsoilmoisture,
    ir.Irrigation_Method AS irrigationmethod,
    ir.Water_Source AS watersource,
    ir.Irrigation_Duration_Min AS irrigationdurationmin,
    we.Weather_Condition AS weathercondition,
    we.Wind_Speed AS windspeed,
    we.Precipitation AS precipitation
FROM Time td
LEFT JOIN CropDimension cd ON cd.timestamp = td.fulldate
LEFT OUTER JOIN PestDimension pe ON pe.timestamp = td.fulldate
LEFT OUTER JOIN SoilDimension sd ON sd.timestamp = td.fulldate
LEFT OUTER JOIN SensorDimension se ON se.timestamp = td.fulldate
LEFT OUTER JOIN IrrigationDimension ir ON ir.timestamp = td.fulldate
LEFT OUTER JOIN WeatherDimension we ON we.timestamp = td.fulldate
ORDER BY td.fulldate ASC