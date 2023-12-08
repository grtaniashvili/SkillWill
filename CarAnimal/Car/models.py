from django.db import models


class Car(models.Model):
    name = models.CharField(max_length=30)
    model = models.CharField(max_length=20)
    price = models.DecimalField(max_digits=5, decimal_places=2)
    year = models.IntegerField()
    color = models.CharField(max_length=10)

    def __str__(self):
        return f'{self.name} costs {self.price} $'
