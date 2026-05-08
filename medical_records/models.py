from django.db import models
from patients.models import Patient
from doctors.models import Doctor


class MedicalRecord(models.Model):

    record_id = models.IntegerField(primary_key=True)

    patient = models.ForeignKey(
        Patient,
        on_delete=models.CASCADE
    )

    doctor = models.ForeignKey(
        Doctor,
        on_delete=models.CASCADE
    )

    diagnosis = models.CharField(max_length=200)

    treatment = models.CharField(max_length=300)

    notes = models.CharField(max_length=500)

    record_date = models.DateField()

    class Meta:
        db_table = 'medical_record'

    def __str__(self):
        return str(self.record_id)