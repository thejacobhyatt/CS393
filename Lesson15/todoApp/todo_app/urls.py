from django.urls import path
from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("tasks/", views.all_tasks, name="all tasks"),
    path("tasks/<int:task_id>/", views.task, name="task"),
]