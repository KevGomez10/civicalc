import 'package:civicalc/features/cono_arena/presentation/pages/historial_page.dart';
import 'package:flutter/services.dart';
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

  final pesoInicialController = TextEditingController();
  final pesoFinalController = TextEditingController();
  final pesoHumedoController = TextEditingController();
  final humedadController = TextEditingController();

  double? arenaUsada;
  double? arenaHueco;
  double? volumen;
  double? densidad;

  bool hayResultado = false;
  bool isDark = false;
  List<String> historial = [];

  void calcular() {
    if (!_formKey.currentState!.validate()) return;

    try {
      final datos = DatosEntradaConoArena(
        abscisa: "K1+000",
        capa: "1",
        costado: "Derecho",
        pesoInicial: double.parse(pesoInicialController.text),
        pesoFinal: double.parse(pesoFinalController.text),
        constanteCono: 1603,
        densidadArena: 1.458,
        pesoHumedo: double.parse(pesoHumedoController.text),
        pesoSeco: 0,
        humedad: double.parse(humedadController.text),
      );

      final res = CalcularEnsayoConoArena().ejecutar(datos);

      setState(() {
        hayResultado = true;
        arenaUsada = res.arenaUsada;
        arenaHueco = res.arenaHueco;
        volumen = res.volumen;
        densidad = res.densidad;

        historial.add(
         "Densidad: ${res.densidad.toStringAsFixed(2)} | Volumen: ${res.volumen.toStringAsFixed(2)}",
         );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget inputField(
    String label,
    IconData icon,
    TextEditingController controller,
    bool dark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: dark ? const Color(0xFF1E1F25) : Colors.grey[100],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: controller,
                style: TextStyle(
                  color: dark ? Colors.white : Colors.black,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: label,
                  hintStyle: TextStyle(
                    color: dark ? Colors.grey[400] : Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio";
                  }
                  if (double.tryParse(value) == null) {
                    return "Número inválido";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultItem(
    String title,
    double? value,
    String unit,
    bool dark,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: dark ? Colors.grey[400] : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value != null ? value.toStringAsFixed(2) : "--",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: dark ? Colors.white : Colors.black,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 11,
              color: dark ? Colors.grey : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  final dark = isDark;

  final background =
      dark ? const Color(0xFF0F1115) : const Color(0xFFF7F8FA);
  final cardColor =
      dark ? const Color(0xFF1A1C22) : Colors.white;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
    child: Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text("Ensayo"),
        centerTitle: true,
        backgroundColor: cardColor,
        foregroundColor: dark ? Colors.white : Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      HistorialPage(historial: historial),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              dark ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            width: 380,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.science,
                  size: 40,
                  color: Colors.blue,
                ),
                const SizedBox(height: 10),
                Text(
                  "Cono y Arena",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: dark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      inputField(
                        "Peso inicial",
                        Icons.scale,
                        pesoInicialController,
                        dark,
                      ),
                      inputField(
                        "Peso restante",
                        Icons.scale,
                        pesoFinalController,
                        dark,
                      ),
                      inputField(
                        "Peso húmedo",
                        Icons.inventory,
                        pesoHumedoController,
                        dark,
                      ),
                      inputField(
                        "Humedad (%)",
                        Icons.water_drop,
                        humedadController,
                        dark,
                      ),
                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            calcular();
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 16),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            elevation:
                                MaterialStateProperty.all(4),
                            shadowColor:
                                MaterialStateProperty.all(
                              Colors.blue.withOpacity(0.4),
                            ),
                            overlayColor:
                                MaterialStateProperty.all(
                              Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: const Text(
                            "Calcular",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                if (hayResultado)
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: hayResultado ? 1 : 0,
                    child: AnimatedScale(
                      duration:
                          const Duration(milliseconds: 400),
                      scale: hayResultado ? 1 : 0.95,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius:
                              BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  dark ? 0.2 : 0.05),
                              blurRadius: 20,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Resultados",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                resultItem(
                                    "Arena",
                                    arenaUsada,
                                    "g",
                                    dark),
                                resultItem(
                                    "Hueco",
                                    arenaHueco,
                                    "g",
                                    dark),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                resultItem(
                                    "Volumen",
                                    volumen,
                                    "cm³",
                                    dark),
                                resultItem(
                                    "Densidad",
                                    densidad,
                                    "g/cm³",
                                    dark),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
 }
}