# hospital-management-sql-project
##📌 Project Description
This project analyzes a hospital's patient management and billing system using SQL. The dataset includes information about patients, doctors, appointments, and billing records. It was sourced from Kaggle.

The goal of this project is to extract meaningful insights to support hospital administration decisions, improve patient services, and monitor financial health


##Dataset Structure

patients: Patient demographic data (patient_id,	first_name,	last_name,	gender,	date_of_birth,	contact_number,	address,	registration_date,	insurance_provider,	insurance_number	email )

doctors: Doctor details (doctor_id,	first_name,	last_name,	specialization,	phone_number,	years_experience,	hospital_branch,	email )

appointments: Appointment schedules (appointment_id,	patient_id,	doctor_id,	appointment_date,	appointment_time,	reason_for_visit,	status )

billing: Billing information (bill_id,	patient_id,	treatment_id,	bill_date,	amount,	payment_method,	payment_status )

treatment: treatment schedules (treatment_id,	appointment_id,	treatment_type,	description,	cost,	treatment_date,


## Database setup
 Database creation:The project start by creating a database named city_hospital.
 Table creation :


 create table appointments
(
appointment_id	VARCHAR(30),
patient_id	VARCHAR(30),
doctor_id	VARCHAR(30),
appointment_date	DATE,
appointment_time	TIME,
reason_for_visit	VARCHAR(30),
status VARCHAR(30) 

);


CREATE table billing
(
bill_id	VARCHAR(50),
patient_id	VARCHAR(30),
treatment_id	VARCHAR(50),
bill_date	DATE,
amount	INT,
payment_method	VARCHAR(50),
payment_status VARCHAR(50)

);


create table doctors
(
doctor_id	VARCHAR(50),
first_name	VARCHAR(30),
last_name	VARCHAR(30),
specialization	VARCHAR(50),
phone_number	VARCHAR(15),
years_experience	INT,
hospital_branch VARCHAR(50),
email VARCHAR(50)

);


CREATE TABLE patients
(
patient_id	        VARCHAR(50),
first_name	        VARCHAR(50),
last_name	        VARCHAR(50),
gender	            VARCHAR(30),
date_of_birth	    DATE,
contact_number	    VARCHAR(15),
address	            VARCHAR(70),
registration_date	DATE,
insurance_provider	VARCHAR(50),
insurance_number	VARCHAR(30),
email               VARCHAR(100)

);



CREATE TABLE treatments
(
treatment_id	 VARCHAR(80),
appointment_id	 VARCHAR(80),
treatment_type	 VARCHAR(100),
description	     VARCHAR(500),
cost	         DECIMAL(10,2),
treatment_date   DATE 

);
