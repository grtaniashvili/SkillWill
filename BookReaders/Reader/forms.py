from django import forms


class Sing_Up_form(forms.Form):
    First_Name = forms.CharField(label="First Name", max_length=20, required=True)
    Last_Name = forms.CharField(label="Last Name", max_length=100, required=True)

