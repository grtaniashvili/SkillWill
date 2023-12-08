from django import forms
from .models import Users


# Create Add Record Form
class AddRecordForm(forms.ModelForm):
    pass

    class Meta:
        model = Users
        exclude = ("user",)
