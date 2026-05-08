<div align="center">

# 🏥 Smart Hospital Management System

**A full-stack Hospital Management System built with Django + Oracle Database**  
featuring PL/SQL automation, trigger-based workflows, and a modern admin dashboard.

[![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![Django](https://img.shields.io/badge/Django-Backend-092E20?style=for-the-badge&logo=django&logoColor=white)](https://djangoproject.com)
[![Oracle](https://img.shields.io/badge/Oracle-21c_XE-F80000?style=for-the-badge&logo=oracle&logoColor=white)](https://oracle.com)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-Frontend-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com)

</div>

---

## 📖 Overview

The **Smart Hospital Management System** is a comprehensive healthcare platform that streamlines the management of patients, doctors, appointments, billing, and medical records. Built on **Django** with an **Oracle 21c XE** backend, the system leverages advanced SQL and PL/SQL features — including stored procedures, triggers, and sequences — to automate critical hospital workflows with reliability and efficiency.

---

## ✨ Features

### 👥 Patient Management
- Add, update, and delete patient records
- View complete patient history
- Cascading delete support for relational integrity

### 👨‍⚕️ Doctor Management
- Add and manage doctor profiles
- Department-wise organization
- Consultation fee tracking

### 📅 Appointment Management
- Book appointments with automatic ID generation
- **Double-booking prevention** via DB-level trigger
- Full appointment status workflow:

  | Status | Description |
  |--------|-------------|
  | `Pending` | Appointment requested |
  | `Confirmed` | Approved by staff |
  | `Completed` | Visit concluded |
  | `Cancelled` | Appointment cancelled |

### 💰 Billing Management
- Automatic bill generation on appointment completion
- Payment status tracking (Paid / Pending)
- Revenue dashboard with pending bills monitoring

### 📋 Medical Records
- Store diagnosis and treatment details
- Patient–Doctor relationship tracking
- Full record history management

---

## 🧠 Advanced DBMS Concepts

### SQL
- `CREATE TABLE`, `INSERT`, `UPDATE`, `DELETE`, `SELECT`
- `JOIN`s, Views, Aggregate Queries
- Foreign Keys with Cascading Deletes

### PL/SQL Stored Procedures

| Procedure | Purpose |
|-----------|---------|
| `Book_Appointment` | Validates and books an appointment |
| `Add_Patient` / `Update_Patient` | Patient CRUD operations |
| `Add_Doctor` / `Update_Doctor` | Doctor CRUD operations |
| `Update_Appointment_Status` | Manages appointment lifecycle |
| `Update_Bill_Status` | Marks bills as paid |
| `Add_Medical_Record` | Attaches records to appointments |

### Triggers

| Trigger | Purpose |
|---------|---------|
| `Prevent_Double_Booking` | Blocks scheduling conflicts for the same doctor at the same time |
| `Generate_Bill_On_Completion` | Auto-generates a bill when an appointment is marked **Completed** |

### Sequences

| Sequence | Used For |
|----------|----------|
| `appointment_seq` | Auto-incrementing appointment IDs |
| `bill_seq` | Auto-incrementing bill IDs |

---

## 🏗️ System Architecture

```
┌──────────────────────────────────┐
│     Frontend (HTML/CSS/Bootstrap) │
└────────────────┬─────────────────┘
                 │
┌────────────────▼─────────────────┐
│          Django Backend           │
└────────────────┬─────────────────┘
                 │
┌────────────────▼─────────────────┐
│     Oracle 21c XE Database        │
│   (SQL + PL/SQL + Triggers)       │
└──────────────────────────────────┘
```

---

## 📊 Admin Dashboard

The dashboard provides a real-time overview of hospital operations:

- 🧑‍🤝‍🧑 **Total Patients**
- 👨‍⚕️ **Total Doctors**
- 📅 **Total Appointments**
- 💵 **Total Revenue**
- 🔔 **Pending Bills**

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Backend | Django |
| Database | Oracle 21c XE |
| Backend Language | Python |
| DB Language | SQL / PL/SQL |
| Frontend | HTML, CSS, Bootstrap |
| IDE | Oracle SQL Developer |

---

## 📂 Project Structure

```
Hospital_Management/
│
├── appointments/        # Appointment booking & status management
├── patients/            # Patient CRUD operations
├── doctors/             # Doctor CRUD & department management
├── billing/             # Bill generation & payment tracking
├── medical_records/     # Diagnosis & treatment records
├── templates/           # HTML templates
├── static/              # CSS, JS, and static assets
└── manage.py
```

---

## ⚙️ Setup & Installation

### 1. Clone the Repository

```bash
git clone https://github.com/OJsri/Hospital_Management.git
cd Hospital_Management
```

### 2. Create and Activate Virtual Environment

```bash
python -m venv venv

# Windows
venv\Scripts\activate

# macOS / Linux
source venv/bin/activate
```

### 3. Install Dependencies

```bash
pip install django
pip install oracledb
```

### 4. Configure the Oracle Database

Update `settings.py` with your Oracle credentials:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.oracle',
        'NAME': 'xe',
        'USER': 'system',
        'PASSWORD': 'your_password',
        'HOST': 'localhost',
        'PORT': '1521',
    }
}
```

> ⚠️ Make sure Oracle 21c XE is running and the required schemas, procedures, triggers, and sequences have been created using the provided SQL scripts.

### 5. Run the Development Server

```bash
python manage.py runserver
```

Visit `http://127.0.0.1:8000` in your browser.

---

## 📚 Academic Concepts Covered

- Relational Database Design
- Entity–Relationship (ER) Modeling
- Functional Dependencies & Normalization
- Referential Integrity
- Transaction Management
- Trigger Automation
- PL/SQL Programming

---

## 🔮 Future Enhancements

- [ ] Prescription Module
- [ ] User Authentication & Role-Based Access Control
- [ ] Online Payment Integration
- [ ] AI-Based Appointment Scheduling
- [ ] Advanced Analytics Dashboard
- [ ] Mobile Application

---

## 🤝 Contributing

Contributions are welcome! Feel free to fork this repository, open issues, or submit pull requests.

1. Fork the project
2. Create your feature branch: `git checkout -b feature/YourFeature`
3. Commit your changes: `git commit -m 'Add YourFeature'`
4. Push to the branch: `git push origin feature/YourFeature`
5. Open a Pull Request

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

<div align="center">
  Made with ❤️ for learning and healthcare automation
</div>
