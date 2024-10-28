from django.db import models
from django.contrib.auth import get_user_model

# Create your models here.

class Status(models.Model):
    statusId = models.AutoField(primary_key=True)
    statusName = models.CharField(max_length=50)
    statusColor = models.CharField(max_length=6)

class Task(models.Model):
    taskId = models.AutoField(primary_key=True, verbose_name="Task ID")
    title = models.CharField(max_length=255, null=False)
    description = models.TextField(null=True)
    status = models.ForeignKey(Status, on_delete=models.RESTRICT)
    dueDate = models.DateTimeField()
    createdAt = models.DateTimeField(auto_now_add=True)
    updatedAt = models.DateTimeField(auto_now=True)
