from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse
from django.template import loader
from django.http import Http404
from .models import Task

def index(request):
    return HttpResponse("CS393 rocks!")

def all_tasks(request):
    all_tasks = Task.objects.order_by("-updatedAt")
    context = {"all_tasks": all_tasks}
    return render(request, "todo_app/task_list.html", context)

def task(request, task_id):
    try:
        task = Task.objects.get(pk=task_id)
        context = {"task": task}
    except Task.DoesNotExist:
        raise Http404("Task does not exist or is unauthorized.")
    return render(request, "todo_app/task.html", context)