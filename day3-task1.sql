/* ## Day 3: Additional Fact Tables and Optimization

Task 1: Indexing and Optimization
Implement appropriate indexing strategies to optimize query performance.
Analyze the query patterns and optimize the data model accordingly.
Perform data quality checks and address any anomalies.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day2-task3.sql).
*/
-- Add indexes to CropTypeId columns in both tables
CREATE INDEX idx_CropType_CropTypeId ON CropType (CropTypeId);
CREATE INDEX idx_CropDimension_CropTypeId ON CropDimension (CropTypeId);

-- Index on LocationID (Primary Key)
CREATE INDEX idx_Location_LocationID
ON Location(LocationID);

-- Index on Sensor_ID (if needed)
CREATE INDEX idx_Location_Sensor_ID
ON Location(Sensor_ID);

-- Index on Region (if needed)
CREATE INDEX idx_Location_Region
ON Location(Region);
-- Index on LocationID (Foreign Key)
CREATE INDEX idx_Location_Region_LocationID
ON Location_Region(LocationID);

-- Index on Region_Name (if needed)
CREATE INDEX idx_Location_Region_Region_Name
ON Location_Region(Region_Name);

-- Create an index on the Sensor_ID column for faster searches
CREATE INDEX idx_sensor_id ON IrrigationDimension (Sensor_ID);

-- Create an index on the Timestamp column for faster time-based queries
CREATE INDEX idx_timestamp ON IrrigationDimension (Timestamp);

-- Add indexes to improve query performance
CREATE INDEX idx_sensor_id ON IrrigationDimension (Sensor_ID);
CREATE INDEX idx_timestamp ON IrrigationDimension (Timestamp);

CREATE INDEX idx_PestType_Pest_Type ON PestType (Pest_Type);
CREATE INDEX idx_PestDimension_Pest_Type ON PestDimension (Pest_Type);

-- Create an index on the Timestamp column in SoilDimension table
CREATE INDEX idx_soil_timestamp
ON SoilDimension (Timestamp);

CREATE INDEX idx_weather_condition ON WeatherDimension (Weather_Condition);

CREATE INDEX idx_sensor_type ON SensorDimension(Sensor_Type);

CREATE INDEX idx_time_id ON soil_fact_metrics (TimeId);
CREATE INDEX idx_soil_id ON soil_fact_metrics (SoilId);
CREATE INDEX idx_crop_id ON soil_fact_metrics (CropId);
CREATE INDEX idx_sensor_id ON soil_fact_metrics (SensorId);
CREATE INDEX idx_irrigation_id ON soil_fact_metrics (IrrigationId);
CREATE INDEX idx_weather_id ON soil_fact_metrics (WeatherId);

