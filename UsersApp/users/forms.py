from django import forms
from . models import Users


class RegistrationForm(forms.ModelForm):
    class meta:
        model = Users
        fields = ('username', 'password', 'email', 'first_name', 'last_name')
