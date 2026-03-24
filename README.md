# 🏥 Hospital Management System - Database Project

**CS27 – The Relational Model & Databases**  
**End-of-Semester Group Project**  
**Burkina Institute of Technology**

---

## 📋 Table of Contents

- [Overview](#overview)
- [Team Members](#team-members)
- [Problem Statement](#problem-statement)
- [Database Design](#database-design)
- [Implementation](#implementation)
- [Installation & Setup](#installation--setup)
- [Sample Queries](#sample-queries)
- [Video Demonstration](#video-demonstration)
- [Technologies Used](#technologies-used)
- [Project Deliverables](#project-deliverables)
- [Academic Integrity](#academic-integrity)
- [Contact](#contact)

---

## 🎯 Overview

This project implements a comprehensive **Hospital Management System** using a relational database design in MySQL. The system manages patient records, doctor information, appointments, prescriptions, and medical records while ensuring data integrity, eliminating redundancy, and maintaining efficient query performance.

**Key Features:**
- ✅ Fully normalized database (1NF, 2NF, 3NF)
- ✅ 6 interconnected tables with referential integrity
- ✅ 10+ realistic records per table with authentic Burkinabè data
- ✅ Complex SQL queries demonstrating JOINs, aggregates, and reporting
- ✅ Real-world healthcare scenarios addressing actual hospital challenges

---

## 👥 Team Members

Our team consists of six active members who collaborated on this project:

- **Kader ZARANI** (Group Leader) - Project Coordination, GitHub Management & Final Submission
- **Zangafigue Mathias TRAORE** - Database Design, MySQL Implementation & Technical Lead
- **Ange Carelle NOMBRE** - Documentation, Technical Writing & README Maintenance
- **Israël NKUNA** - PowerPoint Presentation Design & Visual Schema Creation
- **Jonathan OUEDRAOGO** - Data Population, Testing & Quality Assurance
- **Betsaleel NACOULMA** - Video Production, Recording & Editing

**Note:** Keya BASSINGA, our seventh team member, was unable to participate in the project due to health reasons. We wish him a speedy recovery. His assigned tasks were redistributed among the remaining team members to ensure project completion.

---

## 🔍 Problem Statement

Modern hospitals face significant challenges in managing their data effectively:

### **1. Patient Information Management**
How do hospitals track thousands of patients with complete medical histories, allergies, blood types, and emergency contacts? Traditional paper-based systems or poorly designed databases create inefficiencies and errors.

### **2. Appointment Scheduling**
How do we coordinate schedules between patients and doctors across multiple departments while avoiding conflicts? Double-booking or lost appointments can have serious consequences for patient care.

### **3. Prescription Tracking**
How do we ensure that every medication prescribed during a consultation is properly documented and traceable? Patient safety depends on accurate medication records and preventing dangerous drug interactions.

### **4. Medical Records Management**
How do we maintain a comprehensive, searchable history of patient visits, diagnoses, and treatments over time? Doctors need instant access to a patient's complete medical history to make informed decisions.

### **Our Solution**

We address these challenges through a well-structured relational database that:
- **Eliminates data redundancy** through proper normalization
- **Ensures data integrity** through foreign key constraints and referential integrity
- **Enables fast, efficient queries** through proper indexing and table relationships
- **Scales easily** as the hospital grows and patient records accumulate

---

## 🗃️ Database Design

### Entity-Relationship Overview

Our database consists of **6 main entities** with carefully designed relationships:

#### 1. **PATIENTS**
Stores complete patient information including demographics, medical details, and emergency contacts.

**Key Attributes:**
- `patient_id` (Primary Key, AUTO_INCREMENT)
- `first_name`, `last_name`
- `date_of_birth`, `gender`
- `phone`, `email`, `address`
- `blood_group`, `allergies`
- `emergency_contact`
- `created_at` (timestamp)

**Purpose:** Central repository for all patient demographic and medical information.

#### 2. **DEPARTMENTS**
Organizes hospital services into logical units (Cardiology, Pediatrics, Neurology, etc.).

**Key Attributes:**
- `department_id` (Primary Key, AUTO_INCREMENT)
- `name` (UNIQUE constraint)
- `location`, `phone`
- `head_doctor_id` (Foreign Key to doctors)
- `created_at` (timestamp)

**Purpose:** Structural organization of hospital services and specialties.

#### 3. **DOCTORS**
Contains healthcare provider information and departmental assignments.

**Key Attributes:**
- `doctor_id` (Primary Key, AUTO_INCREMENT)
- `first_name`, `last_name`
- `specialization`
- `phone`, `email`
- `license_number` (UNIQUE constraint)
- `department_id` (Foreign Key to departments)
- `hire_date`
- `created_at` (timestamp)

**Purpose:** Management of medical staff and their specializations.

#### 4. **APPOINTMENTS**
Manages patient-doctor meetings and scheduling.

**Key Attributes:**
- `appointment_id` (Primary Key, AUTO_INCREMENT)
- `patient_id` (Foreign Key to patients)
- `doctor_id` (Foreign Key to doctors)
- `appointment_date`, `appointment_time`
- `status` (Scheduled/Completed/Cancelled)
- `reason`, `notes`
- `created_at` (timestamp)

**Purpose:** Coordination of patient-doctor consultations and scheduling.

#### 5. **PRESCRIPTIONS**
Tracks medications prescribed during consultations.

**Key Attributes:**
- `prescription_id` (Primary Key, AUTO_INCREMENT)
- `appointment_id` (Foreign Key to appointments)
- `medication_name`, `dosage`
- `frequency`, `duration`
- `instructions`

**Purpose:** Medication tracking and patient safety.

#### 6. **MEDICAL_RECORDS**
Maintains comprehensive patient visit history.

**Key Attributes:**
- `record_id` (Primary Key, AUTO_INCREMENT)
- `patient_id` (Foreign Key to patients)
- `doctor_id` (Foreign Key to doctors)
- `visit_date`
- `diagnosis`, `treatment`, `notes`
- `created_at` (timestamp)

**Purpose:** Long-term patient health history and audit trail.

---

### Relationships

| From Table | To Table | Relationship Type | Description |
|------------|----------|-------------------|-------------|
| Departments | Doctors | 1:M | One department has many doctors |
| Patients | Appointments | 1:M | One patient can have many appointments |
| Doctors | Appointments | 1:M | One doctor can have many appointments |
| Appointments | Prescriptions | 1:M | One appointment generates multiple prescriptions |
| Patients | Medical_Records | 1:M | One patient has many medical records over time |
| Doctors | Medical_Records | 1:M | One doctor creates many medical records |

**Key Relationship Features:**
- All foreign keys enforce **ON DELETE CASCADE** or **ON DELETE SET NULL** for data consistency
- **ON UPDATE CASCADE** ensures referential integrity when IDs are modified
- Composite indexes on frequently queried foreign key combinations for performance

---

### Normalization Process

#### **Before Normalization (Denormalized Table)**

Our initial design had a single large table:

```
┌──────────┬──────────────┬───────────┬─────────────┬──────────────┬───────────┬─────────────┬──────────┐
│ Appt_ID  │ Patient_Name │ Patient_  │ Doctor_Name │ Doctor_      │ Dept_Name │ Medication1 │ Dosage1  │
│          │              │ Phone     │             │ Specialization│           │             │          │
├──────────┼──────────────┼───────────┼─────────────┼──────────────┼───────────┼─────────────┼──────────┤
│ 1        │ Alice Kabore │ 70123456  │ Dr. X       │ Cardiology   │ Cardio    │ Aspirin     │ 100mg    │
│          │              │           │             │              │ Dept      │ Metoprolol  │ 50mg     │
└──────────┴──────────────┴───────────┴─────────────┴──────────────┴───────────┴─────────────┴──────────┘
```

#### **Problems Identified:**

**❌ First Normal Form (1NF) Violation:**
- Repeating columns (Medication1, Medication2, Dosage1, Dosage2...)
- Multi-valued cells (multiple medications in one field)
- What if a patient needs 5 medications? We'd need infinite columns!

**❌ Second Normal Form (2NF) Violation:**
- `Patient_Phone` depends only on `Patient_Name`, not on the full primary key (Appt_ID)
- `Doctor_Specialization` depends only on `Doctor_Name`, not on Appt_ID
- **Partial dependencies** on a composite key

**❌ Third Normal Form (3NF) Violation:**
- `Dept_Name` depends on `Doctor_Specialization`, which depends on `Doctor_Name`
- **Transitive dependency chain:** Appt_ID → Doctor_Name → Dept_Name
- Changing a department name requires updating multiple rows

**❌ Additional Problems:**
- **Massive data redundancy** - "Cardiology Dept" repeated for every cardiac appointment
- **Update anomalies** - Changing a patient's phone requires modifying multiple rows
- **Insertion anomalies** - Cannot add a new doctor without an appointment
- **Deletion anomalies** - Deleting a doctor's last appointment erases all their information

---

#### **After Normalization (Current Schema)**

**✅ Achieving First Normal Form (1NF):**
- Created separate `Prescriptions` table
- Each medication is now a distinct row
- No more repeating columns or multi-valued cells

**✅ Achieving Second Normal Form (2NF):**
- Separated `Patients`, `Doctors`, and `Departments` into their own tables
- Patient information now depends only on `patient_id`
- Doctor information now depends only on `doctor_id`
- Eliminated all partial dependencies

**✅ Achieving Third Normal Form (3NF):**
- Created `Departments` table to eliminate transitive dependencies
- Doctors now reference `department_id` instead of storing department name
- No attribute depends on another non-key attribute

**Benefits of Normalization:**
- ✅ **Zero redundancy** - Each fact stored exactly once
- ✅ **Easy updates** - Change department name in one place only
- ✅ **Data integrity** - Foreign keys prevent invalid references
- ✅ **Scalability** - Adding new entities is straightforward
- ✅ **Consistency** - No conflicting information possible

---

## 💻 Implementation

### Database Creation

```sql
CREATE DATABASE hospital_management;
USE hospital_management;
```

All table creation scripts with proper constraints, foreign keys, and data types are available in:
- **[`sql/01_create_tables.sql`](sql/01_create_tables.sql)**

This script includes:
- Complete table definitions
- PRIMARY KEY constraints
- FOREIGN KEY constraints with CASCADE rules
- UNIQUE constraints where appropriate
- DEFAULT values for status fields
- Indexes for performance optimization

---

### Sample Data

Our database is populated with realistic data including:

**Burkinabè Context:**
- Authentic names: Ouedraogo, Sawadogo, Kabore, Traore, Compaore, Zongo, etc.
- Local addresses: Ouaga 2000, Cissin, Gounghin, Dassasgho, Paspanga, Zone 4
- Realistic phone numbers with Burkina Faso format (+226)
- Common medical scenarios in West African context

**Data Volume:**
- 10 Departments (Cardiology, Pediatrics, Neurology, etc.)
- 10 Doctors with specializations
- 10 Patients with complete medical profiles
- 12 Appointments across various statuses
- 9 Prescriptions with detailed medication information
- 10 Medical Records with diagnoses and treatments

Data insertion scripts available in:
- **[`sql/02_insert_data.sql`](sql/02_insert_data.sql)**

---

### Key Design Decisions

#### **1. Foreign Key Constraints with CASCADE**
We implemented different CASCADE strategies based on business logic:

```sql
-- Appointments: Delete when patient is deleted
FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE

-- Doctors: Set NULL when department is deleted (doctor remains)
FOREIGN KEY (department_id) REFERENCES departments(department_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
```

**Rationale:** When a patient record is removed, their appointments should be automatically removed. However, if a department is deleted, doctors should remain in the system.

#### **2. Unique Constraints**
- Doctor `license_number` must be unique (regulatory requirement)
- Department `name` must be unique (organizational clarity)
- Patient `email` must be unique if provided (contact management)

#### **3. Default Values**
- Appointment `status` defaults to 'Scheduled'
- `created_at` timestamps auto-populate with `CURRENT_TIMESTAMP`
- Provides audit trail without manual intervention

#### **4. Data Type Selection**
- `VARCHAR` for variable-length strings (names, emails)
- `TEXT` for long content (medical notes, diagnoses, treatment plans)
- `DATE`/`TIME` for temporal data (precise appointment scheduling)
- `INT AUTO_INCREMENT` for primary keys (ensures uniqueness)

#### **5. Check Constraints**
```sql
CONSTRAINT chk_status CHECK (status IN ('Scheduled', 'Completed', 'Cancelled'))
```
Ensures data validity at database level.

---

## 🚀 Installation & Setup

### Prerequisites

- **MySQL 8.0 or higher**
- **MySQL Workbench** (optional, for GUI)
- **Git** (for cloning repository)

### Step 1: Clone the Repository

```bash
git clone https://github.com/[username]/hospital-management-system.git
cd hospital-management-system
```

### Step 2: Create the Database

**Option A - Using MySQL Command Line:**
```bash
mysql -u root -p < sql/01_create_tables.sql
```

**Option B - Using MySQL Workbench:**
1. Open MySQL Workbench
2. Connect to your local MySQL server
3. File → Open SQL Script → Select `sql/01_create_tables.sql`
4. Execute (⚡ icon or Ctrl+Shift+Enter)

### Step 3: Insert Sample Data

**Command Line:**
```bash
mysql -u root -p hospital_management < sql/02_insert_data.sql
```

**MySQL Workbench:**
1. File → Open SQL Script → Select `sql/02_insert_data.sql`
2. Execute

### Step 4: Verify Installation

```bash
mysql -u root -p
```

```sql
USE hospital_management;

-- Verify tables were created
SHOW TABLES;
-- Should display 6 tables

-- Verify data was inserted
SELECT COUNT(*) FROM patients;      -- Should return 10
SELECT COUNT(*) FROM doctors;       -- Should return 10
SELECT COUNT(*) FROM appointments;  -- Should return 12

-- Test a simple query
SELECT first_name, last_name, blood_group 
FROM patients 
LIMIT 5;
```

**✅ If all queries return expected results, installation is successful!**

---

## 📊 Sample Queries

### Basic Queries

```sql
-- View all patients
SELECT * FROM patients;

-- Find all cardiologists
SELECT first_name, last_name, specialization, phone
FROM doctors
WHERE specialization = 'Cardiologist';

-- Upcoming appointments
SELECT 
    patients.first_name AS patient,
    doctors.first_name AS doctor,
    appointments.appointment_date,
    appointments.appointment_time
FROM appointments
JOIN patients ON appointments.patient_id = patients.patient_id
JOIN doctors ON appointments.doctor_id = doctors.doctor_id
WHERE appointment_date >= CURDATE()
ORDER BY appointment_date, appointment_time;
```

### Intermediate Queries (JOINs)

```sql
-- Patient appointment history with doctor information
SELECT 
    patients.first_name AS Patient_FirstName,
    patients.last_name AS Patient_LastName,
    doctors.first_name AS Doctor_FirstName,
    doctors.last_name AS Doctor_LastName,
    doctors.specialization,
    appointments.appointment_date,
    appointments.status,
    appointments.reason
FROM appointments
JOIN patients ON appointments.patient_id = patients.patient_id
JOIN doctors ON appointments.doctor_id = doctors.doctor_id
WHERE patients.patient_id = 1
ORDER BY appointments.appointment_date DESC;
```

### Advanced Queries (Multi-table JOINs + Aggregates)

```sql
-- Comprehensive Doctor Performance Report (4-table JOIN)
-- This is our most complex query demonstrating everything learned
SELECT 
    doctors.first_name AS Doctor_FirstName,
    doctors.last_name AS Doctor_LastName,
    departments.name AS Department,
    doctors.specialization,
    COUNT(DISTINCT appointments.patient_id) AS Total_Patients_Treated,
    COUNT(DISTINCT appointments.appointment_id) AS Total_Appointments,
    COUNT(DISTINCT CASE 
        WHEN appointments.status = 'Completed' 
        THEN appointments.appointment_id 
    END) AS Completed_Appointments,
    COUNT(prescriptions.prescription_id) AS Total_Prescriptions_Written,
    ROUND(
        COUNT(prescriptions.prescription_id) / 
        NULLIF(COUNT(DISTINCT appointments.appointment_id), 0), 
        2
    ) AS Avg_Prescriptions_Per_Appointment
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
```

**What this query demonstrates:**
- ✅ Four-table JOIN (doctors, departments, appointments, prescriptions)
- ✅ COUNT DISTINCT to avoid counting duplicates
- ✅ CASE statement for conditional counting
- ✅ GROUP BY with multiple columns
- ✅ HAVING clause to filter aggregated results
- ✅ ORDER BY multiple columns for ranking
- ✅ NULLIF to prevent division by zero
- ✅ Real-world business intelligence reporting

**Use Case:** Hospital administration uses this for performance reviews, workload balancing, and resource allocation decisions.

---

### Aggregate Functions & Reporting

```sql
-- Patient demographics by blood group
SELECT 
    blood_group,
    COUNT(*) AS Patient_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patients), 2) AS Percentage
FROM patients
WHERE blood_group IS NOT NULL
GROUP BY blood_group
ORDER BY Patient_Count DESC;

-- Busiest days for appointments
SELECT 
    appointment_date,
    COUNT(*) AS Total_Appointments,
    COUNT(CASE WHEN status = 'Completed' THEN 1 END) AS Completed,
    COUNT(CASE WHEN status = 'Scheduled' THEN 1 END) AS Scheduled,
    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS Cancelled
FROM appointments
GROUP BY appointment_date
ORDER BY Total_Appointments DESC;

-- Most commonly prescribed medications
SELECT 
    medication_name,
    COUNT(*) AS Times_Prescribed,
    GROUP_CONCAT(DISTINCT dosage ORDER BY dosage) AS Common_Dosages
FROM prescriptions
GROUP BY medication_name
ORDER BY Times_Prescribed DESC;
```

**All queries with detailed comments are available in:**
- **[`sql/03_sample_queries.sql`](sql/03_sample_queries.sql)**

---

## Video Demonstration

**Duration:** 8-9 minutes  
**Platform:** YouTube (Unlisted)  
**Link:** [Insert your YouTube video link here after upload]

### What's Covered in the Video:

✅ **Database Design & Schema** - Explanation of all 6 tables and their relationships  
✅ **Normalization Process** - Before and after comparison showing 1NF, 2NF, 3NF  
✅ **Live MySQL Demonstrations:**
   - Database creation and table structure
   - Data insertion with realistic scenarios
   - Simple SELECT queries
   - Two-table and three-table JOINs
   - Complex four-table JOIN with full patient journey
   - LEFT JOIN vs INNER JOIN comparison
   - Referential integrity demonstrations

✅ **Aggregate Functions & Reporting:**
   - COUNT, AVG, MAX, MIN examples
   - GROUP BY with HAVING clause
   - Complex business intelligence query

✅ **All six team members participate** with clear explanations of each component

---

## Technologies Used

| Technology | Purpose | Version |
|------------|---------|---------|
| **MySQL** | Database Management System | 8.0+ |
| **dbdiagram.io** | ERD Schema Visualization | Web-based |
| **Git & GitHub** | Version Control & Collaboration | Latest |
| **MySQL Workbench** | Database GUI (optional) | 8.0+ |
| **Markdown** | Documentation | - |
| **PowerPoint** | Project Presentation | MS Office |
| **OBS Studio / Zoom** | Video Recording | Latest |

---

## Project Deliverables

### 1. GitHub Repository 
Complete project codebase including:
- ✅ All SQL scripts (create, insert, query)
- ✅ Comprehensive README documentation
- ✅ Database schema diagram
- ✅ Organized folder structure

**Repository Structure:**
```
hospital-management-system/
├── README.md                    # This file
├── presentation/
│   └── Hospital_Management_System_Presentation.pptx
├── sql/
│   ├── 01_create_tables.sql    # Database creation
│   ├── 02_insert_data.sql      # Sample data
│   └── 03_sample_queries.sql   # All demonstration queries
└── schema/
    └── hospital_schema_diagram.png
```

### 2. PowerPoint Presentation 
**9 professionally designed slides:**
1. Title slide with all team member names
2. Problem Statement & Objectives
3. Database Schema Diagram
4. Normalization - Before (denormalized table)
5. Normalization - After (normalized schema)
6. Key Design Decisions
7. Complex Query Example
8. Live Demo Highlights
9. Conclusion & Summary

**Download:** [`presentation/Hospital_Management_System_Presentation.pptx`](presentation/Hospital_Management_System_Presentation.pptx)

### 3. YouTube Video 
**8-9 minute comprehensive demonstration:**
- All team members presenting
- Live MySQL query execution
- Complete project walkthrough
- Professional audio and video quality

**Watch Here:** [https://youtu.be/6HPRcfrJF0M]

---

## Academic Integrity Statement

This project was completed entirely by our team with the following approach:

**What we created ourselves:**
- ✅ Complete database design and normalization
- ✅ All SQL scripts (tables, data, queries)
- ✅ Data modeling and relationship design
- ✅ Sample data creation with realistic scenarios
- ✅ Query development and testing
- ✅ Documentation and presentation

**Tools and resources we used for learning:**
- AI assistants (ChatGPT, Claude) for:
  - Learning SQL syntax and best practices
  - Understanding normalization concepts
  - Debugging query errors
  - Improving code structure
- Official MySQL documentation
- Course materials and lectures

**However, all code is original and fully understood by our team.** We can explain every line of SQL in our database, every design decision, and every query optimization, as demonstrated in our video presentation. The AI tools were used as learning aids, not as a replacement for our own understanding and work.

---

## 📞 Contact

### Project Team

**Group Leader:**  
Kader ZARANI  
Email: kader.zarani@bit.bf

**Technical Lead:**  
Zangafigue Mathias TRAORE  
Email: mathias.traore@bit.bf

### Course Information

**Instructor:** Kweyakie Afi Blebo  
**Email:** blebo.kweyakie@bit.bf  
**Course:** CS27 - The Relational Model & Databases  
**Institution:** Burkina Institute of Technology  
**Semester:** Spring 2026

---

## License

This project was created for educational purposes as part of the CS27 course at Burkina Institute of Technology. All rights reserved by the project team.

---

## 🙏 Acknowledgments

We would like to thank:

- **Professor Kweyakie Afi Blebo** for her guidance, patience, and comprehensive teaching throughout the semester
- **Burkina Institute of Technology** for providing the resources and environment for this project
- **Our classmates** for their feedback and support during development
- **Keya BASSINGA** (our seventh team member) - though unable to participate due to health reasons, we acknowledge his commitment to the team and wish him well

---

## Project Statistics

| Metric | Count |
|--------|-------|
| **Total Tables** | 6 |
| **Total Foreign Keys** | 6 |
| **Sample Patients** | 10 |
| **Sample Doctors** | 10 |
| **Sample Appointments** | 12 |
| **Sample Prescriptions** | 9 |
| **Sample Medical Records** | 10 |
| **Lines of SQL Code** | 500+ |
| **Documentation Pages** | 15+ |
| **Team Members (Active)** | 6 |
| **Video Duration** | 8-9 minutes |

---

**⭐ If you found this project helpful or educational, please star our repository!**

**Submitted:** March 2026  
**Course:** CS27 - The Relational Model & Databases  
**Institution:** Burkina Institute of Technology

---

*This README was collaboratively written by the team with contributions from all members.*
