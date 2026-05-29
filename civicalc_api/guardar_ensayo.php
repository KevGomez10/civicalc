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

$sql = "INSERT INTO ensayos_cono_arena (
    usuario_id, abscisa, capa, costado,
    peso_inicial, peso_final, constante_cono, densidad_arena,
    peso_humedo, humedad,
    arena_usada, arena_hueco, volumen, densidad
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);

$stmt->bind_param(
    "isssdddddddddd",
    $data["usuario_id"],
    $data["abscisa"],
    $data["capa"],
    $data["costado"],
    $data["peso_inicial"],
    $data["peso_final"],
    $data["constante_cono"],
    $data["densidad_arena"],
    $data["peso_humedo"],
    $data["humedad"],
    $data["arena_usada"],
    $data["arena_hueco"],
    $data["volumen"],
    $data["densidad"]
);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Ensayo guardado correctamente"
    ]);
} else {

    echo json_encode([
        "success" => false,
        "message" => $stmt->error
    ]);

}

$stmt->close();
$conn->close();
?>