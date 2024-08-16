import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<Homescreen> {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://prereg.ex.api.ampiy.com/prices'),
  );

  Map<String, dynamic> btcData = {};
  Map<String, dynamic> ethData = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AI for Humans. Built by India, for the World.',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('AI BHARATA EMERGING TECHNOLOGIES PVT LTD'),
          const Text('HQ Address: #32/A Main Bazaar Sandur, Karnataka, 583119'),
          const Text('Email: contact@aibharata.com'),
          const SizedBox(height: 32),
          const Text('Crypto Prices:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          if (btcData.isNotEmpty) ...[
            Text('BTCINR: ${btcData['c']}'),
            Text('Price Change: ${btcData['p']}%'),
          ],
          const SizedBox(height: 16),
          if (ethData.isNotEmpty) ...[
            Text('ETHINR: ${ethData['c']}'),
            Text('Price Change: ${ethData['p']}%'),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    channel.sink.add(jsonEncode({
      "method": "SUBSCRIBE",
      "params": ["all@ticker"],
      "cid": 1
    }));

    channel.stream.listen((message) {
      final data = jsonDecode(message);
      if (data['stream'] == 'all@fpTckr') {
        setState(() {
          btcData = data['data']
              .firstWhere((item) => item['s'] == 'BTCINR', orElse: () => {});
          ethData = data['data']
              .firstWhere((item) => item['s'] == 'ETHINR', orElse: () => {});
        });
      }
    });
  }
}
