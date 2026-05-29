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

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : Colors.white,
        elevation: 0,
        title: Text(
          "Crear cuenta",
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => setState(() => isDark = !isDark),
          ),
        ],
      ),
      body: Container(
        color: isDark ? const Color(0xFF121212) : Colors.grey.shade100,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 500,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1F1F1F) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF45A4F2), width: 2),
                boxShadow: const [
                  BoxShadow(blurRadius: 15, color: Colors.black26, offset: Offset(0, 5))
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/Logo Civicalc.png", height: 100),
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
                      "Crear Cuenta",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Nombre
                    _buildField(
                      controller: nombreController,
                      label: "Nombre del laboratorista",
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 15),

                    // Empresa
                    _buildField(
                      controller: empresaController,
                      label: "Empresa",
                      icon: Icons.business,
                    ),
                    const SizedBox(height: 15),

                    // Proyecto
                    _buildField(
                      controller: proyectoController,
                      label: "Proyecto",
                      icon: Icons.folder,
                    ),
                    const SizedBox(height: 15),

                    // Usuario
                    _buildField(
                      controller: usuarioController,
                      label: "Usuario",
                      icon: Icons.account_circle,
                    ),
                    const SizedBox(height: 15),

                    // Contraseña
                    _buildField(
                      controller: passwordController,
                      label: "Contraseña",
                      icon: Icons.lock,
                      obscure: true,
                    ),
                    const SizedBox(height: 15),

                    // Confirmar contraseña
                    _buildField(
                      controller: confirmarController,
                      label: "Confirmar Contraseña",
                      icon: Icons.lock_outline,
                      obscure: true,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Las contraseñas no coinciden";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF45A4F2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;

                          try {
                            final response = await http.post(
                              Uri.parse("http://localhost/civicalc_api/registrar_usuario.php"),
                              headers: {"Content-Type": "application/json"},
                              body: jsonEncode({
                                "nombre": nombreController.text,
                                "empresa": empresaController.text,
                                "proyecto": proyectoController.text,
                                "usuario": usuarioController.text,
                                "password": passwordController.text,
                              }),
                            );

                            final data = jsonDecode(response.body);

                            if (!mounted) return;

                            if (data["success"] == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Cuenta creada correctamente")),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(data["message"] ?? "Error al registrar")),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error de conexión: $e")),
                            );
                          }
                        },
                        child: const Text(
                          "Crear cuenta",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
        prefixIcon: Icon(icon, color: isDark ? Colors.white70 : Colors.black54),
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: isDark ? Colors.white54 : Colors.black54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF45A4F2), width: 2),
        ),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) return "Campo obligatorio";
            return null;
          },
    );
  }
}