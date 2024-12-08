from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('rentals/', views.rentals, name='rentals'),
    path('vehicles/', views.vehicles, name='vehicles'),
    path('edit_rentals/', views.edit_rentals, name='edit_rentals'),
    path('view_rentals/', views.view_rentals, name='view_rentals'),
]
