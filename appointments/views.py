from django.shortcuts import render, redirect
from django.db import connection
from datetime import datetime
from patients.models import Patient
from doctors.models import Doctor
from billing.models import Bill
from appointments.models import Appointment


def book_appointment(request):
    patients = Patient.objects.all()
    doctors = Doctor.objects.all()

    if request.method == 'POST':
        try:
            appointment_id = int(request.POST['appointment_id'])
            patient_id = int(request.POST['patient_id'])
            doctor_id = int(request.POST['doctor_id'])

            appointment_date = datetime.strptime(
                request.POST['appointment_date'],
                "%Y-%m-%d"
            ).date()

            appointment_time = request.POST['appointment_time']

            with connection.cursor() as cursor:
                cursor.execute("""
                    BEGIN
                        Book_Appointment(
                            :patient_id,
                            :doctor_id,
                            :appointment_date,
                            :appointment_time,
                            :status
                        );
                    END;
                """, {
                    "patient_id": patient_id,
                    "doctor_id": doctor_id,
                    "appointment_date": appointment_date,
                    "appointment_time": appointment_time,
                    "status": "Pending"
                })

            # only if procedure succeeds
            return redirect('/success/')

        except Exception as e:
            error_message = str(e)

            if "Doctor already has an appointment" in error_message:
                error_message = "Doctor already has an appointment at this time."

            return render(request, 'appointments/book_appointment.html', {
                'patients': patients,
                'doctors': doctors,
                'error': error_message
            })

    return render(request, 'appointments/book_appointment.html', {
        'patients': patients,
        'doctors': doctors
    })


def success_page(request):
    return render(request, 'appointments/success.html')



def dashboard(request):
    total_patients = Patient.objects.count()
    total_doctors = Doctor.objects.count()
    total_appointments = Appointment.objects.count()
    total_revenue = sum(
        bill.total_amount for bill in Bill.objects.all()
    )

    pending_bills = Bill.objects.filter(
        payment_status='Pending'
    ).count()

    context = {
        'total_patients': total_patients,
        'total_doctors': total_doctors,
        'total_appointments': total_appointments,
        'total_revenue': total_revenue,
        'pending_bills': pending_bills,
    }

    return render(
        request,
        'appointments/dashboard.html',
        context
    )


def appointment_list(request):
    appointments = Appointment.objects.select_related(
        'patient',
        'doctor'
    ).order_by(
        'appointment_date',
        'appointment_time'
    )

    return render(
        request,
        'appointments/appointment_list.html',
        {
            'appointments': appointments
        }
    )



def delete_appointment(request, appointment_id):
    Appointment.objects.filter(
        appointment_id=appointment_id
    ).delete()

    return redirect('/appointments/')


def update_appointment_status(
    request,
    appointment_id,
    status
):
    with connection.cursor() as cursor:
        cursor.execute("""
            BEGIN
                Update_Appointment_Status(
                    :appointment_id,
                    :status
                );
            END;
        """, {
            "appointment_id": appointment_id,
            "status": status
        })

    return redirect('/appointments/')