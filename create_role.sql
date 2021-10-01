---- Create User with sysadmin role

USE ROLE "securityadmin"

CREATE USER willhan PASSWORD = 'ChangeThis!123' 
COMMENT = 'New user joined' 
LOGIN_NAME = 'willhan' 
DISPLAY_NAME = 'Will H' 
FIRST_NAME = 'Will' 
LAST_NAME = 'Han' 
EMAIL = 'whan@ippon.fr' 
DEFAULT_ROLE = "default_role"
--DEFAULT_WAREHOUSE = 'ANY' 
--DEFAULT_NAMESPACE = 'NAME_SPACE' 
MUST_CHANGE_PASSWORD = TRUE;

---- Assign 'sysadmin' role to user 'willhan'
ALTER USER willhan SET DISABLED=TRUE; --this will forcefully close all existing sessions for the user while making the changes for the user.
GRANT ROLE sysadmin TO USER willhan;
ALTER USER willhan SET DEFAULT_ROLE = sysadmin;
ALTER USER willhan SET DISABLED=FALSE;

---- Create database
CREATE DATABASE TEST_DB1;

USE DATABASE TEST_DB1;


---- Create Schema / Alter Schema
CREATE SCHEMA TEST_SCHEMA1;

--ALTER SCHEMA TEST_SCHEMA1 RENAME TO TEST_SCHEMA2;


---- Create Warehouse
CREATE WAREHOUSE TEST_WAREHOUSE WITH WAREHOUSE_SIZE = 'XSMALL'
WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 300 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1
SCALING_POLICY = 'STANDARD' COMMENT = 'This is a test warehouse'

---- Create Role and Grant Ownership of database
CREATE ROLE TEST_DB1_ADMIN
    COMMENT = 'This role has OWNERSHIP privileges on TEST_DB1_ADMIN'

GRANT OWNERSHIP ON DATABASE TEST_DB1 TO ROLE TEST_DB1_ADMIN;

GRANT ALL PRIVILEGES ON DATABASE TEST_DB1 TO ROLE TEST_DB1_ADMIN;

GRANT USAGE ON WAREHOUSE TEST_WAREHOUSE TO ROLE TEST_DB1_ADMIN;


---- Create a new user and assign the TEST_DB1_ADMIN role to it
CREATE USER test_db1_user1 PASSWORD = 'ChangeThis!123' 
COMMENT = 'New user joined' 
LOGIN_NAME = 'test_db1_user1' 
DISPLAY_NAME = 'test_db1_user1' 
FIRST_NAME = 'test_db1_owner' 
LAST_NAME = '' 
EMAIL = 'whan@ippon.fr' 
DEFAULT_ROLE = "default_role"
--DEFAULT_WAREHOUSE = 'ANY' 
--DEFAULT_NAMESPACE = 'NAME_SPACE' 
MUST_CHANGE_PASSWORD = TRUE;

---- Grant role 'TEST_DB1_ADMIN' to user 'test_db1_owner'
ALTER USER test_db1_owner SET DISABLED=TRUE; --this will forcefully close all existing sessions for the user while making the changes for the user.
GRANT ROLE TEST_DB1_ADMIN TO USER test_db1_owner;
ALTER USER test_db1_owner SET DEFAULT_ROLE = TEST_DB1_ADMIN;
ALTER USER test_db1_owner SET DISABLED=FALSE;
