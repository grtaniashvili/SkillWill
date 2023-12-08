from django.urls import path
from MyCalendarApp import views

urlpatterns = [
    path('', views.calendar)
]