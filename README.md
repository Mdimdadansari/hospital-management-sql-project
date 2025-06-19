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
