# create_groups.py

from django.contrib.auth.models import Group, User
from django.core.management.base import BaseCommand
from school_app.models import Course, Teacher, Student

class Command(BaseCommand):
    def handle(self, **options):
        groups = ['Students', 'Teachers']
        for group_name in groups:
            group, created = Group.objects.get_or_create(name=group_name)
        
        try:
            teacherUser = User.objects.get(username='teacher')
        except User.DoesNotExist:
            teacherUser = User.objects.create_user('teacher', 'teacher@example.com', 'teacherpassword')
            teacherUser.first_name = 'Shane'
            teacherUser.last_name = 'Reeves'
            teacherGroup = Group.objects.get(name='Teachers')
            teacherUser.groups.add(teacherGroup)
            teacherUser.save()

        try:
            teacher = Teacher.objects.get(first_name="Shane", last_name="Reeves")
        except Teacher.DoesNotExist:
            teacher = Teacher.objects.create(first_name="Shane", last_name="Reeves", department="EECS", user=teacherUser)
            teacher.save()

        try:
            studentUser = User.objects.get(username='student')
        except User.DoesNotExist:
            studentUser = User.objects.create_user('student', 'student@example.com', 'studentpassword')
            studentUser.first_name = 'Example'
            studentUser.last_name = 'Student'
            studentGroup = Group.objects.get(name='Students')
            studentUser.groups.add(studentGroup)
            studentUser.save()

        try:
            student = Student.objects.get(first_name="Example", last_name="Student")
        except Student.DoesNotExist:
            student = Student.objects.create(first_name="Example", last_name="Student", user=studentUser)
            student.save()

        try: 
            course = Course.objects.get(course_name='Web Security')
        except Course.DoesNotExist:
            course = Course(course_name='Web Security', teacher=teacher, credits=100)
            course.save()
            course.students.add(student)