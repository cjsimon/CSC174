<?php
$db = self::$db; // https://stackoverflow.com/a/39558928/2104168
?>

<html>
<body>
    <h1>Hello Students!</h1>
    <p>
        <?
            $firstName = 'John';
            
            $db::execute(
               "SELECT `fname`, `lname`
                FROM   `Student`
                WHERE  `fname` = :fname
                LIMIT  1",
                array(
                    ':fname' => $firstName,
            ));
            
            if($result = $db::$results) {
                $firstName = $result['fname'];
                $lastName  = $result['lname'];
                
                echo "Hi, $firstName $lastName!";
            } else {
                echo "No students with first name \"$firstName\"";
            }
        ?>
    </p>
</body>
</html>
