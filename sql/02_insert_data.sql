-- ============================================
-- HOSPITAL MANAGEMENT SYSTEM - SAMPLE DATA
-- CS27 End-of-Semester Project
-- Burkina Institute of Technology
-- ============================================

USE hospital_management;

-- ============================================
-- INSERT DATA: DEPARTMENTS
-- 10 hospital departments
-- ============================================
INSERT INTO departments (name, location, phone) VALUES
('Cardiology', 'Building A, Floor 2', '+226 25 30 40 01'),
('Pediatrics', 'Building B, Floor 1', '+226 25 30 40 02'),
('Neurology', 'Building A, Floor 3', '+226 25 30 40 03'),
('Orthopedics', 'Building C, Floor 1', '+226 25 30 40 04'),
('Dermatology', 'Building B, Floor 2', '+226 25 30 40 05'),
('Radiology', 'Building C, Floor 2', '+226 25 30 40 06'),
('Emergency', 'Building D, Ground Floor', '+226 25 30 40 07'),
('Obstetrics', 'Building A, Floor 1', '+226 25 30 40 08'),
('Psychiatry', 'Building B, Floor 3', '+226 25 30 40 09'),
('General Medicine', 'Building A, Ground Floor', '+226 25 30 40 10');

-- ============================================
-- INSERT DATA: DOCTORS
-- 10 doctors with Burkinabè names
-- ============================================
INSERT INTO doctors (first_name, last_name, specialization, phone, email, license_number, department_id, hire_date) VALUES
('Amadou', 'Ouedraogo', 'Cardiologist', '+226 70 11 22 33', 'a.ouedraogo@hospital.bf', 'MD-001-2020', 1, '2020-01-15'),
('Fatima', 'Sawadogo', 'Pediatrician', '+226 70 22 33 44', 'f.sawadogo@hospital.bf', 'MD-002-2019', 2, '2019-03-20'),
('Ibrahim', 'Kabore', 'Neurologist', '+226 70 33 44 55', 'i.kabore@hospital.bf', 'MD-003-2021', 3, '2021-06-10'),
('Mariama', 'Traore', 'Orthopedic Surgeon', '+226 70 44 55 66', 'm.traore@hospital.bf', 'MD-004-2018', 4, '2018-09-05'),
('Boureima', 'Compaore', 'Dermatologist', '+226 70 55 66 77', 'b.compaore@hospital.bf', 'MD-005-2022', 5, '2022-01-12'),
('Aissata', 'Zongo', 'Radiologist', '+226 70 66 77 88', 'a.zongo@hospital.bf', 'MD-006-2020', 6, '2020-07-22'),
('Souleymane', 'Yameogo', 'Emergency Physician', '+226 70 77 88 99', 's.yameogo@hospital.bf', 'MD-007-2019', 7, '2019-11-30'),
('Rasmata', 'Compaore', 'Obstetrician', '+226 70 88 99 00', 'r.compaore@hospital.bf', 'MD-008-2021', 8, '2021-04-18'),
('Ismael', 'Konate', 'Psychiatrist', '+226 70 99 00 11', 'i.konate@hospital.bf', 'MD-009-2020', 9, '2020-10-25'),
('Zalissa', 'Nacro', 'General Practitioner', '+226 70 00 11 22', 'z.nacro@hospital.bf', 'MD-010-2022', 10, '2022-02-14');

-- ============================================
-- INSERT DATA: PATIENTS
-- 10 patients with local addresses
-- ============================================
INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone, email, address, blood_group, allergies, emergency_contact) VALUES
('Alice', 'Kabore', '1985-03-15', 'Female', '+226 71 11 11 11', 'alice.k@email.com', 'Ouaga 2000, Secteur 15', 'O+', 'Penicillin', '+226 71 99 99 99'),
('Bob', 'Traore', '1990-07-22', 'Male', '+226 71 22 22 22', 'bob.t@email.com', 'Cissin, Secteur 10', 'A+', 'None', '+226 71 88 88 88'),
('Charlie', 'Sawadogo', '2010-12-05', 'Male', '+226 71 33 33 33', 'charlie.s@email.com', 'Gounghin, Secteur 5', 'B+', 'Peanuts', '+226 71 77 77 77'),
('Diana', 'Ouedraogo', '1978-09-18', 'Female', '+226 71 44 44 44', 'diana.o@email.com', 'Dassasgho, Secteur 3', 'AB+', 'Latex', '+226 71 66 66 66'),
('Eric', 'Zongo', '1995-01-30', 'Male', '+226 71 55 55 55', 'eric.z@email.com', 'Paspanga, Secteur 25', 'O-', 'None', '+226 71 55 55 56'),
('Fatou', 'Compaore', '1988-11-11', 'Female', '+226 71 66 66 66', 'fatou.c@email.com', 'Zone 4, Secteur 30', 'A-', 'Sulfa drugs', '+226 71 44 44 45'),
('Georges', 'Yameogo', '2005-04-25', 'Male', '+226 71 77 77 77', 'georges.y@email.com', 'Tanghin, Secteur 18', 'B-', 'None', '+226 71 33 33 34'),
('Hawa', 'Konate', '1982-08-08', 'Female', '+226 71 88 88 88', 'hawa.k@email.com', 'Samandin, Secteur 12', 'AB-', 'Iodine', '+226 71 22 22 23'),
('Ibrahim', 'Nacro', '1970-05-14', 'Male', '+226 71 99 99 99', 'ibrahim.n@email.com', 'Bogodogo, Secteur 20', 'O+', 'Aspirin', '+226 71 11 11 12'),
('Juliette', 'Sana', '1998-02-20', 'Female', '+226 71 00 00 00', 'juliette.s@email.com', 'Kossodo, Secteur 7', 'A+', 'None', '+226 71 00 00 01');

-- ============================================
-- INSERT DATA: APPOINTMENTS
-- 12 appointments with various statuses
-- ============================================
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status, reason) VALUES
(1, 1, '2026-03-10', '09:00:00', 'Completed', 'Regular cardiac checkup'),
(2, 10, '2026-03-10', '10:30:00', 'Completed', 'Flu symptoms'),
(3, 2, '2026-03-11', '14:00:00', 'Scheduled', 'Vaccination'),
(4, 3, '2026-03-11', '11:00:00', 'Completed', 'Migraine consultation'),
(5, 4, '2026-03-12', '15:30:00', 'Scheduled', 'Knee pain'),
(1, 1, '2026-03-13', '09:30:00', 'Scheduled', 'Follow-up cardiac visit'),
(6, 5, '2026-03-13', '10:00:00', 'Completed', 'Skin rash'),
(7, 2, '2026-03-14', '08:00:00', 'Scheduled', 'Annual pediatric checkup'),
(8, 9, '2026-03-14', '16:00:00', 'Completed', 'Anxiety issues'),
(9, 1, '2026-03-15', '11:30:00', 'Cancelled', 'Chest pain'),
(10, 8, '2026-03-16', '09:00:00', 'Scheduled', 'Prenatal visit'),
(2, 7, '2026-03-16', '13:00:00', 'Completed', 'Emergency - accident');

-- ============================================
-- INSERT DATA: PRESCRIPTIONS
-- Medications prescribed during consultations
-- ============================================
INSERT INTO prescriptions (appointment_id, medication_name, dosage, frequency, duration, instructions) VALUES
(1, 'Aspirin', '100mg', 'Once daily', '30 days', 'Take with food'),
(1, 'Metoprolol', '50mg', 'Twice daily', '30 days', 'Take in the morning and evening'),
(2, 'Paracetamol', '500mg', 'Three times daily', '5 days', 'Take after meals'),
(2, 'Amoxicillin', '250mg', 'Twice daily', '7 days', 'Complete full course'),
(4, 'Sumatriptan', '50mg', 'As needed', '10 days', 'Maximum 2 doses per day'),
(7, 'Hydrocortisone cream', '1%', 'Apply twice daily', '14 days', 'Apply to affected area only'),
(9, 'Lorazepam', '0.5mg', 'Once daily at bedtime', '14 days', 'May cause drowsiness'),
(12, 'Ibuprofen', '400mg', 'Three times daily', '3 days', 'Take with food'),
(12, 'Antibiotics ointment', 'Apply', 'Twice daily', '7 days', 'For wound care');

-- ============================================
-- INSERT DATA: MEDICAL_RECORDS
-- Patient visit history
-- ============================================
INSERT INTO medical_records (patient_id, doctor_id, visit_date, diagnosis, treatment, notes) VALUES
(1, 1, '2026-03-10', 'Stable angina', 'Prescribed aspirin and beta-blocker', 'Patient shows improvement'),
(2, 10, '2026-03-10', 'Viral upper respiratory infection', 'Symptomatic treatment', 'Rest advised'),
(4, 3, '2026-03-11', 'Migraine with aura', 'Prescribed triptan medication', 'Advised to avoid triggers'),
(6, 5, '2026-03-13', 'Contact dermatitis', 'Topical corticosteroid prescribed', 'Avoid allergen'),
(8, 9, '2026-03-14', 'Generalized anxiety disorder', 'Started on anxiolytic, referred for therapy', 'Follow-up in 2 weeks'),
(2, 7, '2026-03-16', 'Minor laceration from bicycle accident', 'Wound cleaned, sutured, tetanus shot given', 'Remove sutures in 7 days'),
(1, 1, '2025-09-15', 'Hypertension', 'Lifestyle modification counseling', 'Blood pressure 145/90'),
(3, 2, '2025-12-20', 'Common cold', 'Symptomatic relief', 'Plenty of fluids'),
(7, 2, '2026-01-10', 'Growth and development assessment', 'Normal development for age', 'Next visit in 6 months'),
(9, 1, '2024-11-05', 'Atrial fibrillation', 'Anticoagulation therapy initiated', 'Regular monitoring required');

-- ============================================
-- VERIFY DATA INSERTION
-- ============================================

-- Show record counts
SELECT 
    'Departments' AS Table_Name, COUNT(*) AS Record_Count FROM departments
UNION ALL
SELECT 'Doctors', COUNT(*) FROM doctors
UNION ALL
SELECT 'Patients', COUNT(*) FROM patients
UNION ALL
SELECT 'Appointments', COUNT(*) FROM appointments
UNION ALL
SELECT 'Prescriptions', COUNT(*) FROM prescriptions
UNION ALL
SELECT 'Medical_Records', COUNT(*) FROM medical_records;

-- Success message
SELECT 'Data insertion completed successfully!' AS Status;
