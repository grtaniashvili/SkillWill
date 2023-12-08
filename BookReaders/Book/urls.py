from django.urls import path
from Book import views

urlpatterns = [
    path('', views.all_book, name='home'),
    path('delete_book/<int:pk>', views.delete_book, name='delete_book'),
    path('add_book/', views.add_book, name='add_book'),
    path('update_book/<int:pk>', views.update_book, name='update_book'),
    path('record/<int:pk>', views.record, name='record')
]
