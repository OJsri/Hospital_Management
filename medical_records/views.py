from django.shortcuts import render, redirect
from django.db import connection

from .models import MedicalRecord
from patients.models import Patient
from doctors.models import Doctor


def medical_record_list(request):

    records = MedicalRecord.objects.select_related(
        'patient',
        'doctor'
    ).order_by('-record_date')

    return render(
        request,
        'medical_records/medical_record_list.html',
        {
            'records': records
        }
    )


def add_medical_record(request):

    patients = Patient.objects.all()
    doctors = Doctor.objects.all()

    if request.method == "POST":

        with connection.cursor() as cursor:

            cursor.execute("""
                BEGIN
                    Add_Medical_Record(
                        :record_id,
                        :patient_id,
                        :doctor_id,
                        :diagnosis,
                        :treatment,
                        :notes,
                        :record_date
                    );
                END;
            """, {

                "record_id": int(request.POST['record_id']),
                "patient_id": int(request.POST['patient_id']),
                "doctor_id": int(request.POST['doctor_id']),
                "diagnosis": request.POST['diagnosis'],
                "treatment": request.POST['treatment'],
                "notes": request.POST['notes'],
                "record_date": request.POST['record_date']

            })

        return redirect('/medical-records/')

    return render(
        request,
        'medical_records/add_medical_record.html',
        {
            'patients': patients,
            'doctors': doctors
        }
    )


def delete_medical_record(request, record_id):

    MedicalRecord.objects.filter(
        record_id=record_id
    ).delete()

    return redirect('/medical-records/')