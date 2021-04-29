<?php

if($debug) {
    $rawFormData = var_export($_POST, true);
    echo "<p>Form Data: $rawFormData</p>";
}

$submittedForm = $_POST['form'];
processForm($submittedForm);

function processForm($submittedForm) {
    switch($submittedForm) {
        
        case 'show-items':
            echo showItems();
            break;
        
        case 'show-users':
            echo showUsers();
            break;
            
        case 'show-tasks':
            echo showTasks();
            break;
            
        case 'show-borrowers':
            echo showBorrowers();
            break;
            
        case 'show-owner-items':
            echo showOwnerItems(
                $ownerId=$_POST['owner-id']
            );
            break;
            
        case 'borrow-item':
            echo borrowUserItem(
                $borrowerEmail=$_POST['borrower-email'],
                $ownerEmail   =$_POST['owner-email'],
                $itemId       =$_POST['item-id'],
                $quantity     =$_POST['quantity']
            );
            break;
    }
}

function showItems() { return show($entity='Item'); }
function showTasks() { return show($entity='Task'); }
function showUsers() { return show($entity='User'); }
function show($table) {
    switch($table) {
        case 'Item':
            $query = "SELECT * FROM Item";
            break;
        case 'Task':
            $query = "SELECT * FROM Task";
            break;
        case 'User':
            $query = "SELECT * FROM User";
            break;
        default:
            return 'Invalid Entity';
    }
    
    try {
        $GLOBALS['DB']::execute($query);
    } catch(DatabaseQueryException $e) {
        $errorMessage = $e->getMessage();
        $errorCode    = $e->getCode();
        
        return "Error $errorMessage: $errorMessage";
    }
    
    if($results = $GLOBALS['DB']::$results->fetchAll(PDO::FETCH_ASSOC)) {
        $resultsString = "Results: <br><br>";
        
        foreach($results as $row) {
            foreach($row as $columnName => $columnValue) {
                if($columnName == 'isLiquid' || $columnName == 'isElectric') {
                    $columnValue = $columnValue ? 'true' : 'false';
                }
                $resultsString .= "$columnName: $columnValue<br>";
            }
            $resultsString .= "<br>";
        }
        
        return $resultsString;
    } else {
        return 'No Results';
    }
}

function showBorrowers() {
    try {
        $GLOBALS['DB']::execute('SELECT * FROM Borrowers');
    } catch(DatabaseQueryException $e) {
        $errorMessage = $e->getMessage();
        $errorCode    = $e->getCode();
        
        return "Error $errorMessage: $errorMessage";
    }
    
    if($results = $GLOBALS['DB']::$results->fetchAll(PDO::FETCH_ASSOC)) {
        $rowCount = $GLOBALS['DB']::$rowCount;
        $resultsString = "$rowCount Borrowers: <br><br>";
        
        foreach($results as $row) {
            foreach($row as $columnName => $columnValue) {
                $resultsString .= "$columnValue "; // "fname lname "
            }
            $resultsString .= "<br>";
        }
        
        return $resultsString;
    } else {
        return 'No Results';
    }
}

/** Gets the item total of a given Owner */
function showOwnerItems($ownerId) {
    try {
        $GLOBALS['DB']::execute(
           "SELECT totalItems(:ownerId)",
            array(
                ':ownerId' => $ownerId,
        ));
    } catch(DatabaseQueryException $e) {
        $errorMessage = $e->getMessage();
        $errorCode    = $e->getCode();
        
        return "Error $errorMessage: $errorMessage";
    }
    
    if($result = $GLOBALS['DB']::$results->fetch()) {
        $totalItems = $result[0];
        return "Owner $ownerId item count: $totalItems";
    } else {
        return 'No Results';
    }
}

/** Borrows a given Item from a given User */
function borrowUserItem($borrowerEmail, $ownerEmail, $itemId, $quantity) {
    try {
        $GLOBALS['DB']::execute(
           "INSERT INTO USER_BORROW_TOOLS(borrower_email, owner_email, item_id, quantity) VALUES
                (:borrowerEmail, :ownerEmail, :itemId, :quantity)",
            array(
                ':borrowerEmail' => $borrowerEmail,
                ':ownerEmail'    => $ownerEmail,
                ':itemId'        => $itemId,
                ':quantity'      => $quantity
        ));
    } catch(DatabaseQueryException $e) {
        $errorMessage = $e->getMessage();
        $errorCode    = $e->getCode();
        
        return "Error $errorCode: $errorMessage";
    }
    
    if($result = $GLOBALS['DB']::$results) {
        $borrowerEmail = $result['borrowerEmail'];
        $ownerEmail    = $result['ownerEmail'];
        $itemId        = $result['itemId'];
        $quantity      = $result['quantity'];
        
        return "Borrow $quantity $itemId(s) from User $ownerEmail";
    } else {
        return 'No Results';
    }
}
?>