from django.db import models


class Animal(models.Model):
    name = models.CharField(max_length=40)
    age = models.IntegerField()
    weight = models.IntegerField()
    height = models.IntegerField()

    def __str__(self):
        return self.name
