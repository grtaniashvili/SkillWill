from datetime import datetime

from django.db import models


class Users(models.Model):
    First_Name = models.CharField(max_length=20, null=False, blank=False)
    Last_Name = models.CharField(max_length=50, null=False, blank=False)
    Birth_Date = models.DateField(null=False, blank=False)

    def calc_age(self):
        return datetime.now().year - self.Birth_Date.year

    def __str__(self):
        return f'''First Name: {self.First_Name}
                   Last Name: {self.Last_Name}
                   Age: {self.calc_age()}
                '''


#Users.objects.create(First_Name="Grigol", Last_Name="Taniashvili", Birth_Date='1993-09-07')
