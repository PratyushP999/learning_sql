create database mydatabase;
use database mydatabase;

CREATE OR REPLACE TABLE AGENTS
   (	
     AGENT_CODE CHAR(6) NOT NULL PRIMARY KEY, 
	 AGENT_NAME CHAR(40) , 
	 WORKING_AREA CHAR(35), 
	 COMMISSION NUMBER(10,2) DEFAULT 0.05, 
	 PHONE_NO CHAR(15), 
	 COUNTRY VARCHAR2(25) 
	 );

INSERT INTO AGENTS VALUES ('A007', 'Ramasundar', 'Bangalore',0.15,'077-25814763', '');
select * from agents;
INSERT INTO AGENTS(AGENT_CODE,AGENT_NAME,WORKING_AREA) 
VALUES ('A110', 'Anand', 'Germany');

INSERT INTO AGENTS VALUES ('A003', 'Alex ', 'London', '0.13', '075-12458969', '');
INSERT INTO AGENTS VALUES ('A008', 'Alford', 'New York', '0.12', '044-25874365', '');
INSERT INTO AGENTS VALUES ('A011', 'Ravi Kumar', 'Bangalore', '0.15', '077-45625874', '');
INSERT INTO AGENTS VALUES ('A010', 'Santakumar', 'Chennai', '0.14', '007-22388644', '');
INSERT INTO AGENTS VALUES ('A012', 'Lucida', 'San Jose', '0.12', '044-52981425', '');
INSERT INTO AGENTS VALUES ('A005', 'Anderson', 'Brisban', '0.13', '045-21447739', '');
INSERT INTO AGENTS VALUES ('A001', 'Subbarao', 'Bangalore', '0.14', '077-12346674', '');
INSERT INTO AGENTS VALUES ('A002', 'Mukesh', 'Mumbai', '0.11', '029-12358964', '');
INSERT INTO AGENTS VALUES ('A006', 'McDen', 'London', '0.15', '078-22255588', '');
INSERT INTO AGENTS VALUES ('A004', 'Ivan', 'Torento', '0.15', '008-22544166', '');
INSERT INTO AGENTS VALUES ('A009', 'Benjamin', 'Hampshair', '0.11', '008-22536178', '');

update agents
set country = 'IN' where country is null or country= '' ;

INSERT INTO AGENTS(AGENT_CODE,AGENT_NAME,WORKING_AREA) 
VALUES ('A810', 'Anand', 'france');

INSERT INTO AGENTS VALUES ('A003', 'Alexa ', 'beijing', '0.137', '075-12458969', '');
INSERT INTO AGENTS VALUES ('A008', 'Alford', 'mumbai', '0.12', '044-25874365', '');

update agents 
set country = 'AU'where country in(null,''); -- this runs but cannot replace the null values present inside the column


-- STRING FUNCTIONS

select substring('PRATYUSH PANDA',0,7)AS partial_name; -- index beginning with 0 or 1 doesn't matter.
select substring('PRATYUSH PANDA',1,10)AS partial_name;
select substr('raja ram',0);
select substr('physics student',9);  --takes the 9th index and what lies afterwards
select substr('physics student',-9); 
select substr('physics student',-9,3); --  
select substr('physics student',-9,-3); -- no output but doesnot show any error.

select * from AGENTS;
select substr(AGENT_CODE,2)AS AGENT_INITIALS FROM AGENTS;
SELECT AGENT_CODE,AGENT_NAME,substr(AGENT_CODE,2) as AGENT_INITIALS FROM AGENTS;

 -- Methods for concatination (IT CONCATINATES ANY DATATYPE. IF ANY OF THE DATATYPE IS NULL THAT IS TO BE CONCATINATED THEN RESULT WILL BE NULL)
select substr('Pratyush Panda',1,1)||substr('Pratyush Panda',10,1) as initials;
select concat(substr('Pratyush Panda',1,1),substr('Pratyush Panda',10,1))as initials;
select concat('Anand',' India',' Great');
select 'anand' || ' kumar' || ' jha' as full_name;

select AGENT_CODE || ' ' || AGENT_NAME as AGENT_DETAILS 
FROM AGENTS;

select PHONE_NO || ' ' || COUNTRY as DETAILS 
FROM AGENTS;

--LEN 
select LEN('iit hyderabad')as lengthofstring;

select * from DEMO_DATABASE.PUBLIC.PP_CONSUMER_COMPLAINTS;
describe table DEMO_DATABASE.PUBLIC.PP_CONSUMER_COMPLAINTS;


--CONCATING TWO DIFFERENT DATATYPES 
CREATE OR REPLACE VIEW PP_CONSUMER_COMPLAINTS_VIEW AS
SELECT *, CONCAT(ZIP_CODE,PRODUCT_NAME) AS PROD_CODE_DETAILS -- DONT FORGET , AFTER SELECT *
FROM DEMO_DATABASE.PUBLIC.PP_CONSUMER_COMPLAINTS;


DESCRIBE VIEW PP_CONSUMER_COMPLAINTS_VIEW;

SELECT * FROM PP_CONSUMER_COMPLAINTS_VIEW;

--CREATE A VIEW NOT CONTAINING ANY NONE VALUES
create or replace VIEW CUSTOM_CONSUMER_COMPLAINTS_VIEW AS 
SELECT *, CONCAT(STATE_NAME,'-',ZIP_CODE) AS STATE_ZIP_DETAILS
FROM DEMO_DATABASE.PUBLIC.PP_CONSUMER_COMPLAINTS
WHERE SUB_ISSUE IS NOT NULL AND CONSUMER_COMPLAINT_NARRATIVE IS NOT NULL
AND SUB_PRODUCT IS NOT NULL
AND COMPANY_PUBLIC_RESPONSE IS NOT NULL;

SELECT * FROM CUSTOM_CONSUMER_COMPLAINTS_VIEW;


/*
Snowflake CAST is a data-type conversion command. 
Snowflake CAST works similar to the TO_ datatype conversion functions. 
If a particular data type conversion is not possible,
it raises an error. Let’s understand the Snowflake CAST in detail via the syntax and a few examples.
*/

select cast('1.6845' as decimal(4,3));
select '1.6845'::decimal(2,1); -- OUTPUT 1.7

select cast('10-Sep-2021' as timestamp);

-- When the provided precision is insufficient 
-- to hold the input value, the Snowflake CAST command raises an error as follows:
select cast('123.12' as number(4,2));
--Here, precision is set as 4 but the input value has a total of 5 digits, thereby raising the error.
select cast('123.12' as number(4,1)); -- 123.1 O/P

--TRY_CAST( <source_string_expr> AS <target_data_type> )
select try_cast('05-Mar-2016' as timestamp);

--The Snowflake TRY_CAST command returns NULL as the input value 
--has more characters than the provided precision in the target data type.
select try_cast('ANAND' as char(4));

---select cast ('27-09-2012' as timestamp) why is it not taking

select TRY_cast('23-09-1990' as timestamp);-- THIS GIVES NULL AS THE DATE FORMAT IS NOT IN YYYY-MM-DD
select TRY_cast('1990-09-23' as timestamp);


--trim function
-- TRIM FUNCTIONN ONLY DELETES THE LEADING AND THE TRAILING CHARACTERS
select trim('❄-❄ABC-❄-','❄-') as trimmed_string;
select trim('❄-❄ABC-❄-', '❄') as trimmed_string;
select trim('❄-❄ABC-❄-', '-') as trimmed_string;
SELECT TRIM('********T E S T I N G 1 2 3 4********','*') AS TRIMMED_SPACE;
SELECT TRIM('********T E S T I*N*G 1 2 3 4********','*') AS TRIMMED_SPACE;

--ltrim
select Ltrim('#000000123', '0#');
select ltrim('#0000AISHWARYA', '0#');
select ltrim('      ANAND JHA', '');

--RTRIM
select rtrim('$125.00', '0.');
select rtrim('ANAND JHA*****', '*');

select trim(' snowflake documentation file  '); -- successfully trims the spaces from end.