import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_drawer.dart'; // Importe o arquivo drawer.dart

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
            'assets/images/logo.png', // Substitua pelo caminho real da sua imagem verde
            height: 30,
          ),
        ),
        actions: const [
          SizedBox(width: 48), // Espaço para alinhar o título ao centro
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Medidores',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 24),
            _buildTemperatureCard(),
            const SizedBox(height: 24),
            _buildHumidityCard(),
            const SizedBox(height: 24),
            _buildPumpCard(),
            const SizedBox(height: 32),
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

  Widget _buildTemperatureCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Temperatura', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text('Status:', style: TextStyle(color: Colors.black54)),
              SizedBox(width: 8),
              Icon(Icons.brightness_1, color: Colors.yellow), // Exemplo de status
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('34', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black87)),
              Text('°C', style: TextStyle(fontSize: 24, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: CustomPaint(
              painter: LineChartPainter(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Legenda:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.brightness_1, color: Colors.green),
              SizedBox(width: 4),
              Text('Bom', style: TextStyle(color: Colors.black54)),
              SizedBox(width: 8),
              Icon(Icons.brightness_1, color: Colors.yellow),
              SizedBox(width: 4),
              Text('Alerta', style: TextStyle(color: Colors.black54)),
              SizedBox(width: 8),
              Icon(Icons.brightness_1, color: Colors.red),
              SizedBox(width: 4),
              Text('Perigo', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHumidityCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Umidade', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text('Status:', style: TextStyle(color: Colors.black54)),
              SizedBox(width: 8),
              Icon(Icons.brightness_1, color: Colors.green), // Exemplo de status
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('68', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black87)),
              Text('%', style: TextStyle(fontSize: 24, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            width: 50,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 50,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                Container(
                  height: 50 * 0.68, // Simula a barra de umidade
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Legenda:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.brightness_1, color: Colors.green),
              SizedBox(width: 4),
              Text('Bom', style: TextStyle(color: Colors.black54)),
              SizedBox(width: 8),
              Icon(Icons.brightness_1, color: Colors.red),
              SizedBox(width: 4),
              Text('Perigo', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPumpCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Bomba', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          const Text('Status:', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 8),
          const Switch(
            value: true, // Valor inicial do switch
            onChanged: null, // Desabilitado para este exemplo visual
          ),
          const SizedBox(height: 16),
          const Text(
            'Lembre-se de sempre desligar a bomba para evitar correr riscos.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// Classe para desenhar uma linha simples simulando um gráfico
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.4, size.height * 0.3);
    path.lineTo(size.width * 0.6, size.height * 0.7);
    path.lineTo(size.width * 0.8, size.height * 0.4);
    path.lineTo(size.width, size.height * 0.6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}