from django.shortcuts import render, redirect
from django.db import connection
from .models import Bill


def billing_list(request):
    bills = Bill.objects.all().order_by('-bill_id')

    return render(
        request,
        'billing/billing_list.html',
        {
            'bills': bills
        }
    )


def update_bill_status(
    request,
    bill_id,
    status
):
    with connection.cursor() as cursor:
        cursor.execute("""
            BEGIN
                Update_Bill_Status(
                    :bill_id,
                    :status
                );
            END;
        """, {
            "bill_id": bill_id,
            "status": status
        })

    return redirect('/billing/')