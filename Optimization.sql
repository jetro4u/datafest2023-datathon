/* Create INDEX in ids */
CREATE INDEX id_sensor ON sensor USING btree (id);

/* Create INDEX on dimension tables */
CREATE INDEX index_location ON location (name, sensorid, latitude, longitude, levation, region);
CREATE INDEX index_irrigationmethod ON irrigationmethod (name, time);
CREATE INDEX index_watersource ON watersource ();
CREATE INDEX index_croptype ON croptype (time, name);
CREATE INDEX index_growthstage ON growthstage (time, name);
CREATE INDEX index_pesttype ON pesttype (time, name);


/* Create INDEX on facts tables */
CREATE INDEX index_irrigationmetrics ON irrigationmetrics (sensorid, irrigationmethodid, watersourceid, irrigationmethod, watersource, irrigationdurationmin, timestamp);
CREATE INDEX index_cropmetrics ON cropmetrics (timestamp, growthstageid, croptypeid, croptype, growthstage, pestissue, cropyield);
CREATE INDEX index_pestmetrics ON pestmetrics (timestamp, pesttypeid, pesttype, pestdescription, pestseverity);
CREATE INDEX index_soilmetrics ON soilmetrics (timestamp, soilcomp, soilmoisture, soilph, nitrogenlevel, phosphoruslevel, organicmatter);
CREATE INDEX index_weathermetrics ON weathermetrics (timestamp, weathercondition, windspeed, precipitation);
CREATE INDEX index_farmmetrics ON farmmetrics (sensorid, locationid, irrigationid, cropid, pestid, soilid, weatherid, temperaturef, humidity, soilmoisture, lightintensity, batterylevel);