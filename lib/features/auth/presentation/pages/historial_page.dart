import 'package:flutter/material.dart';
import '../../data/services/ensayo_api_service.dart';

class HistorialPage extends StatefulWidget {
const HistorialPage({super.key});

@override
State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {

final api = EnsayoApiService();

List<dynamic> ensayos = [];

bool cargando = true;

@override
void initState() {
super.initState();
cargarEnsayos();
}

Future<void> cargarEnsayos() async {
final data = await api.obtenerEnsayos();

setState(() {
  ensayos = data;
  cargando = false;
});


}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Historial"),
),
body: cargando
? const Center(
child: CircularProgressIndicator(),
)
: ListView.builder(
itemCount: ensayos.length,
itemBuilder: (context, index) {


            final ensayo = ensayos[index];

            final ensayoId = int.parse(
  ensayo["id"].toString(),
);

            return Card(
  margin: const EdgeInsets.all(10),
  elevation: 4,
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "📍 Abscisa: ${ensayo["abscisa"]}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        Text("🧱 Capa: ${ensayo["capa"]}"),
        Text("↔ Costado: ${ensayo["costado"]}"),

        const Divider(),

        Text("⚖ Peso inicial: ${ensayo["peso_inicial"]}"),
        Text("⚖ Peso final: ${ensayo["peso_final"]}"),

        const SizedBox(height: 5),

        Text("📏 Constante cono: ${ensayo["constante_cono"]}"),
        Text("🏖 Densidad arena: ${ensayo["densidad_arena"]}"),

        const Divider(),

        Text("💧 Peso húmedo: ${ensayo["peso_humedo"]}"),
        Text("💧 Humedad: ${ensayo["humedad"]}"),

        const Divider(),

        Text("🟡 Arena usada: ${ensayo["arena_usada"]}"),
        Text("🟡 Arena hueco: ${ensayo["arena_hueco"]}"),

        const Divider(),

        Text(
          "📦 Volumen calculado: ${ensayo["volumen"]}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          "🏋 Densidad calculada: ${ensayo["densidad"]}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "📅 ${ensayo["fecha_registro"]}",
          
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
const SizedBox(height: 10),

Align(
  alignment: Alignment.centerRight,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.delete),
    label: const Text("Eliminar"),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    ),
    onPressed: () async {

      final confirmar =
          await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Eliminar ensayo",
            ),
            content: const Text(
              "¿Desea eliminar este ensayo?",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    false,
                  );
                },
                child: const Text(
                  "Cancelar",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    true,
                  );
                },
                child: const Text(
                  "Eliminar",
                ),
              ),
            ],
          );
        },
      );

      if (confirmar == true) {

        final eliminado =
            await api.eliminarEnsayo(
          ensayoId,
        );

print("ID A ELIMINAR: $ensayoId");
print("ELIMINADO: $eliminado");

        if (eliminado) {
          cargarEnsayos();
        }
      }
    },
  ),
),
      ],
    ),
  ),
);
          },
        ),
);

}
}
