# Create your views here.
from django.http import HttpResponse
from django.shortcuts import render
from django.template import loader
from .models import Task
from django.http import Http404



def index(request):
    return render(request, "todo_app/main.html")


def all_tasks(request):
    tasks = Task.objects.order_by("dueDate")
    context = {"all_tasks": tasks}
    return render(request, "todo_app/task_list.html", context)


def task(request, task_id):
    try:
        task = Task.objects.get(pk=task_id)
        context = {"task": task}
    except Task.DoesNotExist:
        raise Http404("Task does not exist or is unauthorized.")
    return render(request, "todo_app/task.html", context)