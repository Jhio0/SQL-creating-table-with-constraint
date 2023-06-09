set echo on

spool c:/cprg250s/Really_Cheap_Vacations.txt

DROP TABLE rcv_AGENTTRAINING CASCADE CONSTRAINTS;
DROP TABLE rcv_TOURCUSTOMER CASCADE CONSTRAINTS;
DROP TABLE rcv_TourDestination CASCADE CONSTRAINTS;
DROP TABLE rcv_VACATIONTOUR CASCADE CONSTRAINTS;
DROP TABLE rcv_CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE rcv_Destination;
DROP TABLE RCV_Agent;
DROP TABLE rcv_RATING;
DROP TABLE rcv_TRAINING;

CREATE TABLE rcv_Destination(
    dest_code NUMBER,
	city VARCHAR2(50) NOT NULL,
	state CHAR(2),
	country VARCHAR2(50) NOT NULL,
	dest_description VARCHAR2(100) NOT NULL,
	price NUMBER(10,2) NOT NULL
);

ALTER TABLE rcv_Destination
ADD	CONSTRAINT SYS_DESTINATION_PK PRIMARY KEY (dest_code);

CREATE TABLE RCV_AGENT(
    agent_id NUMBER,
	first_name VARCHAR2(10) NOT NULL,
	last_name VARCHAR2(10) NOT NULL,
	agent_level VARCHAR2(5) NOT NULL,
	yearsExperience NUMBER(2) NOT NULL,
	agent_speciality VARCHAR2(2)
);

ALTER TABLE RCV_Agent
ADD	CONSTRAINT SYS_AGENT_PK PRIMARY KEY (agent_id);

CREATE TABLE rcv_RATING(
    rating_code NUMBER(1) CONSTRAINT SYS_RATING_PK PRIMARY KEY,
	rating_description VARCHAR(50) NOT NULL
);

CREATE TABLE rcv_TRAINING(
    training_code NUMBER(1) CONSTRAINT SYS_TRAINING_PK PRIMARY KEY,
	training_description VARCHAR2(10) NOT NULL,
	durationHours NUMBER(2)
);

CREATE TABLE rcv_VACATIONTOUR(
    tour_code NUMBER,
	tour_description VARCHAR2(20) NOT NULL,
	tour_region VARCHAR2(2) NOT NULL,
	rating_code NUMBER(1),
	CONSTRAINT SYS_VACATIONTOUR_PK PRIMARY KEY (tour_code),
	CONSTRAINT SYS_RAT_VACTOUR_FK FOREIGN KEY (rating_code) REFERENCES rcv_RATING (rating_code)
);

CREATE TABLE rcv_TourDestination(
    tour_code NUMBER (10),
	dest_code NUMBER, 
	order# NUMBER,
	CONSTRAINT SYS_TourDestination_PK PRIMARY KEY (tour_code, dest_code),
	CONSTRAINT SYS_VACTOUR_TOURDEST_FK FOREIGN KEY (tour_code) REFERENCES rcv_VACATIONTOUR (tour_code),
	CONSTRAINT SYS_DEST_TOURDEST_FK FOREIGN KEY (dest_code) REFERENCES rcv_Destination (dest_code)
);

CREATE TABLE rcv_CUSTOMER(
    customer_number NUMBER,
	first_name VARCHAR2(10) NOT NULL,
	last_name VARCHAR2(10) NOT NULL,
	customer_phone VARCHAR2(12) NOT NULL,
	customer_street_address VARCHAR2(20) NOT NULL,
	customer_city VARCHAR2(15) NOT NULL,
	customer_province VARCHAR2(2),
	agent_id NUMBER,
	CONSTRAINT SYS_CUSTOMER_PK PRIMARY KEY (customer_number),
	CONSTRAINT SYS_AGENT_CUST_FK FOREIGN KEY (agent_id) REFERENCES RCV_AGENT (agent_id)
);

CREATE TABLE rcv_TOURCUSTOMER(
    tour_code NUMBER,
	customer_number NUMBER,
	start_date DATE,
	end_date DATE,
	CONSTRAINT SYS_TOURCUSTOMER_PK PRIMARY KEY (tour_code, customer_number),
	CONSTRAINT SYS_VACTOUR_TOURCUST_FK FOREIGN KEY (tour_code) REFERENCES rcv_VACATIONTOUR (tour_code),
	CONSTRAINT SYS_CUST_TOURCUST_FK FOREIGN KEY (customer_number) REFERENCES rcv_CUSTOMER (customer_number)
);

CREATE TABLE rcv_AGENTTRAINING(
    agent_id NUMBER,
	training_code NUMBER(1),
	date_completed DATE NOT NULL,
	CONSTRAINT SYS_AGENTTRAINING_PK PRIMARY KEY (agent_id, training_code),
	CONSTRAINT SYS_AGENT_AGENTTRAIN_FK FOREIGN KEY (agent_id) REFERENCES RCV_AGENT (agent_id),
	CONSTRAINT SYS_TRAIN_AGENTTRAIN_FK FOREIGN KEY (training_code) REFERENCES rcv_TRAINING (training_code)
);

spool off