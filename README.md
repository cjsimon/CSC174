# CSC 174 Advanced Database Project

Targeted towards the current PHP and MySQL versions hosted on athena.csus.edu:  
PHP version 5.6.40  
MySQL version 5.6.41  

## Setup

### Local Development using Docker

Local development using docker is supported.

Execute the following CLI commands in the root project directory, where the `Makefile` and `docker-compose.yml` files are located. A make file is included for convinience, otherwise the docker commands may be run manually.

1. Build the containers:  
$`make build`  
or  
$`docker-compose build`
  
  All containers may be rebuilt without cache using:  
`make rebuild`  
or  
`docker-compose build --no-cache`

1. Run the contains for the project:  
`make start`  
or  
`docker-compose start`

1. To attach to the MySQL Database container:  
`make attach-database`  
or  
`docker exec -it csc174_database /bin/bash`  

    - Within the database container, you can connect to the MySQL instance with the following preconfigured credentials:  
    `mysql -u'root' -p'pass'`

1. To attach to the PHP App container:  
`make attach-app`  
or  
`docker exec -it csc174_app /bin/bash`

In the `docker-compose.yml`, the app container service mounts the PHP `src/` directory into the App container; changes made within the host `src/` directory will be propogated to the container without needing to restart or rebuild the container.

The database container service also mounts three volumes to the host machine: `dbdata/`, which exposes the complete MySQL database file system, `sql/`, a directory on the container used to mount miscellaneous sql files that may be "imported" with the MySQL client using the `source` command, and `initdb/`, a directory that executes `.sh`, `.sql` and `.sql.gz` files upon first starting the container database.

If you would like to completly reinitialize all container databases from scratch, stopping the database container, deleting the host `dbdata/` directory, and restarting the database container will get the container to recreate a fresh database file system from scratch, by reexecuting the `initdb/` files.

### Local Development using local PHP and MySQL Installations

Install PHP version 5.6.40 and MySQL version 5.6.41 locally on your machine, and make sure that both services are exposed locally on the appropriate ports.

Be sure to update the App's db connection parameters in the `src/classes/App.php`->`setup()` function to match your local MySQL instance credentials, and that the db being targeted for `USE` in your sql file is updated as well.

From the root project directory, you can serve the php `src/` local webroot using php's built-in web server:  
`php -S localhost:8080 -t app/src/`

### ECS Development

Assuming your webroot on athena is empty, upload the contents of the `app/src/` php app into your `html/` webroot directory for Apache to access; SFTP or SCP are good tools for acomplishing this.

Update the App's db connection parameters in the `src/classes/App.php`->`setup()` function to match your ecs cs174 db credentials:

```txt
hostname: athena:3306
username: cs174###
database: cs174###
password: ********
```

If you have an sql file, you may "import" it by logging into your MySQL database instance on athena and reading it in using the `source` command.
