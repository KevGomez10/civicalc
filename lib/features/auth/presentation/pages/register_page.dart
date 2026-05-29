import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final empresaController = TextEditingController();
  final proyectoController = TextEditingController();
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear cuenta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: "Nombre del laboratorista",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: empresaController,
                decoration: const InputDecoration(
                  labelText: "Empresa",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: proyectoController,
                decoration: const InputDecoration(
                  labelText: "Proyecto",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: usuarioController,
                decoration: const InputDecoration(
                  labelText: "Usuario",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obligatorio";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: confirmarController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirmar contraseña",
                ),
                validator: (value) {
                  if (value != passwordController.text) {
                    return "Las contraseñas no coinciden";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async {

  if (!_formKey.currentState!.validate()) {
    return;
  }

  try {

    final response = await http.post(
      Uri.parse(
        "http://localhost/civicalc_api/registrar_usuario.php",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "nombre": nombreController.text,
        "empresa": empresaController.text,
        "proyecto": proyectoController.text,
        "usuario": usuarioController.text,
        "password": passwordController.text,
      }),
    );

    final data = jsonDecode(response.body);

    if (data["success"] == true) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Cuenta creada correctamente",
          ),
        ),
      );

      Navigator.pop(context);

    } else {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            data["message"] ?? "Error al registrar",
          ),
        ),
      );

    }

  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Error de conexión: $e",
        ),
      ),
    );

  }

},
                child: const Text("Crear cuenta"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}