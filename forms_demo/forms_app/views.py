from django.shortcuts import render
from django.http import HttpResponse
from .forms import Hours
from .models import HoursLogged

# Create your views here.
def index(request):
    return HttpResponse('hello')

def hours(request):
    print(request)
    print(dir(request))
    if request.method == "POST":
        print(request.POST)
        submittedForm = Hours(request.POST)
        if submittedForm.is_valid():
            newEntry = HoursLogged(
                numHours = submittedForm.cleaned_data['hours_walked']
            )
            newEntry.save()

    newForm = Hours()
    context = { 'form': newForm }
    return render(request, 'forms_app/hours.html', context)