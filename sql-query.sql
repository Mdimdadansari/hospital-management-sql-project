-- . List all patients older than 50

SELECT 
    *,
    TIMESTAMPDIFF(YEAR,
        DATE_OF_BIRTH,
        CURDATE()) AS AGE
FROM
    patients
WHERE
    TIMESTAMPDIFF(YEAR,
        DATE_OF_BIRTH,
        CURDATE()) > 50
ORDER BY 1;


 -- . Get all female patients
 
 SELECT 
    *
FROM
    patients
WHERE
    gender = 'F';
    
-- . List all doctors ordered by name (A–Z)

SELECT 
    doctor_id, CONCAT(first_name, ' ', last_name) AS Full_name
FROM
    doctors
ORDER BY 2 ;


-- . Count of patients by gender

SELECT 
    gender, COUNT(*)
FROM
    patients
GROUP BY gender;


-- . List top 5 most recent appointments

SELECT 
    *, DATEDIFF(appointment_date, CURRENT_DATE) AS days
FROM
    appointments
ORDER BY days DESC
LIMIT 5;


-- . Get total number of appointments per doctor

SELECT 
    doctor_id, COUNT(appointment_id) AS total_appoinmennt
FROM
    appointments
GROUP BY doctor_id
ORDER BY 1;


-- . Find patients living in '456 Oak Ave'

SELECT 
    *
FROM
    patients
WHERE
    address LIKE ('456 Oak Ave');

-- ) Number of appointments per patient:


SELECT 
    patient_id, COUNT(appointment_id)
FROM
    appointments
GROUP BY patient_id
ORDER BY patient_id;

-- ) ifyou would like to show the name also then --->

SELECT 
    a.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    COUNT(*)
FROM
    appointments a
        JOIN
    patients p ON a.patient_id = p.patient_id
GROUP BY a.patient_id , CONCAT(p.first_name, ' ', p.last_name)
ORDER BY a.patient_id;


-- ) Patients with no appointments (This is for cancelled and no show)

SELECT 
    *
FROM
    appointments
WHERE
    status IN ('No-show' , 'Cancelled');

-- > ( This is for zero,Null or No appointments)

SELECT 
    *
FROM
    appointments
WHERE
    appointment_id IS NULL;
 

-- )Top 5 doctors by patient return rate (repeated visits by same patient)

select doctor_id,
count(appointment_id) as appointmnnt,
count(distinct patient_id) as unique_patient 
from appointments
group by doctor_id
having count(appointment_id)>5;


-- ) Monthly appointment counts ( this is day wise)

select month(appointment_date) as monthh_number,
(appointment_date) as monthh_name,
count(appointment_id) as appointmentt
from appointments 
group by monthh_number,monthh_name
order by 1,2;

-- this is for month-wise

select monthname(appointment_date) as monthh_name,
COUNT(appointment_id) as appointmennt
from appointments
group by monthh_name;


-- )Total billing amount per appointment (with doctors)


select a.doctor_id, a.appointment_id, sum(b.amount) 
from appointments a
join billing b
on a.patient_id = b.patient_id
group by a.doctor_id, a.appointment_id
order by 1;

-- .List patients with their doctor's name

SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    p.patient_id
FROM
    patients p
        JOIN
    appointments a ON p.patient_id = a.patient_id
        JOIN
    doctors d ON a.doctor_id = d.doctor_id;


-- .List of doctors with their total number of patients

SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    COUNT(p.patient_id) AS total_patients
FROM
    patients p
        JOIN
    appointments a ON p.patient_id = a.patient_id
        JOIN
    doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id , CONCAT(d.first_name, ' ', d.last_name)
ORDER BY 1;



-- . Total billing amount per patient

SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    SUM(amount) AS total_billing
FROM
    patients p
        JOIN
    billing b ON p.patient_id = b.patient_id
GROUP BY p.patient_id , full_name
ORDER BY 1;


-- . List of patients who missed their appointments (No-Show)

SELECT 
    *
FROM
    appointments
WHERE
    status = 'No-show';
    
    
-- . Total number of cancelled appointments by doctor   

SELECT 
    doctor_id, COUNT(*)
FROM
    appointments
WHERE
    status = 'cancelled'
GROUP BY doctor_id
ORDER BY 1;


-- .Month-wise appointment status summary

SELECT 
    MONTHNAME(appointment_date) AS month,
    status,
    COUNT(*) AS total
FROM
    appointments
GROUP BY MONTHNAME(appointment_date) , status
ORDER BY 1;


-- . List the latest appointment date for each patient

select * 
from
(select patient_id, appointment_date ,
 rank() over (partition by patient_id order by appointment_date desc) as rankk
from appointments
order by 1,2 desc) as rnk
where rankk = 1;

-- (you can also do with this )

SELECT 
    patient_id, MIN(appointment_date) AS last_visit
FROM
    appointments
GROUP BY patient_id
ORDER BY 1;


-- . Find total appointments in the last month


SELECT 
    MONTHNAME(appointment_date) AS month, COUNT(*)
FROM
    appointments
GROUP BY 1
HAVING month = 'December';


-- . Patients who spent more than average bill amount

SELECT 
    p.patient_id, SUM(b.amount) AS total_spent
FROM
    patients p
        JOIN
    appointments a ON p.patient_id = a.patient_id
        JOIN
    billing b ON a.patient_id = b.patient_id
GROUP BY p.patient_id
HAVING total_spent > (SELECT 
        AVG(amount)
    FROM
        billing);
        
        
-- . Top 3 doctors by total revenue 

SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS full_name,
    d.specialization,
    SUM(b.amount) AS total_amount
FROM
    doctors d
        JOIN
    appointments a ON d.doctor_id = a.doctor_id
        JOIN
    billing b ON a.patient_id = b.patient_id
GROUP BY d.doctor_id , CONCAT(d.first_name, ' ', d.last_name) , d.specialization
ORDER BY total_amount DESC
LIMIT 3;



-- . Top 5 patient with the highest total bill using 

SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    SUM(b.amount) AS total_bill
FROM
    patients p
        JOIN
    billing b ON p.patient_id = b.patient_id
GROUP BY p.patient_id , CONCAT(p.first_name, ' ', p.last_name)
ORDER BY total_bill DESC
LIMIT 5;  


-- .Label billing as 'High', 'Medium', or 'Low'

SELECT 
    *,
    CASE
        WHEN amount >= 3500 THEN 'High'
        WHEN amount >= 2000 THEN 'Medium'
        ELSE 'Low'
    END AS billing_category
FROM
    billing;


  -- ) Total appointments per doctor:
 
SELECT 
    a.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments
FROM
    appointments a
        JOIN
    doctors d ON a.doctor_id = d.doctor_id
GROUP BY a.doctor_id , CONCAT(d.first_name, ' ', d.last_name) , d.specialization
ORDER BY 1;



 -- )Doctor-wise monthly appointment trend


SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS full_name,
    COUNT(a.appointment_id) AS appointmennt,
    MONTHNAME(a.appointment_date) AS monthly
FROM
    doctors d
        JOIN
    appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id , CONCAT(d.first_name, ' ', d.last_name) , MONTHNAME(a.appointment_date)
ORDER BY 1,4;










 

 



