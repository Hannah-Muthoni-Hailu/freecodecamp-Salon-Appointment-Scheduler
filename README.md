# freecodecamp-Salon-Appointment-Scheduler

This is a bash script that updates a database called salon by adding a new customer or creating a new appointment booking.
<br>
To start running the script, first, you need to set up the database by running the folling line in bash:
```
psql -U postgres < salon.sql
```

This creates the salon database with a few predefined entries.
<br>
<br>
To start the rest of the project, run the following code also in a bash terminal:
```
psql --username=freecodecamp --dbname=salon #to log into the database
./salon.sh # display the menu and book an appointment/register a new customer
```

<br>
<br>
This script displays both my skills in bash and PostgreSQL.
