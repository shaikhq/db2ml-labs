#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <database_name>"
  exit 1
fi

# Assign the first argument to a variable
DB_NAME=$1

# Connect to the specified database
db2 "CONNECT TO $DB_NAME"

db2 "DROP TABLE GOSALES"
db2 "DROP TABLE GOSALES_TRAIN"
db2 "DROP TABLE GOSALES_TEST"
db2 "DROP TABLE GOSALES_TRAIN_SUM1000"
db2 "DROP TABLE GOSALES_TRAIN_SUM1000_CHAR"
db2 "DROP TABLE GOSALES_TRAIN_SUM1000_NUM"
db2 "DROP TABLE GOSALES_TEST_PREDICTIONS"

db2 "CREATE TABLE GOSALES(
ID INTEGER NOT NULL,
GENDER VARCHAR(3),
AGE INTEGER,
MARITAL_STATUS VARCHAR(30),
PROFESSION VARCHAR(30),
IS_TENT INTEGER,
PRODUCT_LINE VARCHAR(30),
PURCHASE_AMOUNT DECIMAL(30, 5),
PRIMARY KEY (ID)) 
ORGANIZE BY ROW"

db2 "IMPORT FROM "gosales-data.csv" OF DEL skipcount 1 INSERT INTO 
GOSALES(ID, GENDER, AGE, MARITAL_STATUS, PROFESSION, IS_TENT, PRODUCT_LINE, PURCHASE_AMOUNT)"

db2 "CONNECT RESET"