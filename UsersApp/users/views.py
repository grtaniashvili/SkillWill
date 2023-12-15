from django.shortcuts import render, redirect
from .forms import RegistrationForm
from users.models import Users


def AllUser(request):
    users = Users.objects.all()
    return render(request, 'home.html', {'users': users})


def AddUser(request):
    form = RegistrationForm()
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('home')
    else:
        form = RegistrationForm()
    return render(request, 'registration.html', {'form': form})


def delete_user(request, pk):
    delete_it = Users.objects.get(id=pk)
    delete_it.delete()
    return redirect('home')


def update_user(request, pk):
    current_record = Users.objects.get(id=pk)
    form = RegistrationForm(request.POST or None, instance=current_record)
    if form.is_valid():
        form.save()
        return redirect('home')
    return render(request, 'updateuser.html', {'form': form})


def record(request, pk):
    book_record = Users.objects.get(id=pk)
    return render(request, 'user.html', {'customer_record': book_record})
