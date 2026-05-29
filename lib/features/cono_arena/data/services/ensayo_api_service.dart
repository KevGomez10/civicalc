import 'dart:convert';
import 'package:http/http.dart' as http;

class EnsayoApiService {
  static const String baseUrl = "http://localhost/civicalc_api";

  Future<bool> guardarEnsayo({
    required String abscisa,
    required String capa,
    required String costado,
    required double pesoInicial,
    required double pesoFinal,
    required double constanteCono,
    required double densidadArena,
    required double pesoHumedo,
    required double humedad,
    required double arenaUsada,
    required double arenaHueco,
    required double volumen,
    required double densidad,
  }) async {
    final url = Uri.parse("$baseUrl/guardar_ensayo.php");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "abscisa": abscisa,
        "capa": capa,
        "costado": costado,
        "peso_inicial": pesoInicial,
        "peso_final": pesoFinal,
        "constante_cono": constanteCono,
        "densidad_arena": densidadArena,
        "peso_humedo": pesoHumedo,
        "humedad": humedad,
        "arena_usada": arenaUsada,
        "arena_hueco": arenaHueco,
        "volumen": volumen,
        "densidad": densidad,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["success"] == true;
    }

    return false;
  }
}