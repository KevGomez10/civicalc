import 'package:flutter/material.dart';
import '../../domain/entities/datos_entrada_cono_arena.dart';
import '../../domain/usecases/calcular_ensayo_cono_arena.dart';

class ConoArenaPage extends StatefulWidget {
  const ConoArenaPage({super.key});

  @override
  State<ConoArenaPage> createState() => _ConoArenaPageState();
}

class _ConoArenaPageState extends State<ConoArenaPage> {

  final _formKey = GlobalKey<FormState>();

  // Controllers
  final pesoInicialController = TextEditingController();
  final pesoFinalController = TextEditingController();
  final pesoHumedoController = TextEditingController();
  final humedadController = TextEditingController();

  // Configuración (luego será editable)
  double constanteCono = 1603;
  double densidadArena = 1.458;

  String resultado = "";

  void calcular() {
    try {
      final datos = DatosEntradaConoArena(
        abscisa: "K1+000",
        capa: "1",
        costado: "Derecho",
        pesoInicial: double.parse(pesoInicialController.text),
        pesoFinal: double.parse(pesoFinalController.text),
        constanteCono: constanteCono,
        densidadArena: densidadArena,
        pesoHumedo: double.parse(pesoHumedoController.text),
        pesoSeco: 0, // no se usa en tu flujo real
        humedad: double.parse(humedadController.text),
      );

      final usecase = CalcularEnsayoConoArena();
      final res = usecase.ejecutar(datos);

      setState(() {
        resultado = """
🔹 Arena usada: ${res.arenaUsada.toStringAsFixed(2)}
🔹 Arena en hueco: ${res.arenaHueco.toStringAsFixed(2)}
🔹 Volumen: ${res.volumen.toStringAsFixed(2)}
🔹 Densidad: ${res.densidad.toStringAsFixed(3)}
""";
      });

    } catch (e) {
      setState(() {
        resultado = "❌ Error: $e";
      });
    }
  }

  Widget campo(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obligatorio';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ensayo Cono y Arena'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              campo("Peso frasco + arena inicial (g)", pesoInicialController),
              campo("Peso frasco + arena restante (g)", pesoFinalController),
              campo("Peso material húmedo (g)", pesoHumedoController),
              campo("Humedad (%)", humedadController),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    calcular();
                  }
                },
                child: const Text("Calcular"),
              ),

              const SizedBox(height: 20),

              Text(
                resultado,
                style: const TextStyle(fontSize: 16),
              ),

            ],
          ),
        ),
      ),
    );
  }
}