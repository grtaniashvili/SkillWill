from django.shortcuts import render, redirect
from requests import post

from Reader.forms import Sing_Up_form


def add_reader(request):
    form = Sing_Up_form(request.POST)
    return render(request, 'add_reader.html', {'form': form})
