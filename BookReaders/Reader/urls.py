from django.urls import path
from Reader import views, forms

urlpatterns = [
    path('', views.add_reader, name='add_reader')


]
