from django.urls import path
from .views import (
    patient_list,
    add_patient,
    update_patient,
    delete_patient
)

urlpatterns = [
    path('patients/', patient_list, name='patient_list'),
    path('add-patient/', add_patient, name='add_patient'),
    path('update-patient/<int:patient_id>/', update_patient, name='update_patient'),
    path('delete-patient/<int:patient_id>/', delete_patient, name='delete_patient'),
]