from django.contrib import admin
from django.urls import path, include
from Animal import views

urlpatterns = [
    path('', views.AnimalListView.as_view(), name='allanimal'),
    path('addanimal/', views.AddAnimalView.as_view(), name='addanimal'),
    path('deleteanimal/<int:pk>', views.DeleteAnimalView.as_view(), name='deleteanimal'),
    path('updateanimal/<int:pk>', views.UpdateAnimalView.as_view(), name='updateanimal')
]
