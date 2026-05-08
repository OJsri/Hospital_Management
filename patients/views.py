from django.shortcuts import render, redirect
from django.db import connection
from .models import Patient


def patient_list(request):
    patients = Patient.objects.all()

    return render(
        request,
        'patients/patient_list.html',
        {
            'patients': patients
        }
    )


def add_patient(request):
    if request.method == 'POST':
        try:
            patient_id = int(request.POST['patient_id'])
            full_name = request.POST['full_name']
            gender = request.POST['gender']
            age = int(request.POST['age'])
            blood_group = request.POST['blood_group']
            phone = request.POST['phone']
            email = request.POST['email']
            address = request.POST['address']
            emergency_contact = request.POST['emergency_contact']

            with connection.cursor() as cursor:
                cursor.execute("""
                    BEGIN
                        Add_Patient(
                            :patient_id,
                            :full_name,
                            :gender,
                            :age,
                            :blood_group,
                            :phone,
                            :email,
                            :address,
                            :emergency_contact
                        );
                    END;
                """, {
                    "patient_id": patient_id,
                    "full_name": full_name,
                    "gender": gender,
                    "age": age,
                    "blood_group": blood_group,
                    "phone": phone,
                    "email": email,
                    "address": address,
                    "emergency_contact": emergency_contact
                })

            return redirect('/patients/')

        except Exception as e:
            return render(
                request,
                'patients/add_patient.html',
                {
                    'error': str(e)
                }
            )

    return render(
        request,
        'patients/add_patient.html'
    )


def update_patient(request, patient_id):
    patient = Patient.objects.get(patient_id=patient_id)

    if request.method == 'POST':
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    BEGIN
                        Update_Patient(
                            :patient_id,
                            :full_name,
                            :gender,
                            :age,
                            :blood_group,
                            :phone,
                            :email,
                            :address,
                            :emergency_contact
                        );
                    END;
                """, {
                    "patient_id": patient.patient_id,
                    "full_name": request.POST['full_name'],
                    "gender": request.POST['gender'],
                    "age": int(request.POST['age']),
                    "blood_group": request.POST['blood_group'],
                    "phone": request.POST['phone'],
                    "email": request.POST['email'],
                    "address": request.POST['address'],
                    "emergency_contact": request.POST['emergency_contact']
                })

            return redirect('/patients/')

        except Exception as e:
            return render(
                request,
                'patients/edit_patient.html',
                {
                    'patient': patient,
                    'error': str(e)
                }
            )

    return render(
        request,
        'patients/update_patient.html',
        {
            'patient': patient
        }
    )


def delete_patient(request, patient_id):
    try:
        patient = Patient.objects.get(
            patient_id=patient_id
        )

        patient.delete()

    except Exception as e:
        print(e)

    return redirect('/patients/')


