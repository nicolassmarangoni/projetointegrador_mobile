import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/third_screen.dart'; // Importe o arquivo da ThirdScreen

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  final String validUser = 'usuario';
  final String validPass = '123456';

  void _login() {
    String user = _userController.text.trim();
    String pass = _passController.text.trim();

    if (user == validUser && pass == validPass) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ThirdScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: const Text('Usuário ou senha incorretos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'assets/images/logo.png', 
            ),
            const SizedBox(height: 10),
            const Text(
              'agromind',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 40, thickness: 1),
            Text(
              'Faça seu login',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  TextField(
                    controller: _userController,
                    decoration: InputDecoration(
                      hintText: 'Usuário',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {}, // Ação futura para "Problemas com login?"
                      child: const Text(
                        'Problemas com login? Clique aqui',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color(0xFF2196F3),
                        elevation: 3,
                      ),
                      onPressed: _login,
                      child: const Text('Acessar', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // Volta para a tela anterior
                    },
                  ),
                  const Text('Voltar'),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Todos os direitos reservados - Agromind 2025',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}