#Kolejne zadania odzielone nową linią

CREATE TABLE countries(
COUNTRY_ID varchar(2),
COUNTRY_NAME varchar(40),
REGION_ID decimal(10,0)
);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(2),
COUNTRY_NAME varchar(40),
REGION_ID decimal(10,0)
);

CREATE TABLE IF NOT EXISTS dup_countries
LIKE countries;
# lub
CREATE TABLE IF NOT EXISTS dup_countries
    AS SELECT * FROM countries LIMIT 0;

CREATE TABLE IF NOT EXISTS dup_countries
AS SELECT * FROM  countries;

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(2) NOT NULL,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID decimal(10,0) NOT NULL
);

CREATE TABLE IF NOT EXISTS jobs (
JOB_ID varchar(10) NOT NULL ,
JOB_TITLE varchar(35) NOT NULL,
MIN_SALARY decimal(6,0),
MAX_SALARY decimal(6,0)
CHECK(MAX_SALARY<=25000)
);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(2),
COUNTRY_NAME varchar(40)
CHECK(COUNTRY_NAME IN('Italy','India','China')) ,
REGION_ID decimal(10,0)
);

CREATE TABLE IF NOT EXISTS job_history (
EMPLOYEE_ID decimal(6,0) NOT NULL,
START_DATE date NOT NULL,
END_DATE date NOT NULL
CHECK (END_DATE LIKE '--/--/----'),
JOB_ID varchar(10) NOT NULL,
DEPARTMENT_ID decimal(4,0) NOT NULL
);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(2) NOT NULL,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID decimal(10,0) NOT NULL,
UNIQUE(COUNTRY_ID)
);

CREATE TABLE IF NOT EXISTS jobs (
JOB_ID varchar(10) NOT NULL UNIQUE,
JOB_TITLE varchar(35) NOT NULL DEFAULT ' ',
MIN_SALARY decimal(6,0) DEFAULT 8000,
MAX_SALARY decimal(6,0) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(2) NOT NULL UNIQUE PRIMARY KEY,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID decimal(10,0) NOT NULL
);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID integer NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID decimal(10,0) NOT NULL
);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(2) NOT NULL UNIQUE DEFAULT '',
COUNTRY_NAME varchar(40) DEFAULT NULL,
REGION_ID decimal(10,0) NOT NULL,
PRIMARY KEY (COUNTRY_ID,REGION_ID));

CREATE TABLE job_history (
EMPLOYEE_ID decimal(6,0) NOT NULL PRIMARY KEY,
START_DATE date NOT NULL,
END_DATE date NOT NULL,
JOB_ID varchar(10) NOT NULL,
DEPARTMENT_ID decimal(4,0) DEFAULT NULL,
FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

CREATE TABLE IF NOT EXISTS employees (
EMPLOYEE_ID decimal(6,0) NOT NULL PRIMARY KEY,
FIRST_NAME varchar(20) DEFAULT NULL,
LAST_NAME varchar(25) NOT NULL,
EMAIL varchar(25) NOT NULL,
PHONE_NUMBER varchar(20) DEFAULT NULL,
HIRE_DATE date NOT NULL,
JOB_ID varchar(10) NOT NULL,
SALARY decimal(8,2) DEFAULT NULL,
COMMISSION_PCT decimal(2,2) DEFAULT NULL,
MANAGER_ID decimal(6,0) DEFAULT NULL,
DEPARTMENT_ID decimal(4,0) DEFAULT NULL,
FOREIGN KEY(DEPARTMENT_ID,MANAGER_ID)
REFERENCES  departments(DEPARTMENT_ID,MANAGER_ID)
);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(2) NOT NULL UNIQUE PRIMARY KEY,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID decimal(10,0) NOT NULL
);
INSERT INTO countries VALUES('C1','India',1001);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(2) NOT NULL UNIQUE PRIMARY KEY,
COUNTRY_NAME varchar(40) NOT NULL
);
INSERT INTO countries (country_id,country_name) VALUES('C1','India');

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(2) NOT NULL UNIQUE PRIMARY KEY,
COUNTRY_NAME varchar(40) NOT NULL
);
CREATE TABLE IF NOT EXISTS country_new
AS SELECT * FROM countries;

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(2) NOT NULL UNIQUE PRIMARY KEY,
COUNTRY_NAME varchar (40) NOT NULL,
region_id decimal (10,2));
INSERT INTO countries (country_id,country_name,region_id) VALUES('C1','India',NULL);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID varchar(5) NOT NULL,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID integer NOT NULL,
PRIMARY KEY (COUNTRY_ID,REGION_ID)
);
INSERT INTO countries VALUES('C0001','India',1001),
('C0002','USA',1007),('C0003','UK',1003);

CREATE TABLE country_new(
COUNTRY_ID varchar(5),
COUNTRY_NAME varchar(40),
REGION_ID decimal(10,0)
);
INSERT INTO country_new VALUES('C0001','India',1001),
('C0002','USA',1007),('C0003','UK',1003);
CREATE TABLE countries(
COUNTRY_ID varchar(5),
COUNTRY_NAME varchar(40),
REGION_ID decimal(10,0)
);
INSERT INTO countries
SELECT * FROM country_new;

CREATE TABLE IF NOT EXISTS JOBS (
JOB_ID integer NOT NULL UNIQUE ,
JOB_TITLE varchar(35) NOT NULL,
MIN_SALARY decimal(6,0)
);
INSERT INTO JOBS VALUES(1001,'OFFICER',8000);

CREATE TABLE IF NOT EXISTS jobs (
JOB_ID integer NOT NULL UNIQUE PRIMARY KEY,
JOB_TITLE varchar(35) NOT NULL,
MIN_SALARY decimal(6,0)
);
INSERT INTO jobs VALUES(1001,'OFFICER',8000);


CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID integer NOT NULL,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID integer NOT NULL,
PRIMARY KEY (COUNTRY_ID,REGION_ID)
);
INSERT INTO countries VALUES(501,'India',185);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID integer NOT NULL,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID integer NOT NULL,
PRIMARY KEY (COUNTRY_ID,REGION_ID)
);
INSERT INTO countries VALUES(501,'India',185);

CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID integer NOT NULL
);
INSERT INTO countries(COUNTRY_NAME,REGION_ID) VALUES('India',185);
INSERT INTO countries(COUNTRY_NAME,REGION_ID) VALUES('Japan',102);


CREATE TABLE IF NOT EXISTS countries (
COUNTRY_ID integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
COUNTRY_NAME varchar(40) NOT NULL DEFAULT 'N/A',
REGION_ID integer NOT NULL
);
INSERT INTO countries VALUES(501,'India',102);

CREATE TABLE IF NOT EXISTS jobs (
JOB_ID integer NOT NULL UNIQUE PRIMARY KEY,
JOB_TITLE varchar(35) NOT NULL DEFAULT ' ',
MIN_SALARY decimal(6,0) DEFAULT 8000,
MAX_SALARY decimal(6,0) DEFAULT 20000
);
INSERT INTO jobs(JOB_ID,JOB_TITLE) VALUES(1001,'OFFICER');
INSERT INTO jobs(JOB_ID,JOB_TITLE) VALUES(1002,'CLERK');
CREATE TABLE job_history (
EMPLOYEE_ID integer NOT NULL PRIMARY KEY,
JOB_ID integer NOT NULL,
DEPARTMENT_ID integer DEFAULT NULL,
FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);
INSERT INTO job_history VALUES(501,1001,60);
INSERT INTO job_history VALUES(502,1003,80);


#13

CREATE TABLE IF NOT EXISTS departments (
DEPARTMENT_ID integer NOT NULL UNIQUE,
DEPARTMENT_NAME varchar(30) NOT NULL,
MANAGER_ID integer DEFAULT NULL,
LOCATION_ID integer DEFAULT NULL,
PRIMARY KEY (DEPARTMENT_ID)
);
INSERT INTO departments VALUES(60,'SALES',201,89);
INSERT INTO departments VALUES(61,'ACCOUNTS',201,89);
CREATE TABLE IF NOT EXISTS jobs (
JOB_ID integer NOT NULL UNIQUE PRIMARY KEY,
JOB_TITLE varchar(35) NOT NULL DEFAULT ' ',
MIN_SALARY decimal(6,0) DEFAULT 8000,
MAX_SALARY decimal(6,0) DEFAULT 20000
);
INSERT INTO jobs(JOB_ID,JOB_TITLE) VALUES(1001,'OFFICER');
INSERT INTO jobs(JOB_ID,JOB_TITLE) VALUES(1002,'CLERK');
CREATE TABLE IF NOT EXISTS employees (
EMPLOYEE_ID integer NOT NULL PRIMARY KEY,
FIRST_NAME varchar(20) DEFAULT NULL,
LAST_NAME varchar(25) NOT NULL,
DEPARTMENT_ID integer DEFAULT NULL,
FOREIGN KEY(DEPARTMENT_ID)
REFERENCES  departments(DEPARTMENT_ID),
JOB_ID integer NOT NULL,
FOREIGN KEY(JOB_ID)
REFERENCES  jobs(JOB_ID),
SALARY decimal(8,2) DEFAULT NULL
);
INSERT INTO employees VALUES(510,'Alex','Hanes',60,1001,18000);
INSERT INTO employees VALUES(511,'Tom','Elan',60,1003,22000);

UPDATE employees SET email='not available';

UPDATE employees SET email='not available',
commission_pct=0.10;

UPDATE employees
SET email='not available',
commission_pct=0.10
WHERE department_id=110;

UPDATE employees
SET email='not available'
WHERE department_id=80 AND commission_pct<.20;

UPDATE employees
SET email='not available'
WHERE department_id=(
SELECT department_id
FROM departments
WHERE department_name='Accounting');

UPDATE employees SET SALARY = 8000 WHERE employee_id = 105 AND salary < 5000;

UPDATE employees SET JOB_ID= 'SH_CLERK'
WHERE employee_id=118
AND department_id=30
AND NOT JOB_ID LIKE 'SH%';

UPDATE employees SET salary= CASE department_id
                          WHEN 40 THEN salary+(salary*.25)
                          WHEN 90 THEN salary+(salary*.15)
                          WHEN 110 THEN salary+(salary*.10)
                          ELSE salary
                        END
             WHERE department_id IN (40,50,50,60,70,80,90,110);

UPDATE jobs,employees
SET jobs.min_salary=jobs.min_salary+2000,
jobs.max_salary=jobs.max_salary+2000,
employees.salary=employees.salary+(employees.salary*.20),
employees.commission_pct=employees.commission_pct+.10
WHERE jobs.job_id='PU_CLERK'
AND employees.job_id='PU_CLERK';

ALTER TABLE countries RENAME country_new;

ALTER TABLE locations
ADD region_id  INT;

ALTER TABLE locations
ADD ID INT FIRST;

ALTER TABLE locations
ADD region_id INT
AFTER state_province;

ALTER TABLE locations
MODIFY country_id INT;

ALTER TABLE locations
DROP city;

ALTER TABLE locations
CHANGE state_province state varchar(25);

ALTER TABLE locations
ADD PRIMARY KEY(location_id);

ALTER TABLE locations
ADD PRIMARY KEY(location_id,country_id);

ALTER TABLE locations DROP PRIMARY KEY;

ALTER TABLE job_history
ADD FOREIGN KEY(job_id)
REFERENCES jobs(job_id);

ALTER TABLE job_history
ADD CONSTRAINT fk_job_id
FOREIGN KEY (job_id)
REFERENCES jobs(job_id);

ALTER TABLE job_history
DROP FOREIGN KEY fk_job_id;

ALTER TABLE job_history
ADD INDEX indx_job_id(job_id);

ALTER TABLE job_history
DROP INDEX indx_job_id;



