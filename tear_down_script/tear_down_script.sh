#!/bin/bash

export SNOWSQL_PRIVATE_KEY_PASSPHRASE='$Snowflake#CSCI_5751_2022!'
SUPRESS_OUTPUT=false

snowsql -c login -o exit_on_error=true -o quiet=$SUPRESS_OUTPUT -f tear_down.sql
EXIT_CODE=$?
test $EXIT_CODE -ne 0 && echo "ERROR: tear_down.sql had an error in execution, will not continue. The error code was: $EXIT_CODE" && exit $EXIT_CODE