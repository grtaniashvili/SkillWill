# Generated by Django 4.2.7 on 2023-12-01 19:35

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('MyCalendarApp', '0006_alter_calendar_date'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Calendar',
        ),
    ]
