import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_application_1/app_drawer.dart'; // Drawer personalizado

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  Future<void> _sendMessage() async {
    final userMessage = _controller.text.trim();
    String url = "https://profdanielvieira95-api-agro-langflow.hf.space/api/v1/run/fa47011f-110e-4e0a-b70d-e7c4c1ff6bf6";

    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({
        'text': userMessage,
        'isMe': true,
        'time': TimeOfDay.now().format(context),
      });
    });

    _controller.clear();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "input_value": userMessage,
          "output_type": "chat",
          "input_type": "chat",
        }),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        print("Resposta da API (decodificada): $decoded"); // <---- LINHA ADICIONADA
        String? botReply;

        // Tenta acessar a resposta em diferentes níveis
        if (decoded is Map && decoded.containsKey("outputs") && decoded["outputs"] is List && decoded["outputs"].isNotEmpty) {
          final firstOutput = decoded["outputs"][0];
          if (firstOutput is Map && firstOutput.containsKey("outputs") && firstOutput["outputs"] is List && firstOutput["outputs"].isNotEmpty) {
            final secondOutput = firstOutput["outputs"][0];
            if (secondOutput is Map && secondOutput.containsKey("results") && secondOutput["results"] is List && secondOutput["results"].isNotEmpty) {
              final firstResult = secondOutput["results"][0];
              if (firstResult is Map && firstResult.containsKey("message") && firstResult["message"] is Map && firstResult["message"].containsKey("text")) {
                botReply = firstResult["message"]["text"];
              }
            } else if (secondOutput is Map && secondOutput.containsKey("text")) {
              botReply = secondOutput["text"];
            }
          } else if (firstOutput is Map && firstOutput.containsKey("text")) {
            botReply = firstOutput["text"];
          } else if (firstOutput is String) {
            botReply = firstOutput;
          }
        } else if (decoded is Map && decoded.containsKey("text")) {
          botReply = decoded["text"];
        } else if (decoded is String) {
          botReply = decoded;
        }

        setState(() {
          _messages.add({
            'text': botReply ?? "Não consegui entender",
            'isMe': false,
            'time': TimeOfDay.now().format(context),
          });
        });
      } else {
        setState(() {
          _messages.add({
            'text': 'Erro ao obter resposta do assistente (Status: ${response.statusCode})',
            'isMe': false,
            'time': TimeOfDay.now().format(context),
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'text': 'Erro de conexão: $e',
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        });
      });
    }
  }

  void _limparMessages() {
    setState(() {
      _messages.clear();
    });
  }

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
              'assets/images/logo.png',
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
          SizedBox(width: 48),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg['isMe'] ? Colors.green[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(msg['text']),
                        const SizedBox(height: 4),
                        Text(
                          msg['time'],
                          style: const TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
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
                    icon: const Icon(Icons.send, color: Colors.grey),
                    onPressed: _sendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.red[200],
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: _limparMessages,
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