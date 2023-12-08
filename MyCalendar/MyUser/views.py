from django.http import HttpResponse
from django.shortcuts import render, redirect
from MyUser.models import Users
from .forms import AddRecordForm


def user(request):
    alluser = Users.objects.all()
    return render(request, 'home.html', {'Users': alluser})


def customer_record(request, pk):
    customer_record = Users.objects.get(id=pk)
    return render(request, 'record.html', {'customer_record': customer_record})


def delete_record(request, pk):
    delete_it = Users.objects.get(id=pk)
    delete_it.delete()
    return redirect('home')


def add_record(request):
    form = AddRecordForm(request.POST or None)
    if request.method == "POST":
        if form.is_valid():
            form.save()
            return redirect('home')
    return render(request, 'add_record.html', {'form': form})


def update_record(request, pk):
    current_record = Users.objects.get(id=pk)
    form = AddRecordForm(request.POST or None, instance=current_record)
    if form.is_valid():
        form.save()
        return redirect('home')
    return render(request, 'update_record.html', {'form': form})
