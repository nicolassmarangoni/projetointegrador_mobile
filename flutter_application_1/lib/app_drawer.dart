import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png', // Substitua pelo caminho real da sua imagem
                        height: 60,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    // TODO: Implementar ação para a Home
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Dashboard'),
                  onTap: () {
                    // TODO: Implementar ação para o Dashboard
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
                  child: Text(
                    'Ajuda',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('FAQ'),
                  onTap: () {
                    // TODO: Implementar ação para o FAQ
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Suporte'),
                  onTap: () {
                    // TODO: Implementar ação para o Suporte
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // TODO: Implementar ação para Sair
                Navigator.pop(context);
              },
              child: const Text('Sair', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
