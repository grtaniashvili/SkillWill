from django.db import models


class Users(models.Model):
    username = models.CharField(max_length=20)
    password = models.CharField(max_length=10, null=False, blank=False)
    first_name = models.CharField(max_length=20, null=False, blank=False)
    last_name = models.CharField(max_length=40, null=False, blank=False)
    email = models.EmailField()

    def __str__(self):
        return f'{self.first_name} - {self.last_name} - {self.email}'
