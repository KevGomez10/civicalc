import '../entities/datos_entrada_cono_arena.dart';
import '../entities/resultado_cono_arena.dart';
import '../../../../core/utils/number_utils.dart';

class CalcularEnsayoConoArena {
  ResultadoConoArena ejecutar(DatosEntradaConoArena datos) {

    // 🔴 VALIDACIONES

    if (datos.pesoInicial <= 0) {
      throw Exception('El peso inicial debe ser mayor a 0');
    }

    if (datos.pesoFinal <= 0) {
      throw Exception('El peso final debe ser mayor a 0');
    }

    if (datos.pesoInicial <= datos.pesoFinal) {
      throw Exception('El peso inicial debe ser mayor al peso final');
    }

    if (datos.constanteCono <= 0) {
      throw Exception('La constante del cono debe ser mayor a 0');
    }

    if (datos.densidadArena <= 0) {
      throw Exception('La densidad de la arena debe ser mayor a 0');
    }

    if (datos.pesoHumedo <= 0) {
      throw Exception('El peso húmedo debe ser mayor a 0');
    }

    if (datos.humedad < 0) {
      throw Exception('La humedad no puede ser negativa');
    }

    // 🟡 CÁLCULOS

    // 1. Arena total usada
    final arenaTotal = datos.pesoInicial - datos.pesoFinal;

    // 2. Arena en el hueco
    final arenaHueco = arenaTotal - datos.constanteCono;

    if (arenaHueco <= 0) {
      throw Exception('Error: la arena en el hueco es inválida');
    }

    // 3. Volumen del hueco
    final volumen = arenaHueco / datos.densidadArena;

    if (volumen <= 0) {
      throw Exception('Error: volumen inválido');
    }

    // 4. Conversión humedad (ej: 9% → 1.09)
    final humedadFactor = (datos.humedad / 100) + 1;

    // 5. Peso seco
    final pesoSeco = datos.pesoHumedo / humedadFactor;

    // 6. Densidad del material
    final densidadCalculada = pesoSeco / volumen;

    // 🔵 REDONDEO (3 decimales)
    final densidad = NumberUtils.redondearDensidad(densidadCalculada);

    // 🟢 RESULTADO FINAL

    return ResultadoConoArena(
      arenaUsada: arenaTotal,
      arenaHueco: arenaHueco,
      volumen: volumen,
      humedad: datos.humedad,
      densidad: densidad,
    );
  }
}