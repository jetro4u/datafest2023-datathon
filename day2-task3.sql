/* ## Task 3: Define Primary Keys and Foreign Keys
Define primary keys for dimension Tables.
Define foreign keys in fact Tables to establish relationships with dimension Tables.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day2-task3.sql).
*/
-- Add a foreign key constraint on CropDimension table
ALTER TABLE CropDimension
ADD CONSTRAINT fk_CropType_CropDimension
FOREIGN KEY (CropTypeId) REFERENCES CropType(CropTypeId);
-- Add NOT NULL constraints to CropDimension table columns
ALTER TABLE CropDimension
ALTER COLUMN Timestamp SET NOT NULL;

-- Add NOT NULL constraints to CropType table columns
ALTER TABLE CropType
ALTER COLUMN Crop_Type SET NOT NULL;


ALTER TABLE Location_Region
ADD CONSTRAINT fk_LocationID
FOREIGN KEY (LocationID)
REFERENCES Location(LocationID);


-- Add references to IrrigationMethod and WaterSource in IrrigationDimension
ALTER TABLE IrrigationDimension
ADD CONSTRAINT fk_irrigation_method
    FOREIGN KEY (Irrigation_Method)
    REFERENCES IrrigationMethod (Irrigation_Method),

ALTER TABLE IrrigationDimension
ADD CONSTRAINT fk_water_source
    FOREIGN KEY (Water_Source)
    REFERENCES WaterSource (Water_Source)

-- Add check constraints to ensure valid values for Irrigation_Duration_Min
ALTER TABLE IrrigationDimension
ADD CONSTRAINT chk_irrigation_duration_min
    CHECK (Irrigation_Duration_Min >= 0);

ALTER TABLE PestDimension
ADD CONSTRAINT fk_PestType
FOREIGN KEY (Pest_Type)
REFERENCES PestType (Pest_Type);

ALTER TABLE WeatherDimension
ALTER COLUMN Timestamp SET NOT NULL;

