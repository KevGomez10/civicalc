<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

require_once "conexion.php";

if (!isset($_GET["usuario_id"])) {

    echo json_encode([
        "success" => false,
        "message" => "usuario_id no recibido"
    ]);

    exit;
}

$usuarioId = intval($_GET["usuario_id"]);

$sql = "SELECT *
        FROM ensayos_cono_arena
        WHERE usuario_id = ?
        ORDER BY fecha_registro DESC";

$stmt = $conn->prepare($sql);

$stmt->bind_param(
    "i",
    $usuarioId
);

$stmt->execute();

$result = $stmt->get_result();

$ensayos = [];

while ($row = $result->fetch_assoc()) {
    $ensayos[] = $row;
}

echo json_encode([
    "success" => true,
    "data" => $ensayos
]);

$stmt->close();
$conn->close();

?>