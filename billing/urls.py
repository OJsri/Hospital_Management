from django.urls import path
from .views import (
    billing_list,
    update_bill_status
)

urlpatterns = [
    path(
        'billing/',
        billing_list,
        name='billing_list'
    ),

    path(
        'update-bill-status/<int:bill_id>/<str:status>/',
        update_bill_status,
        name='update_bill_status'
    ),
]