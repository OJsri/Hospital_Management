from django.urls import path

from .views import (
    doctor_list,
    add_doctor,
    update_doctor,
    delete_doctor
)

urlpatterns = [

    path(
        'doctors/',
        doctor_list,
        name='doctor_list'
    ),

    path(
        'add-doctor/',
        add_doctor,
        name='add_doctor'
    ),

    path(
        'update-doctor/<int:doctor_id>/',
        update_doctor,
        name='update_doctor'
    ),

    path(
        'delete-doctor/<int:doctor_id>/',
        delete_doctor,
        name='delete_doctor'
    ),

]