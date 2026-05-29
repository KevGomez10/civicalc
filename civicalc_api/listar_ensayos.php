<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

require_once "conexion.php";

$sql = "SELECT * FROM ensayos_cono_arena ORDER BY fecha_registro DESC";
$result = $conn->query($sql);

$ensayos = [];

while ($row = $result->fetch_assoc()) {
    $ensayos[] = $row;
}

echo json_encode([
    "success" => true,
    "data" => $ensayos
]);

$conn->close();
?>