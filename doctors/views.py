from django.shortcuts import render, redirect
from django.db import connection
from .models import Doctor
from .models import Department

def doctor_list(request):

    doctors = Doctor.objects.all().order_by('doctor_id')

    return render(
        request,
        'doctors/doctor_list.html',
        {
            'doctors': doctors
        }
    )


def add_doctor(request):

    departments = Department.objects.all()

    if request.method == "POST":

        with connection.cursor() as cursor:

            cursor.execute("""
                BEGIN
                    Add_Doctor(
                        :doctor_id,
                        :full_name,
                        :specialization,
                        :phone,
                        :email,
                        :consultation_fee,
                        :department_id
                    );
                END;
            """, {
                "doctor_id": int(request.POST['doctor_id']),
                "full_name": request.POST['full_name'],
                "specialization": request.POST['specialization'],
                "phone": request.POST['phone'],
                "email": request.POST['email'],
                "consultation_fee": int(request.POST['consultation_fee']),
                "department_id": int(request.POST['department_id'])
            })

        return redirect('/doctors/')

    return render(
        request,
        'doctors/add_doctor.html',
        {
            'departments': departments
        }
    )


def update_doctor(request, doctor_id):

    doctor = Doctor.objects.get(
        doctor_id=doctor_id
    )

    departments = Department.objects.all()

    if request.method == "POST":

        with connection.cursor() as cursor:

            cursor.execute("""
                BEGIN
                    Update_Doctor(
                        :doctor_id,
                        :full_name,
                        :specialization,
                        :phone,
                        :email,
                        :consultation_fee,
                        :department_id
                    );
                END;
            """, {
                "doctor_id": doctor.doctor_id,
                "full_name": request.POST['full_name'],
                "specialization": request.POST['specialization'],
                "phone": request.POST['phone'],
                "email": request.POST['email'],
                "consultation_fee": int(request.POST['consultation_fee']),
                "department_id": int(request.POST['department_id'])
            })

        return redirect('/doctors/')

    return render(
        request,
        'doctors/update_doctor.html',
        {
            'doctor': doctor,
            'departments': departments
        }
    )


def delete_doctor(request, doctor_id):

    Doctor.objects.filter(
        doctor_id=doctor_id
    ).delete()

    return redirect('/doctors/')