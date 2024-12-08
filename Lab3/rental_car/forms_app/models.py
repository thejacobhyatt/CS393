from django.db import models

class Location(models.Model):
    name = models.CharField(max_length=100, unique=True)
    address = models.CharField(max_length=500)
    contact_number = models.CharField(max_length=15)

    def __str__(self):
        return self.name

class Vehicle(models.Model):
    make = models.CharField(max_length=50)
    model = models.CharField(max_length=50)
    year = models.IntegerField()
    vehicle_id = models.CharField(max_length=15, unique=True)
    rental_rate_per_day = models.DecimalField(max_digits=10, decimal_places=2)
    current_location = models.ForeignKey(Location, on_delete=models.SET_NULL, null=True, related_name='vehicles')

    def __str__(self):
        return f"{self.make} {self.model} ({self.year})"

class Customer(models.Model):
    customer_id = models.CharField(max_length=20, unique=True)
    name = models.CharField(max_length=100)
    drivers_license_number = models.CharField(max_length=20)
    phone = models.CharField(max_length=15)
    email = models.EmailField()
    address = models.CharField(max_length=500)

    def __str__(self):
        return self.name

class Agent(models.Model):
    name = models.CharField(max_length=100, unique=True)
    contact_info = models.CharField(max_length=200)
    location = models.ForeignKey(Location, on_delete=models.CASCADE, related_name='agents')

    def __str__(self):
        return self.name

class Rental(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)

    departing_agent = models.ForeignKey(Agent, on_delete=models.CASCADE, null=True, related_name='departing_rentals')
    returning_agent = models.ForeignKey(Agent, on_delete=models.CASCADE, null=True, related_name='returning_rentals')
    pickup_location = models.ForeignKey(Location, on_delete=models.SET_NULL, null=True, related_name='pickups')
    return_location = models.ForeignKey(Location, on_delete=models.SET_NULL, null=True, related_name='returns')
    start_date = models.DateField()
    end_date = models.DateField()
    total_cost = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"Rental of {self.vehicle} by {self.customer}"