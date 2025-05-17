import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_drawer.dart';
import 'package:flutter_application_1/chatbot.dart'; // Importe a tela do ChatBot

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.grey),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Center(
          child: Image.asset(
            'assets/images/logo.png', // Substitua pelo caminho real da sua imagem
            height: 30,
          ),
        ),
        actions: const [
          SizedBox(width: 48), // Espaço para alinhar o título ao centro
        ],
      ),
      drawer: const AppDrawer(), // Use o widget AppDrawer aqui
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            const Text(
              'Últimas Atualizações',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Versão: 1.0',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '• Implementação do ESP32, para realizar medições de temperatura e umidade.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sobre',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Agromind foi criado com foco na automatização dos sprinters dos sensores focados para fiscalização na área do agronegócio.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Contamos com',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• IA especializada em agro.', style: TextStyle(fontSize: 16)),
                  Text('• Controle facilitado.', style: TextStyle(fontSize: 16)),
                  Text('• Atendimento online 24/7.', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatBotScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'Conversar com o AgroBot',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Todos os direitos reservados - Agromind 2025',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}