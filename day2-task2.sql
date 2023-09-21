/* ## Task 2: Create Fact Tables
Identify fact Tables based on key performance indicators (KPIs) or metrics of you think would be useful for the data consumers.
Create and populate the initial fact tables using the cleaned and transformed data.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day2-task2.sql).
*/
<<<<<<< HEAD

/*
CREATE CROP FACTS TABLE
*/
-- Create the fact table
CREATE TABLE farm_fact_table (
    factid SERIAL PRIMARY KEY,
    timekey INT,
    IrrigationId INT,
    CropId INT,
    PestId INT,
    SoilId INT,
    WeatherId INT,
    SensorId INT,
    FOREIGN KEY (timekey) REFERENCES Time(timekey),
    FOREIGN KEY (IrrigationId) REFERENCES IrrigationDimension(IrrigationId),
    FOREIGN KEY (CropId) REFERENCES CropDimension(CropId),
    FOREIGN KEY (PestId) REFERENCES PestDimension(PestId),
    FOREIGN KEY (SoilId) REFERENCES SoilDimension(SoilId),
    FOREIGN KEY (WeatherId) REFERENCES WeatherDimension(WeatherId),
    FOREIGN KEY (SensorId) REFERENCES SensorDimension(SensorId)
);

INSERT INTO farm_fact_table (timekey, IrrigationId, CropId, PestId, SoilId, WeatherId, SensorId)
SELECT
    t.timekey,
    id.IrrigationId,
    cd.CropId,
    pd.PestId,
    sd.SoilId,
    wd.WeatherId,
    sd.SensorId
FROM
    (SELECT timekey FROM Time) AS t
LEFT JOIN
    (SELECT IrrigationId FROM IrrigationDimension) AS id ON true
LEFT JOIN
    (SELECT CropId FROM CropDimension) AS cd ON true
LEFT JOIN
    (SELECT PestId FROM PestDimension) AS pd ON true
LEFT JOIN
    (SELECT SoilId FROM SoilDimension) AS sd ON true
LEFT JOIN
    (SELECT WeatherId FROM WeatherDimension) AS wd ON true
LEFT JOIN
    (SELECT SensorId FROM SensorDimension) AS sd ON true;



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


CREATE TABLE CROPFACTMETRICS (
    fact_id SERIAL PRIMARY KEY,
    time_id INT REFERENCES time_dim(time_id),
    CropId INT REFERENCES crop_dim(CropId),
    growth_stage VARCHAR(255),
    pest_issue BOOLEAN,
    crop_yield DECIMAL(10, 2),
    -- Add other fact-related attributes as needed
);
INSERT INTO crop_fact (time_id, CropId, growth_stage, pest_issue, crop_yield)
SELECT
    t.time_id,
    c.CropId,
    crd.growth_stage,
    crd.pest_issue,
    crd.crop_yield
FROM
    croprawdata crd
JOIN
    time_dim t ON crd.timestamp = t.timestamp
JOIN
    crop_dim c ON crd.crop_type = c.crop_type;



=======
CREATE TABLE irrigationmetrics (
    id BIGSERIAL PRIMARY KEY,
    sensorid VARCHAR (10),
	irrigationmethodid SERIAL,
	watersourceid SERIAL,
	irrigationmethod VARCHAR(20),
	watersource VARCHAR(20),
	timestamp TIMESTAMP,
	irrigationdurationmin INT
);
CREATE TABLE cropmetrics (
    id BIGSERIAL PRIMARY KEY,
	timestamp TIMESTAMP,
	croptypeid SERIAL,
	growthstageid SERIAL,
	croptype VARCHAR(20),
	growthstage VARCHAR(50),
	pestissue TEXT,
	cropyield DECIMAL(8, 2)
);
>>>>>>> 7edb145683e9357a0978bd5769a18b764237a5d0
CREATE TABLE pestmetrics (
    id BIGSERIAL PRIMARY KEY,
	timestamp TIMESTAMP,
	pesttypeid SERIAL,
	pesttype VARCHAR(20),
	pestdescription TEXT,
	pestseverity VARCHAR(20)
);
<<<<<<< HEAD

INSERT INTO soil_fact_metrics (TimeId, SoilId, CropId, SensorId, IrrigationId, WeatherId, Soil_Health_Index,  Nutrient_Balance, Nutrient_Available_Index)
SELECT
    ti.TimeId,
    so.SoilId,
    cr.Crop_Type,
    cr.Crop_Yield,
    cr.Growth_Stage,
    cr.Pest_Issue,
    se.Temperature,
    se.Humidity,
    se.Light_Intensity,
    ir.IrrigationId,
    we.Weather_Condition,
    we.Wind_Speed,
    we.Precipitation,
    ir.Irrigation_Duration,
    (so.Soil_Moisture + so.Organic_Matter) / 2 AS Soil_Health_Index,
    (so.nitrogen_level - so.phosphorus_level) AS Nutrient_Balance,
    (irrigation.water_applied - weather.evaporation) / sr.soil_moisture AS Nutrient_Available_Index,
FROM
    time_dim td
JOIN
    SoilDimension so ON so.timestamp = td.timestamp
JOIN
    CropDimension cr ON cr.CropId = so.CropId
JOIN
    SensorDimension se ON se.SensorId = so.SensorId
JOIN
    IrrigationDimension ir ON ir.IrrigationId = so.IrrigationId
JOIN
    WeatherDimension we ON we.WeatherId = so.WeatherId;


SELECT
    td.fulldate,
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
    SoilDimension so ON so.timestamp = td.fulldate
LEFT JOIN
    CropDimension cr ON cr.timestamp = td.fulldate
LEFT JOIN
    SensorDimension se ON se.timestamp = td.fulldate
LEFT JOIN
    IrrigationDimension ir ON ir.timestamp = td.fulldate
LEFT JOIN
    WeatherDimension we ON we.timestamp = td.fulldate;




CREATE TABLE farm_fact_metrics (
    factid SERIAL,
    ti.timekey,
    irrigationid SERIAL,
    cropid SERIAL,
    pestid SERIAL,
    soilid SERIAL,
    sensorid SERIAL,
    weatherid SERIAL
);

=======
CREATE TABLE soilmetrics (
    id BIGSERIAL PRIMARY KEY,
	timestamp TIMESTAMP,
	soilcomp DECIMAL(5, 2),
	soilmoisture DECIMAL(5, 2),
	soilph DECIMAL(4, 2),
	nitrogenlevel DECIMAL(5, 2),
	phosphoruslevel DECIMAL(5, 2),
	organicmatter DECIMAL(5, 2)
);
CREATE TABLE weathermetrics (
    id BIGSERIAL PRIMARY KEY,
	timestamp TIMESTAMP,
	weathercondition VARCHAR(50),
	windspeed DECIMAL(5, 2),
	precipitation DECIMAL(5, 2)
);
CREATE TABLE farmfactmetrics (
    id BIGSERIAL PRIMARY KEY,
    sensorid VARCHAR (10),
	timestamp timestamp,
	period DATE(timestamp),
    locationid BIGSERIAL,
    irrigationid BIGSERIAL,
    cropid BIGSERIAL,
    pestid BIGSERIAL,
    soilid BIGSERIAL,
    weatherid BIGSERIAL,
	temperaturef DECIMAL(5, 2),
	humidity DECIMAL(5, 2),
	soilmoisture DECIMAL(5, 2),
	lightintensity DECIMAL(8, 2),
	batterylevel DECIMAL(8, 2)
);

-- Add foreign key constraints to link dimension tables with the fact table

ALTER TABLE farmmetrics ADD CONSTRAINT fk_sensor
 FOREIGN KEY (sensorid) REFERENCES sensor(id);
ALTER TABLE farmmetrics ADD CONSTRAINT fk_time
 FOREIGN KEY (id) REFERENCES time(id);
ALTER TABLE farmmetrics ADD CONSTRAINT fk_location
 FOREIGN KEY (locationid) REFERENCES location(id);
ALTER TABLE farmmetrics ADD CONSTRAINT fk_irrigationmethod
 FOREIGN KEY (irrigationid) REFERENCES irrigationmethod(id);
ALTER TABLE farmmetrics ADD CONSTRAINT fk_crop
 FOREIGN KEY (cropid) REFERENCES cropmetrics(id);
ALTER TABLE farmmetrics ADD CONSTRAINT fk_pest
 FOREIGN KEY (pestid) REFERENCES pestmetrics(id);
ALTER TABLE farmmetrics ADD CONSTRAINT fk_soil
 FOREIGN KEY (soilid) REFERENCES soilmetrics(id);
ALTER TABLE farmmetrics ADD CONSTRAINT fk_weather
 FOREIGN KEY (weatherid) REFERENCES weathermetrics(id);
ALTER TABLE irrigationmetrics ADD CONSTRAINT fk_irrigation
 FOREIGN KEY (irrigationmethodid) REFERENCES irrigationmethod(id);
ALTER TABLE irrigationmetrics ADD CONSTRAINT fk_watersource
 FOREIGN KEY (watersourceid) REFERENCES watersource(id);
ALTER TABLE cropmetrics ADD CONSTRAINT fk_croptype
 FOREIGN KEY (croptypeid) REFERENCES croptype(id);
ALTER TABLE cropmetrics ADD CONSTRAINT fk_growthstage
 FOREIGN KEY (growthstageid) REFERENCES growthstage(id);
ALTER TABLE pestmetrics ADD CONSTRAINT fk_pesttype
 FOREIGN KEY (pesttypeid) REFERENCES pesttype(id);
>>>>>>> 7edb145683e9357a0978bd5769a18b764237a5d0

/* POPULATE FACTS TABLE. YOU CAN ALSO YOU THE SELECT STATEMENT TO QUERY THE DATA */
INSERT INTO irrigationmetrics (sensorid, timestamp, irrigationdurationmin, irrigationmethod, watersource) 
SELECT
    t1.sensorid AS sensorid,
    t1.timestamp AS timestamp,
    t1.irrigationdurationmin AS irrigationdurationmin,
    t2.name AS irrigationmethod,
    t3.name AS watersource
FROM
    stageirrigationdata t1
JOIN
    irrigationmethod t2 ON t1.id = t2.id
JOIN
    watersource t3 ON t1.id = t3.id;

INSERT INTO cropmetrics (timestamp, pestissue, cropyield, croptype, growthstage) 
SELECT
    t1.timestamp AS timestamp,
    t1.pestissue AS pestissue,
    t1.cropyield AS cropyield,
    t2.name AS croptype,
    t3.name AS growthstage
FROM
    stagecropdata t1
JOIN
   croptype t2 ON t1.id = t2.id
JOIN
    growthstage t3 ON t1.id = t3.id;

<<<<<<< HEAD


INSERT INTO farmmetrics (sensorid, temperaturef, humidity, soilmoisture, lightintensity, batterylevel, timeid, locationid, irrigationid, cropid, pestid, soilid, weatherid ) 
SELECT
    t1.id AS timeid,
    t2.id AS irrigationid,
    t3.id AS cropid,
    t4.id AS pestid,
    t5.id AS sensorid,
    t6.id AS soilid,
    t7.id AS weatherid
FROM
    Time t1
LEFT JOIN
JOIN
   irrigationdimension t2 ON t1.id = t2.id
JOIN
   cropdimension t3 ON t3.id = t3.id
JOIN
   soildimension t4 ON t1.id = t4.id
JOIN
   pestdimension t5 ON t1.id = t6.id
JOIN
   sensordimension t7 ON t1.id = t7.id
JOIN
   weatherdimension t8 ON t1.id = t8.id
=======
INSERT INTO pestmetrics (timestamp, pestdescription, pestseverity, pesttype) 
SELECT
    t1.timestamp AS timestamp,
    t1.pestdescription AS pestdescription,
    t1.pestseverity AS pestseverity,
    t2.name AS pesttype
FROM
    stagepestdata t1
JOIN
   croptype t2 ON t1.id = t2.id

INSERT INTO soilmetrics (timestamp, soilcomp, soilmoisture, soilph, nitrogenlevel, phosphoruslevel, organicmatter)
SELECT timestamp::TIMESTAMP, soilcomp::DECIMAL(5, 2), 
    soilmoisture::DECIMAL(5, 2), soilph::DECIMAL(4, 2), nitrogenlevel::DECIMAL(5, 2), phosphoruslevel::DECIMAL(5, 2), organicmatter::DECIMAL(5, 2) FROM stagesoildata;

INSERT INTO weathermetrics (timestamp, weathercondition, windspeed, precipitation)
SELECT timestamp::TIMESTAMP, weathercondition, 
    windspeed::DECIMAL(5, 2), precipitation::DECIMAL(5, 2) FROM stageweatherdata;

INSERT INTO farmmetrics (sensorid, temperaturef, humidity, soilmoisture, lightintensity, batterylevel, timeid, locationid, irrigationid, cropid, pestid, soilid, weatherid ) 
SELECT
    t1.sensorid AS sensorid,
    t1.temperaturef AS temperaturef,
    t1.humidity AS humidity,
    t1.soilmoisture AS soilmoisture,
    t1.lightintensity AS lightintensity,
    t1.batterylevel AS batterylevel,
    t2.id AS timeid,
    t3.id AS locationid,
    t4.id AS irrigationid,
    t5.id AS cropid,
    t6.id AS pestid,
    t7.id AS soilid,
    t8.id AS weatherid
FROM
    stagesensordata t1
JOIN
   time t2 ON t1.id = t2.id
JOIN
   location t3 ON t1.id = t3.id
JOIN
   irrigationmetrics t4 ON t1.id = t4.id
JOIN
   cropmetrics t5 ON t1.id = t5.id
JOIN
   pestmetrics t6 ON t1.id = t6.id
JOIN
   soilmetrics t7 ON t1.id = t7.id
JOIN
   weathermetrics t8 ON t1.id = t8.id
>>>>>>> 7edb145683e9357a0978bd5769a18b764237a5d0
