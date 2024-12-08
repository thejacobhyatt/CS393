import pandas as pd
from forms_app.models import Location, Vehicle, Customer, Agent, Rental

# Import data for Locations
location_csv_path = 'forms_app/data/locations.csv'
location_df = pd.read_csv(location_csv_path)

for index, row in location_df.iterrows():
    location, created = Location.objects.get_or_create(
        name=row['name'],
        address=row['address'],  # Include in lookup to enforce uniqueness
        defaults={
            'contact_number': row['contact_number'],
        }
    )
    print(f"{'Created' if created else 'Found'} Location: {location.name}")


# Import data for Vehicles
vehicle_csv_path = 'forms_app/data/vehicles.csv'
vehicle_df = pd.read_csv(vehicle_csv_path)

for index, row in vehicle_df.iterrows():
    current_location = Location.objects.get(name=row['location'])  # Assuming location name is in the CSV
    vehicle, created = Vehicle.objects.get_or_create(
        vehicle_id=row['vehicle_id'],
        defaults={
            'make': row['make'],
            'model': row['model'],
            'year': row['year'],
            'rental_rate_per_day': row['rental_rate_per_day'],
            'current_location': current_location,
        }
    )
    print(f"Processed Vehicle: {vehicle}")

# Import data for Customers
customer_csv_path = 'forms_app/data/customers.csv'
customer_df = pd.read_csv(customer_csv_path)

for index, row in customer_df.iterrows():
    customer, created = Customer.objects.get_or_create(
        customer_id=row['customer_id'],
        defaults={
            'name': row['name'],
            'drivers_license_number': row['drivers_license_number'],
            'phone': row['phone'],
            'email': row['email'],
            'address': row['address'],
        }
    )
    print(f"Processed Customer: {customer.name}")

# Import data for Agents
agent_csv_path = 'forms_app/data/agents.csv'
agent_df = pd.read_csv(agent_csv_path)

for index, row in agent_df.iterrows():
    print(row['location'])

    location, created = Location.objects.get_or_create(name=row['location'])
    
    agent, created = Agent.objects.get_or_create(
        name=row['name'],
        defaults={
            'contact_info': row['contact_info'],
            'location': location,
        }
    )
    print(f"Processed Agent: {agent.name}")

# Import data for Rentals
rental_csv_path = 'forms_app/data/rentals.csv'
rental_df = pd.read_csv(rental_csv_path)

for index, row in rental_df.iterrows():
    vehicle = Vehicle.objects.get(vehicle_id=row['vehicle_id'])
    customer = Customer.objects.get(customer_id=row['customer_id'])
    departing_agent = Agent.objects.get(name=row['departing_agent'])
    returning_agent = Agent.objects.get(name=row['returning_agent'])
    pickup_location = Location.objects.get(name=row['pickup_location'])
    return_location = Location.objects.get(name=row['return_location'])

    rental, created = Rental.objects.get_or_create(
        vehicle=vehicle,
        customer=customer,
        departing_agent=departing_agent,
        returning_agent=returning_agent,
        pickup_location=pickup_location,
        return_location=return_location,
        start_date=row['start_date'],
        end_date=row['end_date'],
        total_cost=row['total_cost'],
    )
    print(f"Processed Rental: {rental}")

print("CSV data has been successfully loaded into the Django database.")
