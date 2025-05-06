import 'package:flutter/material.dart';

void main() => runApp(const AgromindApp());

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda Tela'),
      ),
      body: Center(
        child: Text('Esta é a segunda tela!'),
      ),
    );
  }
}

class AgromindApp extends StatelessWidget {
  const AgromindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agromind',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo e nome
                Column(
                  children: [
                    Image.asset(
                      'assets/logo.png', // Coloque sua imagem em assets/logo.png
                      height: 60,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'agromind',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

                // Título
                const Text(
                  'Faça seu login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // Campo Usuário
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Campo Senha
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Link de problemas com login
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      // Ação do link
                    },
                    child: const Text(
                      'Problemas com login? Clique aqui',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Botão Acessar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Lógica de login
                    },
                    child: const Text(
                      'Acessar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Voltar
                TextButton.icon(
                  onPressed: () {
                    // Ação de voltar
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Voltar'),
                ),

                const SizedBox(height: 20),

                // Rodapé
                const Text(
                  'Todos os direitos reservados - Agromind 2025',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
