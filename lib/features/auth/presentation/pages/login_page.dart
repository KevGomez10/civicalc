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

  bool isDark = false;

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

      final data = jsonDecode(response.body);

      if (data["success"] == true) {

        UsuarioSesion.id =
            data["usuario"]["id"] ?? 0;

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
  final dark = isDark;
  return Scaffold(
  appBar: AppBar(
    backgroundColor:
        dark ? const Color(0xFF1F1F1F) : Colors.white,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(
          dark ? Icons.light_mode : Icons.dark_mode,
          color:
              dark ? Colors.white : Colors.black,
        ),
        onPressed: () {
          setState(() {
            isDark = !isDark;
          });
        },
      ),
    ],
  ),

  body: Container(
  color:
    dark
        ? const Color(0xFF121212)
        : Colors.grey.shade100,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
  color:
    dark
        ? const Color(0xFF1F1F1F)
        : Colors.white,

  borderRadius: BorderRadius.circular(20),

  border: Border.all(
  color: const Color(0xFF45A4F2),
  width: 2,
),
  boxShadow: const [
                BoxShadow(
                  blurRadius: 15,
                  color: Colors.black26,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Image.asset(
                  "assets/Logo Civicalc.png",
                  height: 100,
                ),

                const SizedBox(height: 10),

Container(
  width: 120,
  height: 4,
  decoration: BoxDecoration(
    color: const Color(0xFF45A4F2),
    borderRadius: BorderRadius.circular(20),
  ),
),

                const SizedBox(height: 15),

                Text(
  "Civicalc",
  style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color:
        dark
            ? Colors.white
            : Colors.black,
  ),
),

                const SizedBox(height: 5),

                Text(
  "Bienvenido",
  style: TextStyle(
    color:
        dark
            ? Colors.white70
            : Colors.grey,
  ),
),

                const SizedBox(height: 30),

                TextField(
  controller: usuarioController,

  style: TextStyle(
    color:
        dark
            ? Colors.white
            : Colors.black,
  ),

  decoration: InputDecoration(
    labelText: "Usuario",

    labelStyle: TextStyle(
  color:
      dark
          ? Colors.white
          : Colors.black,
),

enabledBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(
    color:
        dark
            ? Colors.white54
            : Colors.black54,
  ),
),

focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(
    color: Color(0xFF45A4F2),
    width: 2,
  ),
),

    filled: true,
    fillColor:
        dark
            ? const Color(0xFF2A2A2A)
            : Colors.grey.shade50,

    prefixIcon: Icon(
  Icons.person,
  color:
      dark
          ? Colors.white70
          : Colors.black54,
),


    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
),

                const SizedBox(height: 15),

                TextField(
  controller: passwordController,
  obscureText: true,

  style: TextStyle(
    color:
        dark
            ? Colors.white
            : Colors.black,
  ),

  decoration: InputDecoration(
    labelText: "Contraseña",

    labelStyle: TextStyle(
  color:
      dark
          ? Colors.white
          : Colors.black,
),

enabledBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(
    color:
        dark
            ? Colors.white54
            : Colors.black54,
  ),
),

focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(
    color: Color(0xFF45A4F2),
    width: 2,
  ),
),

    filled: true,
    fillColor:
        dark
            ? const Color(0xFF2A2A2A)
            : Colors.grey.shade50,

    prefixIcon: Icon(
  Icons.lock,
  color:
      dark
          ? Colors.white70
          : Colors.black54,
),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: iniciarSesion,
                    style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF45A4F2),
                    foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Ingresar",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterPage(),
      ),
    );
  },
  child: const Text(
    "Crear cuenta",
    style: TextStyle(
      color: Color(0xFF45A4F2),
      fontWeight: FontWeight.w500,
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