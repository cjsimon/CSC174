<?php
require('MySQL.php');

class App {
    // Reference to the singlton database connection instance
    public static $db;
    
    /** Setup and start the App upon instantiation */
    public function __construct() {
        $this->setup();
        $this->start();
    }
    
    /** App Setup */
    public function setup() {
        // Establish the App DB Connection
        // @TODO: Update with your ecs db credentials if hosting on athena
        $dbhost   = 'database:3306'; // athena:3306
        $dbname   = 'Project';       // cs174###
        $dbuser   = 'root';          // cs174###
        $dbpass   = 'pass';          // ********
        self::$db = MySQL::getConnection($dbhost, $dbname, $dbuser, $dbpass);
    }
    
    /** App Entrypoint */
    public function start() {
        // Load a webpage
        require('pages/main.php');
    }
}
?>
