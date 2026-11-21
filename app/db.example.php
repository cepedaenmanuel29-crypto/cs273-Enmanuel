<?php
// Example database connection.
// Copy this configuration locally and use your own credentials.
$host = "127.0.0.1";
$dbname = "basketball3v3db";
$username = "your_username";
$password = "your_password";

$pdo = new PDO(
    "mysql:host=$host;dbname=$dbname;charset=utf8mb4",
    $username,
    $password,
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false
    ]
);
?>
