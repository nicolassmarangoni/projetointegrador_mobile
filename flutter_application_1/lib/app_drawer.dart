import 'package:flutter/material.dart';
import 'package:flutter_application_1/third_screen.dart'; // Importe a ThirdScreen
import 'package:flutter_application_1/second_screen.dart'; // Importe a SecondScreen
import 'package:flutter_application_1/dashboardscreen.dart'; // Importe a DashboardScreen

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Navigator.pop(context); // Fecha o drawer
              Navigator.pushReplacement( // Navega para a ThirdScreen
                context,
                MaterialPageRoute(builder: (context) => const ThirdScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context); // Fecha o drawer
              Navigator.pushReplacement( // Navega para a DashboardScreen
                context,
                MaterialPageRoute(builder: (context) => const DashboardScreen()),
              );
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
              Navigator.pop(context); // Fecha o drawer
              // TODO: Implementar ação para o FAQ (se houver uma tela específica)
            },
          ),
          ListTile(
            title: const Text('Suporte'),
            onTap: () {
              Navigator.pop(context); // Fecha o drawer
              // TODO: Implementar ação para o Suporte (se houver uma tela específica)
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context); // Fecha o drawer
                Navigator.pushReplacement( // Navega para a SecondScreen
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              child: const Text('Sair', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
