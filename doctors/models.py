from django.db import models


class Department(models.Model):
    department_id = models.IntegerField(primary_key=True)
    department_name = models.CharField(max_length=100)
    department_head = models.CharField(max_length=100)
    contact_extension = models.CharField(max_length=20)

    class Meta:
        db_table = 'DEPARTMENT'

    def __str__(self):
        return self.department_name


class Doctor(models.Model):
    doctor_id = models.IntegerField(primary_key=True)
    full_name = models.CharField(max_length=100)
    specialization = models.CharField(max_length=100)
    phone = models.CharField(max_length=15)
    email = models.EmailField(unique=True)
    consultation_fee = models.DecimalField(max_digits=10, decimal_places=2)

    department = models.ForeignKey(
        Department,
        on_delete=models.CASCADE,
        db_column='department_id'
    )

    class Meta:
        db_table = 'DOCTOR'

    def __str__(self):
        return self.full_name