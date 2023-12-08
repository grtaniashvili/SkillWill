from django.contrib import admin
from django.urls import path, include
from Car import views

urlpatterns = [
    path('', views.CarListView.as_view(), name='allcars'),
    path('addcar/', views.AddCarView.as_view(), name='addcar')
]
