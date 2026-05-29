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

            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(
                  "Densidad: ${ensayo["densidad"]}",
                ),
                subtitle: Text(
                  "Volumen: ${ensayo["volumen"]}\nFecha: ${ensayo["fecha_registro"]}",
                ),
              ),
            );
          },
        ),
);


}
}
