from django.db import models


class Books(models.Model):
    Book_name = models.CharField(max_length=100, blank=False, null=False)
    Book_author = models.CharField(max_length=100, blank=False, null=False)
