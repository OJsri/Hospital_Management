from django.urls import path
from .views import (
    dashboard,
    book_appointment,
    success_page,
    appointment_list,
    delete_appointment,
    update_appointment_status
)

urlpatterns = [
    path('', dashboard, name='dashboard'),

    path(
        'book-appointment/',
        book_appointment,
        name='book_appointment'
    ),

    path(
        'appointments/',
        appointment_list,
        name='appointment_list'
    ),

    path(
        'delete-appointment/<int:appointment_id>/',
        delete_appointment,
        name='delete_appointment'
    ),

    path(
        'success/',
        success_page,
        name='success_page'
    ),

    path(
        'update-appointment-status/<int:appointment_id>/<str:status>/',
        update_appointment_status,
        name='update_appointment_status'
    ),
]