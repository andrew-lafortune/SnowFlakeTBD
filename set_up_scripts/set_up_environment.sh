#!/bin/bash

export SNOWSQL_PRIVATE_KEY_PASSPHRASE='$Snowflake#CSCI_5751_2022!'
SUPRESS_OUTPUT=false

snowsql -c login -o exit_on_error=true -o quiet=$SUPRESS_OUTPUT -f create_db_schema_tables.sql
EXIT_CODE=$?
test $EXIT_CODE -ne 0 && echo "ERROR: create_db_scheme_tables.sql had an error in execution, will not continue. The error code was: $EXIT_CODE" && exit $EXIT_CODE

snowsql -c login -o exit_on_error=true -o quiet=$SUPRESS_OUTPUT -f create_stages.sql
EXIT_CODE=$?
test $EXIT_CODE -ne 0 && echo "ERROR: create_stages.sql had an error in execution, will not continue. The error code was: $EXIT_CODE" && exit $EXIT_CODE

snowsql -c login -o exit_on_error=true -o quiet=$SUPRESS_OUTPUT -f load_data.sql
EXIT_CODE=$?
test $EXIT_CODE -ne 0 && echo "ERROR: load_data.sql had an error in execution, will not continue. The error code was: $EXIT_CODE" && exit $EXIT_CODE

snowsql -c login -o exit_on_error=true -o quiet=$SUPRESS_OUTPUT -f transfer_data_to_curated.sql
EXIT_CODE=$?
test $EXIT_CODE -ne 0 && echo "ERROR: transfer_data_to_curated.sql had an error in execution, will not continue. The error code was: $EXIT_CODE" && exit $EXIT_CODE

snowsql -c login -o exit_on_error=true -o quiet=$SUPRESS_OUTPUT -f views_for_curated.sql
EXIT_CODE=$?
test $EXIT_CODE -ne 0 && echo "ERROR: views_for_curated.sql had an error in execution, will not continue. The error code was: $EXIT_CODE" && exit $EXIT_CODE

echo "Setup completed successfully!!"
