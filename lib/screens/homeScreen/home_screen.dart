import 'dart:convert';

import 'package:ampiy_homepage/models/crypto_list.dart';
import 'package:ampiy_homepage/screens/homeScreen/components/button_row.dart';
import 'package:ampiy_homepage/screens/homeScreen/components/crypto_list_view.dart';
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
  bool _isLoading = false;
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://prereg.ex.api.ampiy.com/prices'),
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coins'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'MY BALANCE',
                style: textTheme.titleMedium!.copyWith(
                  color: colorScheme.onSurface.withAlpha(150),
                ),
              ),
            ),
            Center(
              child: Text(
                '₹69,420', //for demonstration purposes only
                style: textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 24),
            const ButtonRow(),
            const SizedBox(height: 24),
            _isLoading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: CryptoListView(
                      cryptoList: cryptoList,
                      cryptoFullName: cryptoFullName,
                    ),
                  ),
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
    setState(() {
      _isLoading = true;
    });
    channel.sink.add(jsonEncode({
      "method": "SUBSCRIBE",
      "params": ["all@ticker"],
      "cid": 1
    }));

    channel.stream.listen((message) {
      final response = jsonDecode(message);
      if (response['stream'] == 'all@fpTckr') {
        setState(() {
          cryptoList.forEach((key, value) {
            final item = response['data'].firstWhere(
              (item) => item['s'] == '${key}INR',
              orElse: () => {},
            );
            cryptoList[key] = item;
          });
          _isLoading = false;
        });
      }
    });
  }
}
