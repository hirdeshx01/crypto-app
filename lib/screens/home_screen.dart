import 'dart:convert';

import 'package:ampiy_homepage/models/crypto_list.dart';
import 'package:ampiy_homepage/screens/components/crypto_symbol.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://prereg.ex.api.ampiy.com/prices'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            const Text(
                'HQ Address: #32/A Main Bazaar Sandur, Karnataka, 583119'),
            const Text('Email: contact@aibharata.com'),
            const SizedBox(height: 32),
            const Text('Crypto Prices:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            // Assuming cryptoData is a Map<String, dynamic> where the key is the crypto symbol and the value is the data
            ...cryptoData.entries.map((entry) {
              return CryptoSymbol(crypto: entry.key, cryptoData: entry.value);
            }),
          ],
        ),
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
          cryptoData.forEach((key, value) {
            final item = data['data'].firstWhere(
              (item) => item['s'] == key,
              orElse: () => {},
            );
            cryptoData[key] = item;
          });
        });
      }
    });
  }
}
