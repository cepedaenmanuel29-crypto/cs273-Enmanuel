<?php
// Database connection for Basketball 3v3
$host = "127.0.0.1";
$dbname = "basketball3v3db";
$username = "root";

// Local password file, outside the website
$password = require "C:/xampp/php_private/db_password.php";

try {
    $pdo = new PDO(
        "mysql:host=$host;port=3306;dbname=$dbname;charset=utf8mb4",
        $username,
        $password,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false
        ]
    );
} catch (PDOException $e) {
    error_log($e->getMessage());
    throw new RuntimeException("Database connection failed.");
}
?>
