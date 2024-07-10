#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~\n"

MAIN_MENU(){
  echo "How may I help you?"
  LIST_SERVICES=$($PSQL "SELECT * FROM services")
  echo "$LIST_SERVICES" | while read SERVICE_ID BAR SERVICE
  do
    ID=$(echo $SERVICE_ID | sed 's/ //g')
    NAME=$(echo $SERVICE | sed 's/ //g')
    echo "$ID) $SERVICE"
  done
  read SERVICE_ID_SELECTED

  SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  if [[ -z $SERVICE_ID ]]
  then
    MAIN_MENU
  else
    ADD_APPOINTMENT
  fi
}

ADD_APPOINTMENT(){
  echo "Enter your phone number"
  read CUSTOMER_PHONE

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_ID ]]
  then
    echo "Enter your name"
    read CUSTOMER_NAME

    INSERT_CUSTOMER_NAME=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    if [[ $INSERT_CUSTOMER_NAME != 'INSERT 0 1' ]]
    then
      echo "Error updating database!"
    else
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    fi
  fi

  echo "Enter Time:"
  read SERVICE_TIME

  INSERT_NEW_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")
  if [[ $INSERT_NEW_APPOINTMENT = 'INSERT 0 1' ]]
  then
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id = '$CUSTOMER_ID'")
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
    echo I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME.
  else
    echo Error updating database
  fi
}

MAIN_MENU
