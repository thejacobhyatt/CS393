from django.db import models

# Create your models here.
class HoursLogged(models.Model):
    numHours = models.IntegerField()