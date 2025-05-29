import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Variáveis de estado
  int? temperatura;
  int? umidade;
  int? bomba;
  int? sensorUmidSolo;
  int? pH;
  Color statusCor = Colors.red;

  // Função para realizar a requisição
  Future<void> _leitura() async {
    final response = await http.get(Uri.parse('https://apiintegradoresp-production.up.railway.app/dados'));
    
    if (response.statusCode == 200) {
      final dados = json.decode(response.body);
      setState(() {
        temperatura = dados["temperatura"];
        umidade = dados["umidade"];
        sensorUmidSolo = dados["sensor_umidsolo"];
        pH = dados["pH"];
        bomba = dados["bomba"];
      });
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  // Função para ligar a bomba
  Future<void> _ligarBomba() async {
    try {
      final response = await http.post(
        Uri.parse('https://apiintegradoresp-production.up.railway.app/bomba'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'estado': 1}),
      );

      if (response.statusCode == 200) {
        setState(() {
          statusCor = Colors.green;
        });
        print("Bomba ligada com sucesso!");
      } else {
        print("Erro ao ligar a bomba: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
  }

  // Função para desligar a bomba
  Future<void> _desligarBomba() async {
    try {
      final response = await http.post(
        Uri.parse('https://apiintegradoresp-production.up.railway.app/bomba'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'estado': 0}),
      );

      if (response.statusCode == 200) {
        setState(() {
          statusCor = Colors.red;
        });
        print("Bomba desligada com sucesso!");
      } else {
        print("Erro ao desligar a bomba: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _leitura(); // Carregar dados iniciais
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Exibição de dados
            _buildCard('Temperatura', temperatura?.toString() ?? 'N/A', Colors.yellow, LineChartPainter()),
            const SizedBox(height: 16),
            _buildCard('Umidade', umidade?.toString() ?? 'N/A', Colors.blue, LineChartPainter()),
            const SizedBox(height: 16),
            _buildCard('Sensor de Umidade do Solo', sensorUmidSolo?.toString() ?? 'N/A', Colors.green, LineChartPainter()),
            const SizedBox(height: 16),
            _buildCard('pH', pH?.toString() ?? 'N/A', Colors.orange, LineChartPainter()),
            const SizedBox(height: 16),

            // Controle da bomba
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 200,
                color: statusCor,
                child: const Text(
                  "Bomba de irrigação",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _ligarBomba,
              child: const Text('Ligar bomba'),
            ),
            ElevatedButton(
              onPressed: _desligarBomba,
              child: const Text('Desligar bomba'),
            ),
            ElevatedButton(
              onPressed: _leitura,
              child: const Text('Atualizar Dados'),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir os cards de medição
  Widget _buildCard(String title, String value, Color statusColor, CustomPainter chart) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Status:', style: TextStyle(color: Colors.black54)),
              const SizedBox(width: 8),
              Icon(Icons.brightness_1, color: statusColor),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              value,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(height: 50, child: CustomPaint(painter: chart)),
          const SizedBox(height: 16),
          const Text('Legenda:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
        ],
      ),
    );
  }
}

// Classe para desenhar o gráfico de linha
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
