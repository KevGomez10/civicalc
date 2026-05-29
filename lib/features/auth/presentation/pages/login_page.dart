import 'package:flutter/material.dart';
import '../../../cono_arena/presentation/pages/cono_arena_page.dart';
import 'register_page.dart';
import 'package:civicalc/core/usuarios_db.dart';
import 'package:civicalc/core/utils/usuario_sesion.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();

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
              onPressed: () {

                final usuarioEncontrado =
                    UsuariosDB.usuarios.firstWhere(

                  (u) =>
                      u["usuario"] == usuarioController.text &&
                      u["password"] == passwordController.text,

                  orElse: () => {},

                );

                if (usuarioEncontrado.isNotEmpty) {

                  UsuarioSesion.nombre =
                      usuarioEncontrado["nombre"] ?? "";

                  UsuarioSesion.empresa =
                      usuarioEncontrado["empresa"] ?? "";

                  UsuarioSesion.proyecto =
                      usuarioEncontrado["proyecto"] ?? "";

                  UsuarioSesion.usuario =
                      usuarioEncontrado["usuario"] ?? "";

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ConoArenaPage(),
                    ),
                  );

                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Usuario o contraseña incorrectos",
                      ),
                    ),
                  );

                }

              },
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