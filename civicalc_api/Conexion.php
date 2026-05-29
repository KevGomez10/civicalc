<?php
$host = "localhost";
$user = "root";
$password = "";
$database = "civicalc_db";

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    echo json_encode([
        "success" => false,
        "message" => "Error de conexión"
    ]);
    exit;
}

$conn->set_charset("utf8");
?>