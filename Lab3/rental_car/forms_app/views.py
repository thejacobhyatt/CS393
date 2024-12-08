from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Rental, Vehicle, Customer, Agent, Location

# Create your views here.
def index(request):
    return render(request, "forms_app/main.html")

def rentals(request):
    if request.method == 'POST':
        # Get the data from the form
        rental_data = {
            'vehicle_id': request.POST['vehicle'],
            'customer_id': request.POST['customer'],
            'departing_agent_id': request.POST['departing_agent'],
            'returning_agent_id': request.POST['returning_agent'],
            'pickup_location_id': request.POST['pickup_location'],
            'return_location_id': request.POST['return_location'],
            'start_date': request.POST['start_date'],
            'end_date': request.POST['end_date'],
            'total_cost': request.POST['total_cost'],
        }
        
        # Create a new rental record
        Rental.objects.create(**rental_data)
        return redirect('rentals')  # Redirect to prevent form resubmission

    # Fetch the required data for dropdown options
    vehicles = Vehicle.objects.all()
    customers = Customer.objects.all()
    agents = Agent.objects.all()
    locations = Location.objects.all()

    # Fetch existing rentals from the database
    rentals = Rental.objects.all()

    return render(request, 'forms_app/rentals.html', {
        'rentals': rentals,
        'vehicles': vehicles,
        'customers': customers,
        'agents': agents,
        'locations': locations,
    })

def vehicles(request):
    # Get the selected location name from the GET request (if any)
    selected_location_name = request.GET.get('location', '')

    # If a location is selected, get its ID and filter vehicles by it
    if selected_location_name:
        # Get the Location object based on the name
        selected_location = Location.objects.get(name=selected_location_name)
        # Filter vehicles by the location's ID
        vehicles = Vehicle.objects.filter(current_location=selected_location)
    else:
        # If no location is selected, show all vehicles
        vehicles = Vehicle.objects.all()

    # Get all unique location names to populate the dropdown
    locations = Location.objects.values_list('name', flat=True).distinct()

    context = {
        'vehicles': vehicles,
        'locations': locations,
    }
    return render(request, "forms_app/vehicles.html", context)

from django.shortcuts import render, get_object_or_404
from .models import Rental, Customer
from .forms import RentalForm  # Assuming you have a RentalForm

from django.shortcuts import render, get_object_or_404
from .models import Rental, Customer
from .forms import RentalForm  # Assuming you have a RentalForm

def edit_rentals(request):
    # Fetch all customers for the dropdown
    customers = Customer.objects.all()

    # Default to showing no customer and no rentals
    selected_customer = None
    rentals = Rental.objects.none()

    # Check if a customer is selected via GET request
    customer_filter = request.GET.get('customer', '')
    if customer_filter:
        selected_customer = get_object_or_404(Customer, customer_id=customer_filter)
        rentals = Rental.objects.filter(customer=selected_customer)

    # Handle the form submission for editing rentals
    if request.method == 'POST':
        # Iterate over each rental and check if the form is submitted for that rental
        for rental in rentals:
            # Retrieve the form data for this rental
            start_date = request.POST.get(f'start_date_{rental.id}')
            end_date = request.POST.get(f'end_date_{rental.id}')
            total_cost = request.POST.get(f'total_cost_{rental.id}')
            
            # Update rental object
            if start_date:
                rental.start_date = start_date
            if end_date:
                rental.end_date = end_date
            if total_cost:
                rental.total_cost = total_cost
            
            # Save the updated rental
            rental.save()

    # Render the page with rentals for the selected customer
    return render(request, 'forms_app/edit_rentals.html', {
        'customers': customers,
        'selected_customer': selected_customer,
        'rentals': rentals,
    })


from django.shortcuts import render
from .models import Rental

def view_rentals(request):
    customer_name = request.GET.get('customer_name', '')
    
    # Fetch all customers
    customers = Customer.objects.all()
    
    # Fetch all rentals
    rentals = Rental.objects.all()
    
    # If a customer is selected, filter rentals by the selected customer
    if customer_name:
        rentals = rentals.filter(customer__id=customer_name)  # Filter by customer ID
    
    return render(request, 'forms_app/view_rentals.html', {'rentals': rentals, 'customers': customers})
