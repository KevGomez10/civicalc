import 'package:flutter/material.dart';
import 'features/cono_arena/domain/entities/datos_entrada_cono_arena.dart';
import 'features/cono_arena/domain/usecases/calcular_ensayo_cono_arena.dart';

void main() {
    final datos = DatosEntradaConoArena(
  abscisa: "K1+000",
  capa: "1",
  costado: "Derecho",
  pesoInicial: 7364,
  pesoFinal: 3937,
  constanteCono: 1603,
  densidadArena: 1.458,
  pesoHumedo: 3102,
  pesoSeco: 2845,
);

final usecase = CalcularEnsayoConoArena();
final resultado = usecase.ejecutar(datos);

print('Arena usada: ${resultado.arenaUsada}');
print('Arena en hueco: ${resultado.arenaHueco}');
print('Volumen: ${resultado.volumen}');
print('Humedad: ${resultado.humedad}');
print('Densidad: ${resultado.densidad}');
  runApp(const CivilCalcApp());
}

class CivilCalcApp extends StatelessWidget {
  const CivilCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivilCalc',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CivilCalc'),
        ),
        body: const Center(
          child: Text('CivilCalc iniciado 🚀'),
        ),
      ),
    );
  }
}