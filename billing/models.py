from django.db import models
from appointments.models import Appointment


class Bill(models.Model):
    bill_id = models.IntegerField(primary_key=True)

    appointment = models.OneToOneField(
        Appointment,
        on_delete=models.CASCADE,
        db_column='appointment_id'
    )

    consultation_fee = models.DecimalField(max_digits=10, decimal_places=2)
    medicine_charges = models.DecimalField(max_digits=10, decimal_places=2)
    lab_charges = models.DecimalField(max_digits=10, decimal_places=2)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_status = models.CharField(max_length=20)

    class Meta:
        db_table = 'BILL'

    def __str__(self):
        return f"Bill #{self.bill_id}"