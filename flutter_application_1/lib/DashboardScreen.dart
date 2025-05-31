import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Necessário para usar o Timer

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
  Color statusCor = Colors.red; // Cor inicial da bomba
  bool _isLoading = false; // Indicador de carregamento
  String? _errorMessage; // Mensagem de erro
  Timer? _timer; // Timer para atualização periódica

  // --- Funções de Requisição e Controle ---

  // Função para realizar a leitura dos dados da API
  Future<void> _leitura() async {
    setState(() {
      _isLoading = true; // Ativa o indicador de carregamento
      _errorMessage = null; // Limpa mensagens de erro anteriores
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
          // Atualiza a cor da bomba com base no estado real vindo da API
          statusCor = (bomba == 1) ? Colors.green : Colors.red;
        });
      } else {
        setState(() {
          _errorMessage = 'Falha ao carregar dados: ${response.statusCode}';
        });
        throw Exception('Falha ao carregar dados: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro de conexão: $e';
      });
      print("Erro na requisição de leitura: $e");
    } finally {
      setState(() {
        _isLoading = false; // Desativa o indicador de carregamento
      });
    }
  }

  // Função unificada para controlar a bomba (ligar/desligar)
  Future<void> _controlarBomba(int estado) async {
    setState(() {
      _isLoading = true; // Ativa o indicador de carregamento
      _errorMessage = null; // Limpa mensagens de erro anteriores
    });
    try {
      final response = await http.post(
        Uri.parse('https://apiintegradoresp-production.up.railway.app/bomba'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'estado': estado}),
      );

      if (response.statusCode == 200) {
        // Após o sucesso, força uma nova leitura para atualizar o estado da bomba na UI
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
        _isLoading = false; // Desativa o indicador de carregamento
      });
    }
  }

  // --- Ciclo de Vida do Widget e Timer ---

  @override
  void initState() {
    super.initState();
    _leitura(); // Realiza a primeira leitura ao carregar a tela
    _startPolling(); // Inicia a atualização periódica dos dados
  }

  // Configura o timer para buscar dados a cada 10 segundos
  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _leitura();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela o timer para evitar vazamentos de memória
    super.dispose();
  }

  // --- Construção da UI ---

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
            // Exibição de dados ou indicador de carregamento/erro
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
                          // Seus cards de medição (agora com valores reais ou 'N/A')
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

            // Controle da bomba (sempre visível, mas com _isLoading desabilitando botões)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 200,
                color: statusCor, // A cor da bomba é atualizada por _leitura()
                child: const Text(
                  "Bomba de Irrigação",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _controlarBomba(1), // Desabilita se estiver carregando
              child: const Text('Ligar Bomba'),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _controlarBomba(0), // Desabilita se estiver carregando
              child: const Text('Desligar Bomba'),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _leitura, // Desabilita se estiver carregando
              child: const Text('Atualizar Dados Manualmente'),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir os cards de medição (inalterada do seu código)
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

// Classe para desenhar o gráfico de linha (inalterada do seu código)
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