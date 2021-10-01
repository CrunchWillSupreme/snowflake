Steps:
1. Create AWS S3 bucket
2. Create AWS Policy
3. Create AWS User and attach policy
4. Create Snowflake(SF) table
5. Create SF File format (JSON)
6. Create SF Stage
7. Create SF Snowpipe
8. Attach SQS to S3
9. Load data to S3 and voila!

*/

//SHOW REGIONS;
//SELECT CURRENT_REGION();

/* Create table for the data that will be pulled in */
CREATE OR REPLACE TABLE JSON_TABLE (
content VARIANT,
file_location VARCHAR,
file_name VARCHAR,
row_number NUMBER,
snowflake_received_at TIMESTAMP default current_timestamp());

//select * from JSON_TABLE
CREATE TABLE DATA_DESC (
DATA_NAME VARCHAR,
CONTEXT VARCHAR,
CONTENT VARCHAR)

//DROP TABLE DATA_DESC
create
PUT file:///data/healthcare-dataset-stroke-data.csv @%stroke;

CREATE TABLE STROKE_DATA (
id int
,gender varchar
,age int
,hypertension int
,heart_disease int
,ever_married varchar
,work_type varchar
,residence_type varchar
,avg_glucose_level float
,bmi float
,smoking_status varchar
,stroke int)


/* Create File Format */
CREATE OR REPLACE FILE FORMAT myjsonformat
    type = 'JSON';
    

/* Create Stage for JSON Data */
CREATE OR REPLACE STAGE COMPANY_SNOW_STAGE
url='s3://wills-snowpipe-staging/'
credentials=(aws_key_id='AKIAUYDNBDAV4PI3CLYM' aws_secret_key='waf7kT6IjzjVRWE7GNZoTfH5rwPljqFoaOhkg9wC')
file_format=myjsonformat;

//show stages;


/* Create Pipe to automate data ingestion from S3 to Snowflake */
CREATE OR REPLACE PIPE WILL_DB.RAW.MYPIPE1 auto_ingest=TRUE AS
COPY INTO JSON_TABLE(content, file_location, file_name, row_number)
FROM (SELECT c.$1, SPLIT_PART(METADATA$FILENAME,'/',1), SPLIT_PART(METADATA$FILENAME,'/',2), METADATA$FILE_ROW_NUMBER
     FROM @WILL_DB.RAW.COMPANY_SNOW_STAGE c)
file_format=(type='JSON')
on_error=CONTINUE;


     
-- ! Alter pipe, don't re create     
//show pipes;

SELECT * FROM JSON_TABLE;
select * from WILL_DB.RAW.MYPIPE1;


/* Commands for the pipe */
-- Current pipe status (pending files etc)
SELECT system$pipe_status('WILL_DB.RAW.MYPIPE1');

-- Pause the running pipe
ALTER pipe WILL_DB.RAW.MYPIPE1 set pipe_execution_paused=true;

-- Resume the pipe
ALTER pipe WILL_DB.RAW.MYPIPE1 set pipe_execution_paused=false;

-- Load the historic data
ALTER pipe WILL_DB.RAW.MYPIPE1 refresh;
