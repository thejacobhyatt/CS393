# 1. Table of Contents
- [1. Table of Contents](#1-table-of-contents)
- [2. Getting Started](#2-getting-started)
  - [2.1. Install Django](#21-install-django)
  - [2.2. Review Design](#22-review-design)
  - [2.3. Create Database](#23-create-database)
  - [2.4. Create django project](#24-create-django-project)
- [3. Build an app](#3-build-an-app)
  - [3.1. App URLs](#31-app-urls)
  - [3.2. Project URLs](#32-project-urls)
  - [3.3. Project Apps](#33-project-apps)
  - [3.4. Test](#34-test)
- [4. Configure Database connection](#4-configure-database-connection)
- [5. Create data model](#5-create-data-model)
  - [5.1. Check the migration](#51-check-the-migration)
  - [5.2. Run the migration](#52-run-the-migration)
- [6. Do some testing](#6-do-some-testing)
- [7. Create some views](#7-create-some-views)
  - [7.1. Update the task list to be better](#71-update-the-task-list-to-be-better)
  - [7.2. Update the task to be better](#72-update-the-task-to-be-better)
  - [7.3. Using relative URLs](#73-using-relative-urls)
    - [7.3.1. Update the task list](#731-update-the-task-list)
    - [7.3.2. Update the task page](#732-update-the-task-page)
- [8. Templating a Design](#8-templating-a-design)
  - [8.1. Serve static files](#81-serve-static-files)
  - [8.2. Create a main HTML file](#82-create-a-main-html-file)
  - [8.3. Use the main template in other templates](#83-use-the-main-template-in-other-templates)


# 2. Getting Started
## 2.1. Install Django
If you haven't already, make sure to [install Django](https://docs.djangoproject.com/en/5.1/topics/install/#installing-official-release)

## 2.2. Review Design
Below is our design for our app, a simple ToDo app.

![ToDo design diagram](todo_design.png "ToDo Design Diagram")

## 2.3. Create Database
1. Create the `todo` database (note that you don't need any tables yet, Django will do that for us).
    ```sql
    DROP DATABASE IF EXISTS todo;
    CREATE DATABASE todo;
    ```

1. Create a Django user
    ```sql
    CREATE USER IF NOT EXISTS 'django'@'localhost' IDENTIFIED BY 'mysecretpassword';
    ```

1. Give the Django user permissions to the database
    ```sql
    GRANT ALL PRIVILEGES ON todo.* TO 'django'@'localhost' WITH GRANT OPTION;
    ```

## 2.4. Create django project
1. Make sure your terminal is in the correct working directory where you want the app to be saved.
1. `django-admin startproject todo .` will create a todo "project" in the current directory
1. `python manage.py runserver` will start the web server.
1. Navigate to `127.0.0.1:8000`, you should see that Django is running successfully.

# 3. Build an app
A Django project can have many apps, and an app can be in many projects.  Let's build an app to place in our project.

1. `python manage.py startapp todo_app` this will create a new folder called todo_app in the todo project folder
1. Open the `todo_app/views.py` file and add the following code:

```python
from django.http import HttpResponse

def index(request):
    return HttpResponse("CS393 rocks!")
```

## 3.1. App URLs
Since we're trying to add a new URL to our app, we need to update the app's list of available URLs.

Create the file `todo_app/urls.py` with the following content:

```python
from django.urls import path
from . import views

urlpatterns = [
    path("", views.index, name="index"),
]
```

This says that for the todo_app app, we want the root of the path to call the index method in the views.py file; we give it a name of index.

## 3.2. Project URLs
Since we are also adding this app to this project, we need to update the project's URLs.

Go to `todo/urls.py` (NOT `todo_app/urls.py`) and update like below:

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('todo/', include("todo_app.urls")),
    path('admin/', admin.site.urls),
]
```

Here the `include()` function takes the todo_app/urls.py file and injects into into the current urls.py file.

## 3.3. Project Apps
Under `todo/settings.py`, add the following line to the `INSTALLED_APPS`:
`todo_app.apps.TodoAppConfig`

## 3.4. Test
Run your server and navigate to `http://localhost:8000/todo/`

# 4. Configure Database connection
1. Open todo/settings.py
1. Switch the databases config to the following:
    ```python
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'todo',
            'USER': 'django',
            'PASSWORD': 'mysecretpassword',
            'HOST': 'localhost',
        }
    }
    ```
1. Run `python manage.py migrate`
1. If successful, you should see a number of new tables under the todo database.

# 5. Create data model
Let's create the data model in Django as outlined by our design diagram.  In the `todo_app/models.py` file, create the following classes:

```python
from django.contrib.auth import get_user_model

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
```
Note:  we don't have a user yet, but that's ok.

## 5.1. Check the migration
1. Run this command:  `python manage.py makemigrations todo_app`, it should finish successfully
1. Run this command:  `python manage.py sqlmigrate todo_app 0001` where `0001` is the migration listed from the previous command.
1. Django outputs the SQL commands that it is running to make the new database schema match the current model from your code.

## 5.2. Run the migration
1. Run `python manage.py migrate`
1. Check the tables in the todo database.  You should see todo_app_status and todo_app_task.

# 6. Do some testing
1. Start a new interactive shell `python manage.py shell`
1. Try some of the following sets of commands:

    ```python
    >>> from todo_app.models import Task, Status
    >>> from datetime import datetime
    >>> s = Status(statusName="To Do", statusColor="FF0000")
    >>> s
    >>> s.save()
    >>> s
    >>> t = Task(title="Complete homework 2", status=s, dueDate=datetime(2024,10,30,7,0,0))
    >>> t
    >>> t.save()
    >>> t.status.statusName
    >>> t.description
    >>> t.title
    ```

1. Go back to MySQL and see if you have some new records.  Then try to create your own records!

# 7. Create some views
1. In `todo_app/views.py` add the following lines:

    ```python
    from .models import Task

    def all_tasks(request):
        tasks = Task.objects.order_by("-updatedAt")
        result = "<br />".join([f"{index + 1} - {task.title} : {task.description}" for index, task in enumerate(tasks)])
        print(result)
        return HttpResponse(result)

    def task(request, task_id):
        return HttpResponse(f"You're looking at task {task_id}")
    ```

1. Django also needs to know when to display that information.  So go to `todo_app/urls.py` and add the following two lines to the `urlpatterns`:

    ```python
    path("tasks/", views.all_tasks, name="all_tasks"),
    path("tasks/<int:task_id>/", views.task, name="task"),
    ```

1. Save both files and navigate to `http://127.0.0.1:8000/todo/tasks/`.  What do you see?

## 7.1. Update the task list to be better

Django uses the MVT pattern:  Model - View - Template.  We have a model and a view, but no template, currently.  Let's update our View to use a template.

1. Create the `todo_app/templates/todo_app/` folder.
2. Create a new file in the fodler called `task_list.html`
3. Add the following code to the new template:

    ```html
    {% if all_tasks %}
    <ol>
        {% for index, task in enumerate(all_tasks) %}
        <li>
            <a href="{{ task.taskId }}/">{{ task.title }} - {{ task.description|default:"No description" }}</a> : {{ task.dueDate }}
        </li>
        {% endfor %}
    </ol>
    {% else %}
        <p>No tasks present</p>
    {% endif %}
    ```

1. In the `todo_app/views.py` file, update the `all_tasks` view:

    ```python
    from django.template import loader

    def all_tasks(request):
        all_tasks = Task.objects.order_by("dueDate")
        context = {"all_tasks": all_tasks}
        return render(request, "todo_app/task_list.html", context)
    ```

1. Save and reload the page.  You should be able to navigate to the link on the page.

## 7.2. Update the task to be better

1. Create a new template called `task.html`
2. For now, just put `{{ task }}` as the content.
3. Update the `task` view:

    ```python
    from django.http import Http404

    def task(request, task_id):
        try:
            task = Task.objects.get(pk=task_id)
            context = {"task": task}
        except Task.DoesNotExist:
            raise Http404("Task does not exist or is unauthorized.")
        return render(request, "todo_app/task.html", context)
    ```

4. Save and reload the page.  Try navigating to the new task that you linked.  What about a task id that doesn't exist?
5. Update the Task template to make it look good!

## 7.3. Using relative URLs
Having to hard-code URLs is a bad design.  Remember when we provided a name in our `urls.py` file?  Let's use that for our URLs.

### 7.3.1. Update the task list

1. Go back to the `templates/todo_app/task_list.html` page.
2. Edit the href to show `href="{% url 'task' task.taskId %}"`
3. Note here that the `'task'` is a reference to the `name` attribute in `urls.py`.

### 7.3.2. Update the task page
From a task detail, let's add a link to go back to our task_list page.
1. Go to the `templates/todo_app/task.html` page.
2. Add a line break under task using the `<br />` tag.
3. Add a link tag that takes you back to the task_list using the name provided in `urls.py`.

# 8. Templating a Design
Our webpage kind of looks ugly, and we want to provide a better user experience cross our app without having to reinvent the wheel every time.  Let's make a consistent user experience.

## 8.1. Serve static files
Let's add a stylesheet, which is considered a static file (it doesn't change with the content).  You can learn more about [static files in Django](https://docs.djangoproject.com/en/5.1/howto/static-files/).

1. Create a `todo_app/static/todo_app` folder. (You will need to create two new folders, one inside the other, like we did with the templates.)
2. Create a `styles.css` file inside the new folder.
3. Copy/paste the following styles into the new file:

    ```css
    /* Importing a modern font */
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap');

    /* Body styling with dark gray background and modern font */
    body {
        font-family: 'Roboto', sans-serif;
        margin: 0;
        padding: 0;
        display: grid;
        grid-template-columns: 200px 1fr;
        grid-template-rows: 60px 1fr 40px;
        grid-template-areas: 
            "navbar navbar"
            "sidebar content"
            "footer footer";
        height: 100vh;
        background-color: #2c2c2c; /* Dark gray background */
        color: #f5f5f5; /* Light text color */
    }

    /* Navigation bar styling */
    nav {
        grid-area: navbar;
        background-color: #444;
        color: white;
        padding: 15px;
        text-align: center;
    }
    nav a {
        color: white;
        text-decoration: none;
        margin: 0 15px;
        font-weight: 500;
    }
    nav a:hover {
        text-decoration: underline;
    }

    /* Sidebar styling */
    aside {
        grid-area: sidebar;
        background-color: #3a3a3a;
        padding: 15px;
    }
    aside ul {
        list-style-type: none;
        padding: 0;
    }
    aside ul li {
        margin: 10px 0;
    }
    aside ul li a {
        color: #f5f5f5;
        text-decoration: none;
    }
    aside ul li a:hover {
        text-decoration: underline;
    }

    /* Content area styling */
    main {
        grid-area: content;
        padding: 20px;
    }

    /* Footer styling */
    footer {
        grid-area: footer;
        background-color: #444;
        color: white;
        text-align: center;
        padding: 10px 0;
    }
    ```

4. Add the following lines to the very top of `task_list.html` (we will remove it in a second):

    ```html
    {% load static %}
    <head>
        <link rel="stylesheet" type="text/css" href="{% static 'todo_app/styles.css' %}" />
    </head>
    ```

5. Restart your web server and open http://127.0.0.1:8000/todo/tasks/ .  The background color and font style should change!
6. Now go back and remove the chagnes we made to `task_list.html` (it'll make sense in a second).

## 8.2. Create a main HTML file
Django uses "blocks" within templates to allow us to override the content of one template within another template.  This allows us to "nest" templates inside each other.

1. Create a new file in the `templates/todo_app` folder called `main.html`
2. Copy/paste the following HTML:

    ```html
    {% load static %}

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Basic Layout</title>
        <link rel="stylesheet" type="text/css" href="{% static 'todo_app/styles.css' %}" />
    </head>
    <body>
        <!-- Navigation Bar -->
        <nav>
            <a href="/">Home</a>
            <a href="{% url 'all_tasks' %}">Task List</a>
        </nav>

        <!-- Sidebar -->
        <aside>
            {% block sidebar %}
            <ul>
                Here's a sidebar
            </ul>
            {% endblock %}
        </aside>

        <!-- Main Content Area -->
        <main>
            {% block content %}
            <h1>Welcome to my ToDo App</h1>
            <p>I'm a student learning how to make my own web pages!  Please be kind.</p>
            {% endblock %}
        </main>

        <!-- Footer -->
        <footer>
            <p>Footer Information &copy; 2024</p>
        </footer>
    </body>
    </html>
    ```

1. Update the `views.py` `index` method to use the new `main.html` template:

    ```python
    def index(request):
        return render(request, "todo_app/main.html)
    ```

1. Navigate to http://127.0.0.1:8000/todo/
2. Click the link to the task list, notice how jarring the change is!

## 8.3. Use the main template in other templates

1. Update the `task_list.html` template with the following code

    ```html
    {% extends "todo_app/main.html" %}

    {% block content %}

        ... the rest of the code here ...

    {% endblock %}

1. Restart the web server and try navigating around!
1. How would you do the same thing for the task view?