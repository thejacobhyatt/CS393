from django import forms
from .models import Rental

class RentalForm(forms.ModelForm):
    class Meta:
        model = Rental
        fields = ['start_date', 'end_date', 'total_cost', 'pickup_location', 'return_location']