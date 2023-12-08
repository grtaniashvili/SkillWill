from django import forms
from .models import Books  # Import your Books model


class Add_Book_form(forms.ModelForm):
    class Meta:
        model = Books
        fields = ['Book_name', 'Book_author']
