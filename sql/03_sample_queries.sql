-- ============================================
-- HOSPITAL MANAGEMENT SYSTEM - SAMPLE QUERIES
-- CS27 End-of-Semester Project
-- Demonstrates all required SQL operations
-- ============================================

USE hospital_management;

-- ============================================
-- PART 2.3: UPDATE AND DELETE STATEMENTS
-- ============================================

-- ===== 3 UPDATE STATEMENTS =====

-- Update 1: Change appointment status
UPDATE appointments
SET status = 'Completed'
WHERE appointment_id = 3;

-- Update 2: Update patient contact information
UPDATE patients
SET phone = '+226 71 11 11 12', 
    email = 'alice.kabore.new@email.com'
WHERE patient_id = 1;

-- Update 3: Update all doctors in Cardiology department
UPDATE doctors
SET email = CONCAT(LOWER(first_name), '.', LOWER(last_name), '@newhospital.bf')
WHERE department_id = 1;

-- ===== 2 DELETE STATEMENTS =====

-- Delete 1: Remove cancelled appointments
DELETE FROM appointments
WHERE status = 'Cancelled';

-- Delete 2: Remove a specific prescription
DELETE FROM prescriptions
WHERE prescription_id = 9;

-- ===== REFERENTIAL INTEGRITY DEMONSTRATION =====

-- Attempt to delete a patient who has appointments
-- This will CASCADE and delete all related appointments and prescriptions
SELECT 'Before DELETE:' AS Action, COUNT(*) AS Appointments 
FROM appointments WHERE patient_id = 1;

DELETE FROM patients WHERE patient_id = 1;

SELECT 'After DELETE:' AS Action, COUNT(*) AS Appointments 
FROM appointments WHERE patient_id = 1;
-- Result: 0 (all appointments deleted via CASCADE)


-- ============================================
-- PART 2.4: SELECT QUERIES (15 marks)
-- ============================================

-- ===== 1. Retrieve all records from a table (1 mark) =====
SELECT * FROM patients;

-- ===== 2. Specific columns with WHERE condition (1 mark) =====
SELECT first_name, last_name, specialization
FROM doctors
WHERE specialization = 'Cardiologist';

-- ===== 3. Sorted results using ORDER BY (1 mark) =====
SELECT first_name, last_name, date_of_birth
FROM patients
ORDER BY date_of_birth ASC;

-- ===== 4. Limited results using LIMIT (1 mark) =====
SELECT first_name, last_name, appointment_date, status
FROM appointments
JOIN patients ON appointments.patient_id = patients.patient_id
ORDER BY appointment_date DESC
LIMIT 5;

-- ===== 5. Filter using BETWEEN, LIKE, or IN (2 marks) =====

-- BETWEEN: Appointments in a date range
SELECT * FROM appointments
WHERE appointment_date BETWEEN '2026-03-10' AND '2026-03-15';

-- LIKE: Patients whose name starts with 'A'
SELECT first_name, last_name, phone
FROM patients
WHERE first_name LIKE 'A%';

-- IN: Doctors from specific departments
SELECT first_name, last_name, specialization
FROM doctors
WHERE department_id IN (1, 2, 3);

-- ===== 6. INNER JOIN across two tables (2 marks) =====
SELECT 
    patients.first_name AS Patient_FirstName,
    patients.last_name AS Patient_LastName,
    doctors.first_name AS Doctor_FirstName,
    doctors.last_name AS Doctor_LastName,
    appointments.appointment_date,
    appointments.status
FROM appointments
INNER JOIN patients ON appointments.patient_id = patients.patient_id
INNER JOIN doctors ON appointments.doctor_id = doctors.doctor_id;

-- ===== 7. LEFT JOIN - explain difference (2 marks) =====

-- LEFT JOIN: Shows ALL patients, even those without appointments
SELECT 
    patients.first_name,
    patients.last_name,
    appointments.appointment_id,
    appointments.appointment_date
FROM patients
LEFT JOIN appointments ON patients.patient_id = appointments.patient_id;

/*
EXPLANATION OF DIFFERENCE:
- INNER JOIN: Returns only patients WHO HAVE appointments
- LEFT JOIN: Returns ALL patients, with NULL for those WITHOUT appointments

Example:
If a patient has no appointments:
- INNER JOIN: Patient won't appear in results
- LEFT JOIN: Patient appears with NULL in appointment columns
*/

-- ===== 8. JOIN across three or more tables (3 marks) =====

-- Four-table JOIN: Patient → Appointment → Doctor → Department → Prescription
SELECT 
    patients.first_name AS Patient,
    patients.last_name AS Patient_Surname,
    doctors.first_name AS Doctor,
    doctors.last_name AS Doctor_Surname,
    departments.name AS Department,
    appointments.appointment_date,
    appointments.status,
    prescriptions.medication_name,
    prescriptions.dosage
FROM appointments
JOIN patients ON appointments.patient_id = patients.patient_id
JOIN doctors ON appointments.doctor_id = doctors.doctor_id
JOIN departments ON doctors.department_id = departments.department_id
LEFT JOIN prescriptions ON appointments.appointment_id = prescriptions.appointment_id
WHERE appointments.status = 'Completed';

-- ===== 9. Query using IS NULL or IS NOT NULL (2 marks) =====

-- Patients without email
SELECT first_name, last_name, phone
FROM patients
WHERE email IS NULL;

-- Patients with allergies (excluding 'None')
SELECT first_name, last_name, allergies
FROM patients
WHERE allergies IS NOT NULL AND allergies != 'None';


-- ============================================
-- PART 3: AGGREGATE FUNCTIONS & REPORTING (15 marks)
-- ============================================

-- ===== COUNT total records in a table (2 marks) =====
SELECT COUNT(*) AS Total_Patients FROM patients;

-- Count by status
SELECT status, COUNT(*) AS Total
FROM appointments
GROUP BY status;

-- ===== MAX and MIN of a numeric column (2 marks) =====

-- Youngest and oldest patient
SELECT 
    MAX(date_of_birth) AS Youngest_DOB,
    MIN(date_of_birth) AS Oldest_DOB,
    YEAR(CURDATE()) - YEAR(MAX(date_of_birth)) AS Youngest_Age,
    YEAR(CURDATE()) - YEAR(MIN(date_of_birth)) AS Oldest_Age
FROM patients;

-- Earliest and latest appointment
SELECT 
    MIN(appointment_date) AS First_Appointment,
    MAX(appointment_date) AS Last_Appointment
FROM appointments;

-- ===== AVG of a numeric column (2 marks) =====

-- Average age of patients
SELECT 
    AVG(YEAR(CURDATE()) - YEAR(date_of_birth)) AS Average_Age
FROM patients;

-- Average number of appointments per patient
SELECT 
    AVG(appointment_count) AS Avg_Appointments_Per_Patient
FROM (
    SELECT patient_id, COUNT(*) AS appointment_count
    FROM appointments
    GROUP BY patient_id
) AS patient_appointments;

-- ===== GROUP BY with an aggregate function (3 marks) =====

-- Number of doctors per department
SELECT 
    departments.name AS Department,
    COUNT(doctors.doctor_id) AS Number_of_Doctors
FROM departments
LEFT JOIN doctors ON departments.department_id = doctors.department_id
GROUP BY departments.department_id, departments.name
ORDER BY Number_of_Doctors DESC;

-- Appointments per doctor
SELECT 
    doctors.first_name,
    doctors.last_name,
    COUNT(appointments.appointment_id) AS Total_Appointments
FROM doctors
LEFT JOIN appointments ON doctors.doctor_id = appointments.doctor_id
GROUP BY doctors.doctor_id, doctors.first_name, doctors.last_name
ORDER BY Total_Appointments DESC;

-- ===== HAVING to filter grouped results (3 marks) =====

-- Patients with more than 1 appointment
SELECT 
    patients.first_name,
    patients.last_name,
    COUNT(appointments.appointment_id) AS Total_Appointments
FROM patients
JOIN appointments ON patients.patient_id = appointments.patient_id
GROUP BY patients.patient_id, patients.first_name, patients.last_name
HAVING COUNT(appointments.appointment_id) > 1
ORDER BY Total_Appointments DESC;

-- Doctors who have treated at least 1 patient
SELECT 
    doctors.first_name,
    doctors.last_name,
    COUNT(DISTINCT appointments.patient_id) AS Unique_Patients
FROM doctors
JOIN appointments ON doctors.doctor_id = appointments.doctor_id
GROUP BY doctors.doctor_id, doctors.first_name, doctors.last_name
HAVING COUNT(DISTINCT appointments.patient_id) >= 1
ORDER BY Unique_Patients DESC;

-- ===== Summary report: JOIN + GROUP BY + HAVING (3 marks) =====

-- COMPREHENSIVE DOCTOR PERFORMANCE REPORT
-- This is our most complex query - demonstrates everything learned
SELECT 
    doctors.first_name AS Doctor_FirstName,
    doctors.last_name AS Doctor_LastName,
    departments.name AS Department,
    doctors.specialization,
    COUNT(DISTINCT appointments.patient_id) AS Total_Patients_Treated,
    COUNT(DISTINCT appointments.appointment_id) AS Total_Appointments,
    COUNT(DISTINCT CASE WHEN appointments.status = 'Completed' THEN appointments.appointment_id END) AS Completed_Appointments,
    COUNT(prescriptions.prescription_id) AS Total_Prescriptions_Written,
    ROUND(COUNT(prescriptions.prescription_id) / NULLIF(COUNT(DISTINCT appointments.appointment_id), 0), 2) AS Avg_Prescriptions_Per_Appointment
FROM doctors
JOIN departments ON doctors.department_id = departments.department_id
LEFT JOIN appointments ON doctors.doctor_id = appointments.doctor_id
LEFT JOIN prescriptions ON appointments.appointment_id = prescriptions.appointment_id
GROUP BY 
    doctors.doctor_id, 
    doctors.first_name, 
    doctors.last_name, 
    departments.name,
    doctors.specialization
HAVING COUNT(DISTINCT appointments.appointment_id) > 0
ORDER BY 
    Total_Patients_Treated DESC, 
    Total_Prescriptions_Written DESC;

/*
WHAT THIS QUERY DEMONSTRATES:
✓ Four-table JOIN (doctors, departments, appointments, prescriptions)
✓ COUNT DISTINCT to avoid duplicates
✓ CASE statement for conditional counting
✓ GROUP BY with multiple columns
✓ HAVING clause to filter aggregated results
✓ ORDER BY multiple columns
✓ Real-world business intelligence reporting

USE CASE:
Hospital administration uses this for:
- Performance reviews
- Workload balancing
- Resource allocation
- Identifying high-performing doctors
*/


-- ============================================
-- BONUS QUERIES: ADDITIONAL USEFUL REPORTS
-- ============================================

-- Report: Busiest days for appointments
SELECT 
    appointment_date,
    COUNT(*) AS Total_Appointments,
    COUNT(CASE WHEN status = 'Completed' THEN 1 END) AS Completed,
    COUNT(CASE WHEN status = 'Scheduled' THEN 1 END) AS Scheduled,
    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS Cancelled
FROM appointments
GROUP BY appointment_date
ORDER BY Total_Appointments DESC;

-- Report: Most common prescriptions
SELECT 
    medication_name,
    COUNT(*) AS Times_Prescribed,
    GROUP_CONCAT(DISTINCT dosage) AS Common_Dosages
FROM prescriptions
GROUP BY medication_name
ORDER BY Times_Prescribed DESC;

-- Report: Patient demographics by blood group
SELECT 
    blood_group,
    COUNT(*) AS Patient_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patients), 2) AS Percentage
FROM patients
WHERE blood_group IS NOT NULL
GROUP BY blood_group
ORDER BY Patient_Count DESC;

-- Report: Appointment completion rate by doctor
SELECT 
    doctors.first_name,
    doctors.last_name,
    COUNT(*) AS Total_Appointments,
    SUM(CASE WHEN appointments.status = 'Completed' THEN 1 ELSE 0 END) AS Completed,
    ROUND(SUM(CASE WHEN appointments.status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Completion_Rate_Percent
FROM doctors
JOIN appointments ON doctors.doctor_id = appointments.doctor_id
GROUP BY doctors.doctor_id, doctors.first_name, doctors.last_name
HAVING COUNT(*) > 0
ORDER BY Completion_Rate_Percent DESC;

-- ============================================
-- END OF SAMPLE QUERIES
-- ============================================

SELECT '✅ All queries executed successfully!' AS Status;
