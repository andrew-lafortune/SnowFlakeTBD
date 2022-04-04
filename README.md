# Snowflake_POC
Exploring snowflake

Team Name: TBD (Team Big Data)

Private Slack Channel Name: project_1_tbd

Group Members: Tushar Gowda, Andrew LaFortune, Raj Vaibhav Gude, Shashank Magdi

## Using Key pair Authentication
To connect to your Snowflake account through SnowSQL, use the key pair authentication method. For this, you will need a private key and a public key.
To use the key pair with SnowSQL it needs to be encrypted.
Generate the private key using the following command:
```
openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out rsa_key.p8
```
It will ask you for an encryption password. Use a strong one and store it for future use.

Generate the public key corresponding to this private key using the following command
```
openssl rsa -in rsa_key.p8 -pubout -out rsa_key.pub
```

Copy the contents of the public key and execute the following command using your web console:
```
alter user tgowda set rsa_public_key=‘<public key contents>’
```
Now you are ready to use key pair authentication.
You can enter snowsql using the following command:
```
snowsql -a <account_name> -u <user_name> --private-key-path <path_to_the_private_key_generated_above>
```
This will prompt you to enter a passphrase for which you need to enter the password that you saved earlier while generating your private key. To skip this part set your SNOWSQL_PRIVATE_KEY_PASSPHRASE environment variable to the password by using the following command (This is on a mac. You might have to use a different command based on your operating system):
```
export SNOWSQL_PRIVATE_KEY_PASSPHRASE='<Passsword>'
```

## Setting up a connection
SnowSQL takes a lot of flags for authentication. To make this simpler we can setup a connection by editing the config file. The follwing blob needs to be put in the config file which usually resides in ~/.snowsql/config in order to create a connection named login
```
[connections.login]
accountname = <snowflake_account_name>
username = <snowflake_user_name>

private_key_path = <path_to_private_key>
```
After this you can enter snowsql by using the following command
```
snowsql -c login
```

## Environment Setup

To set up this project a total of 5 SQL scripts need to be run. The run order of the scripts has been mentioned below. A utility script has been provided in the [set_up_scripts](set_up_scripts) folder called [set_up_environment.sh](set_up_scripts/set_up_environment.sh). It can be used as an alternative. It quits as soon as an error is encountered. If the output is required to be suppressed, set the SUPRESS_OUTPUT variable to true.

To run any of the below SQL scripts individually use the following command
```
snowsql -c <connection_name> -f <file_name>
```

| Run Order  | File Name                         | Path                                           | Description
| ---------- | --------------------------------- | ---------------------------------------------- | ---------------------------------------
|      1     | create_db_scheme_tables.sql       | set_up_scripts/create_db_scheme_tables.sql     | Creates the database, schemas, and tables.
|      2     | create_stages.sql                 | set_up_scripts/create_stages.sql               | Create stages. It sets the source from where we import data. i.e s3
|      3     | load_data.sql                     | set_up_scripts/load_data.sql                   | Loads the data from stage to created tables.
|      4     | transfer_data_to_curated.sql      | set_up_scripts/transfer_data_to_curated.sql	  | Filters the data errors and loads data into the curated schema.
|      5     | views_for_curated.sql             | set_up_scripts/views_for_curated.sql 		  | Creates views in the curated scheme


## Environment Teardown

To undo all the changes that have been done in this project use the [tear_down.sql](tear_down_script/tear_down.sql). To run it use the following command:
```
snowsql -c <connection_name> -f tear_down_script/tear_down.sql
```
Alternatively, you can also run the shell script provided in the tear_down_script folder
```
./tear_down_script/tear_down_script.sh
```


## Quality analysis performed
1. Sales
   - null check for all cols - PASS
   - check if quantity is less than 0 - PASS
   - check the range of sales. Was between 2018 and 2020 which seems to be sane values - PASS
   - check if orderid is unique - PASS

2. Products
   - check if price is less than 0 - PASS 
   - check if price is equal to 0 - FAIL (48 products) (Ask Chad: Do I need to delete the sales records corresponding to this product?)
   - null check for all cols - PASS
   - check if all names are unique and flag if requried. - PASS

3. Employee
   - null check for firstname, lastname and region - PASS
   
4. Customers
   - null check for firstname, lastname and region - PASS
 
5. Join check:
   - check if sales has any invalid foreign key - PASS

