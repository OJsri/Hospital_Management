from django.db import models
from patients.models import Patient
from doctors.models import Doctor


class Appointment(models.Model):
    appointment_id = models.IntegerField(primary_key=True)

    patient = models.ForeignKey(
        Patient,
        on_delete=models.CASCADE,
        db_column='patient_id'
    )

    doctor = models.ForeignKey(
        Doctor,
        on_delete=models.CASCADE,
        db_column='doctor_id'
    )

    appointment_date = models.DateField()
    appointment_time = models.CharField(max_length=20)
    appointment_status = models.CharField(max_length=20)

    class Meta:
        db_table = 'APPOINTMENT'

    def __str__(self):
        return f"{self.patient.full_name} - {self.doctor.full_name}"