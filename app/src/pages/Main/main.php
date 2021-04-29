<html>
<head>
    <meta charset="UTF-8">
    <title>Item Tracker</title>
    <link id="page-style" rel="stylesheet" href="../../css/DarkMode.css">
</head>
<body>
    <h1>Item Tracker</h1>
    
    <div style="position: absolute; top: 0px; right: 0px; padding: 10px;">
        <button type="button" onclick="togglePageTheme()">Toggle Page Theme</button>
        <script type="text/javascript">
            function togglePageTheme() {
                var styleDom = document.getElementById('page-style');
                styleDom.disabled = !styleDom.disabled ? 'disabled' : undefined;
            }
        </script>
    </div>
    
    <form id="ShowItems" action="" method="post">
        <fieldset>
            <input type="hidden" name="form" value="show-items">
            <legend>Show Items</legend>
            <div>
                <input type="submit" value="Show Items">
            </div>
        </fieldset>
    </form>
    
    <form id="ShowUsers" action="" method="post">
        <fieldset>
            <input type="hidden" name="form" value="show-users">
            <legend>Show Users</legend>
            <div>
                <input type="submit" value="Show Users">
            </div>
        </fieldset>
    </form>
    
    <form id="ShowTasks" action="" method="post">
        <fieldset>
            <input type="hidden" name="form" value="show-tasks">
            <legend>Show Tasks</legend>
            <div>
                <input type="submit" value="Show Tasks">
            </div>
        </fieldset>
    </form>
    
    <form id="ShowOwnerItems" action="" method="post">
        <fieldset>
            <input type="hidden" name="form" value="show-owner-items">
            <legend>Show Items</legend>
            <div>
                <label for="owner-id">Owner Id:</label>
                <input name="owner-id" type="number" placeholder="">
            </div>
            <div>
                <input type="submit" value="Show Owner Items">
            </div>
        </fieldset>
    </form>
    
    <form id="ShowBorrowers" action="" method="post">
        <fieldset>
            <input type="hidden" name="form" value="show-borrowers">
            <legend>Show Borrowers</legend>
            <div>
                <input type="submit" value="Show Borrowers">
            </div>
        </fieldset>
    </form>
    
    <form id="BorrowItem" action="" method="post">
        <fieldset>
            <input type="hidden" name="form" value="borrow-item">
            <legend>Borrow Item</legend>
            <div>
                <label for="borrower-email">Borrower Email:</label>
                <input name="borrower-email" type="email" placeholder="">
            </div>
            <div>
                <label for="owner-email">Owner Email:</label>
                <input name="owner-email" type="email" placeholder="">
            </div>
            <div>
                <label for="item-id">Item ID:</label>
                <input name="item-id" type="number" placeholder="">
            </div>
            <div>
                <label for="quantity">Quantity:</label>
                <input name="quantity" type="number" placeholder="">
            </div>
            <div>
                <input type="submit" value="Borrow Item">
            </div>
        </fieldset>
    </form>
    
    <!--div id="form-results" style="padding: 10px; resize: both; overflow: auto; height: 400px; border: 1px solid black;"-->
    <div id="form-results">
        <?php
            // Process form results
            include('form.php');
        ?>
    </div>
</body>
</html>
