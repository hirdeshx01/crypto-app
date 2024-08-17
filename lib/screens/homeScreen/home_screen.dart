import 'dart:convert';

import 'package:ampiy_homepage/models/crypto_list.dart';
import 'package:ampiy_homepage/screens/homeScreen/components/crypto_symbol.dart';
import 'package:ampiy_homepage/screens/homeScreen/components/custom_button.dart';
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coins'),
        elevation: 4,
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
                '\$69,420', //for demonstration purposes only
                style: textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  icon: Icons.attach_money_rounded,
                  onPressed: () {},
                  label: 'Buy',
                ),
                CustomButton(
                  icon: Icons.swap_vert_rounded,
                  onPressed: () {},
                  label: 'Swap',
                ),
                CustomButton(
                  icon: Icons.arrow_upward_rounded,
                  onPressed: () {},
                  label: 'Send',
                ),
                CustomButton(
                  icon: Icons.arrow_downward_rounded,
                  onPressed: () {},
                  label: 'Recieve',
                )
              ],
            ),
            const SizedBox(height: 24),
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
