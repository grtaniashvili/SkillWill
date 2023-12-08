from django.shortcuts import render, redirect
from Book.models import Books
from .forms import Add_Book_form
from django.http import HttpResponse


def add_book(request):
    if request.method == "POST":
        form = Add_Book_form(request.POST)
        if form.is_valid():
            form.save()
            return redirect('home')
    else:
        form = Add_Book_form()

    return render(request, 'add_books.html', {'form': form})


def delete_book(request, pk):
    delete_it = Books.objects.get(id=pk)
    delete_it.delete()
    return redirect('home')


def update_book(request, pk):
    current_record = Books.objects.get(id=pk)
    form = Add_Book_form(request.POST or None, instance=current_record)
    if form.is_valid():
        form.save()
        return redirect('home')
    return render(request, 'update_books.html', {'form': form})


def record(request, pk):
    book_record = Books.objects.get(id=pk)
    return render(request, 'record.html', {'customer_record': book_record})


def all_book(request):
    books = Books.objects.all()
    return render(request, 'home.html', {'books': books})
