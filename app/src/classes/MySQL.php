<?php

class DatabaseQueryException extends PDOException {};

/** Static MySQL db wrapper for connecting to a db and executing sql queries */
class MySQL {
    // The singlton PHP Database Object (PDO) Connection
    private static $instance;
    
    // The db connection
    private static $connection;
    
    // The last executed SQL query
    public static $query;
    
    // The number of rows returned from the last executed query
    public static $rowCount;
    
    // The last executed query results set
    public static $results;
    
    /**
     * Setup the singleton db instance
     * 
     * @param string $dbhost
     * @param string $dbname
     * @param string $dbuser
     * @param string $dbpass
     */
    private function __construct($dbhost='', $dbname='', $dbuser='', $dbpass='') {
        // Open a connection to the specified database
        self::$connection = new PDO(
            "mysql:host=$dbhost;dbname=$dbname",
            $dbuser,
            $dbpass
        );
        
        // Set PDO to discard emulated prepared statements, as they are not safe
        self::$connection->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
        // Set PDO error mode to throw exceptions
        self::$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }
    
    /** Get or instantiate the singleton MySql DB instance */
    public static function getConnection($dbhost='', $dbname='', $dbuser='', $dbpass='') {
        if(isset(self::$instance)) return self::$instance;
        else                       return self::$instance = new self($dbhost, $dbname, $dbuser, $dbpass);
    }
    
    /**
     * Executes an SQL query statement with an array of bind parameters
     * 
     * @param string $sqlQuery   Query string to execute
     * @param array  $sqlParams  Key value pairs to bind to the query
     */
    public static function execute($sqlQuery, $sqlParams=array(), $driver_options=array()) {
        $connection = self::$connection;
        
        try {
            // Prepare the SQL $query
            self::$query = $connection->prepare($sqlQuery, $driver_options);
            $query       = self::$query;
            
            // Execute the prepared statement $query, with or without bound $sqlParams
            empty($sqlParams) ? $query->execute() : $query->execute($sqlParams);
            
            // Get the number of rows from the executed $query
            self::$rowCount = $query->rowCount();
            
            // Save the executed $query as a results set that can be fetched
            self::$results = $query;
        } catch(PDOException $e) {
            throw new DatabaseQueryException($e);
        }
    }
}
?>
