import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_application_1/third_screen.dart'; // Altere 'seu_app' para o nome do seu app ou diretório correto

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int? temperatura;
  int? umidade;
  int? bomba;
  int? sensorUmidSolo;
  int? pH;
  Color statusCor = Colors.red;
  bool _isLoading = false;
  String? _errorMessage;
  Timer? _timer;

  Future<void> _leitura() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final response = await http.get(Uri.parse('https://apiintegradoresp-production.up.railway.app/dados'));

      if (response.statusCode == 200) {
        final dados = json.decode(response.body);
        setState(() {
          temperatura = dados["temperatura"];
          umidade = dados["umidade"];
          sensorUmidSolo = dados["sensor_umidsolo"];
          pH = dados["pH"];
          bomba = dados["bomba"];
          statusCor = (bomba == 1) ? Colors.green : Colors.red;
        });
      } else {
        setState(() {
          _errorMessage = 'Falha ao carregar dados: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro de conexão: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _controlarBomba(int estado) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final response = await http.post(
        Uri.parse('https://apiintegradoresp-production.up.railway.app/bomba'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'estado': estado}),
      );

      if (response.statusCode == 200) {
        await _leitura();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Bomba ${estado == 1 ? 'ligada' : 'desligada'} com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() {
          _errorMessage = "Erro ao ${estado == 1 ? 'ligar' : 'desligar'} a bomba: ${response.statusCode}";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro: $_errorMessage"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Erro na requisição: $e";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro de conexão: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _leitura();
    _startPolling();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _leitura();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ThirdScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _leitura,
                            child: const Text('Tentar Novamente'),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildCard('Temperatura', temperatura?.toString() ?? 'N/A', Colors.yellow, LineChartPainter()),
                          const SizedBox(height: 16),
                          _buildCard('Umidade', umidade?.toString() ?? 'N/A', Colors.blue, LineChartPainter()),
                          const SizedBox(height: 16),
                          _buildCard('Umidade do Solo', sensorUmidSolo?.toString() ?? 'N/A', Colors.green, LineChartPainter()),
                          const SizedBox(height: 16),
                          _buildCard('pH', pH?.toString() ?? 'N/A', Colors.orange, LineChartPainter()),
                          const SizedBox(height: 16),
                        ],
                      ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 200,
                color: statusCor,
                child: const Text(
                  "Bomba de Irrigação",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _controlarBomba(1),
              child: const Text('Ligar Bomba'),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _controlarBomba(0),
              child: const Text('Desligar Bomba'),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _leitura,
              child: const Text('Atualizar Dados Manualmente'),
            ),
          ],
        ),
      ),
    );
  }

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
