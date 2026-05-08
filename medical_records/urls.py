from django.urls import path

from .views import (
    medical_record_list,
    add_medical_record,
    delete_medical_record
)

urlpatterns = [

    path(
        'medical-records/',
        medical_record_list,
        name='medical_record_list'
    ),

    path(
        'add-medical-record/',
        add_medical_record,
        name='add_medical_record'
    ),

    path(
        'delete-medical-record/<int:record_id>/',
        delete_medical_record,
        name='delete_medical_record'
    ),

]