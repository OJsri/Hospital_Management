from django.db import models


class Patient(models.Model):
    patient_id = models.IntegerField(primary_key=True)
    full_name = models.CharField(max_length=100)
    gender = models.CharField(max_length=10)
    age = models.IntegerField()
    blood_group = models.CharField(max_length=5)
    phone = models.CharField(max_length=15)
    email = models.EmailField(unique=True)
    address = models.CharField(max_length=200)
    emergency_contact = models.CharField(max_length=15)
    registration_date = models.DateField()

    class Meta:
        db_table = 'PATIENT'

    def __str__(self):
        return self.full_name