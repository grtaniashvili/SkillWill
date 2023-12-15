from django.urls import path
from users import views

urlpatterns = [
    path('user/', views.AllUser, name='home'),
    path('add_user/', views.AddUser, name='add_user'),
    path('updateuser/<int:pk>', views.update_user, name='update_user'),
    path('deleteuser/<int:pk>', views.delete_user, name='delete_user'),
    path('record/<int:pk>', views.record, name='record')
]
