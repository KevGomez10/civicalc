<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST, OPTIONS");

if ($_SERVER["REQUEST_METHOD"] === "OPTIONS") {
    exit;
}

require_once "conexion.php";

$data = json_decode(file_get_contents("php://input"), true);

if (!$data) {
    echo json_encode([
        "success" => false,
        "message" => "No se recibieron datos"
    ]);
    exit;
}

$usuario = $data["usuario"];
$password = $data["password"];

$sql = "SELECT * FROM usuarios
        WHERE usuario = ?
        AND password = ?";

$stmt = $conn->prepare($sql);

$stmt->bind_param(
    "ss",
    $usuario,
    $password
);

$stmt->execute();

$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {

    echo json_encode([
        "success" => true,
        "usuario" => [
"id" => $row["id"],
"nombre" => $row["nombre"],
"empresa" => $row["empresa"],
"proyecto" => $row["proyecto"],
"usuario" => $row["usuario"]
]

    ]);

} else {

    echo json_encode([
        "success" => false,
        "message" => "Usuario o contraseña incorrectos"
    ]);

}

$stmt->close();
$conn->close();

?>