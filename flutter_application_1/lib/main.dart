import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/second_screen.dart';
 // Importando o arquivo da segunda tela

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Image.asset(
                  'assets/images/logo.png', // Substitua pelo caminho da sua imagem de logo
                  height: 100,
                ),
              ),
              // Texto de boas-vindas
              Text(
                'Welcome,\nBem-vindo,\nBenvenuto,\nBienvenido,\n歡迎',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(  // Usando a fonte Poppins aqui
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Texto para login
              Text(
                'Faça seu login para continuar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              // Botão de acesso
              ElevatedButton(
                onPressed: () {
                  // Ação do botão para navegar para a próxima tela
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen()), // Navega para a segunda tela
                  );
                },
                child: Text('Acessar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Substitui 'primary'
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 40),
              // Rodapé com a fonte Poppins
              Text(
                'Todos os direitos reservados - Agromind 2023',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(  // Usando a fonte Poppins aqui
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
