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

$nombre = $data["nombre"];
$empresa = $data["empresa"];
$proyecto = $data["proyecto"];
$usuario = $data["usuario"];
$password = $data["password"];

$sqlCheck = "SELECT id FROM usuarios WHERE usuario = ?";
$stmtCheck = $conn->prepare($sqlCheck);
$stmtCheck->bind_param("s", $usuario);
$stmtCheck->execute();
$stmtCheck->store_result();

if ($stmtCheck->num_rows > 0) {
    echo json_encode([
        "success" => false,
        "message" => "El usuario ya existe"
    ]);
    exit;
}

$stmtCheck->close();

$sql = "INSERT INTO usuarios (
    nombre,
    empresa,
    proyecto,
    usuario,
    password
) VALUES (?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);

$stmt->bind_param(
    "sssss",
    $nombre,
    $empresa,
    $proyecto,
    $usuario,
    $password
);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Usuario registrado correctamente"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Error al registrar usuario"
    ]);
}

$stmt->close();
$conn->close();

?>