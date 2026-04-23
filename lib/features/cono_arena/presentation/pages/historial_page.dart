import 'package:flutter/material.dart';

class HistorialPage extends StatelessWidget {
  final List<String> historial;

  const HistorialPage({super.key, required this.historial});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial")),
      body: ListView.builder(
        itemCount: historial.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(historial[index]),
          );
        },
      ),
    );
  }
}