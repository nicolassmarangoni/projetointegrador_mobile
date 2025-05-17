import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_drawer.dart'; // Importe o widget do Drawer

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Substitua pelo caminho real da sua imagem
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              'AgroBot',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: const [
          SizedBox(width: 48), // Espaço para alinhar o título ao centro
        ],
      ),
      drawer: const AppDrawer(), // Adicione o Drawer aqui!
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Olá, sou o',
                    style: TextStyle(fontSize: 28, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'AgroBot, como',
                    style: TextStyle(fontSize: 28, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'posso ajudar?',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Digite aqui...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: IconButton(
                    icon: const Icon(Icons.mic, color: Colors.grey),
                    onPressed: () {
                      // TODO: Implementar funcionalidade de microfone
                    },
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.grey),
                    onPressed: () {
                      // TODO: Implementar funcionalidade de adicionar
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}