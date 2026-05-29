import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../cono_arena/presentation/pages/cono_arena_page.dart';
import 'register_page.dart';
import 'package:civicalc/core/utils/usuario_sesion.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> iniciarSesion() async {
    try {
      final response = await http.post(
        Uri.parse(
          "http://localhost/civicalc_api/login.php",
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "usuario": usuarioController.text,
          "password": passwordController.text,
        }),
      );

      print(response.body);

      final data = jsonDecode(response.body);

      if (data["success"] == true) {

        UsuarioSesion.id =
            data["usuario"]["id"] ?? 0;

        print("ID SESION: ${UsuarioSesion.id}");

        UsuarioSesion.nombre =
            data["usuario"]["nombre"] ?? "";

        UsuarioSesion.empresa =
            data["usuario"]["empresa"] ?? "";

        UsuarioSesion.proyecto =
            data["usuario"]["proyecto"] ?? "";

        UsuarioSesion.usuario =
            data["usuario"]["usuario"] ?? "";

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ConoArenaPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data["message"] ??
                  "Usuario o contraseña incorrectos",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio de sesión"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usuarioController,
              decoration: const InputDecoration(
                labelText: "Usuario",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Contraseña",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: iniciarSesion,
              child: const Text("Ingresar"),
            ),

            const SizedBox(height: 15),

            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterPage(),
                  ),
                );
              },
              child: const Text("Crear cuenta"),
            ),
          ],
        ),
      ),
    );
  }
}