import 'package:flutter/material.dart';

class CryptoSymbol extends StatelessWidget {
  final String crypto;
  final Map<String, dynamic> cryptoData;
  const CryptoSymbol(
      {super.key, required this.crypto, required this.cryptoData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (cryptoData.isNotEmpty) ...[
          Text('$crypto: ${cryptoData['c']}'),
          Text('Price Change: ${cryptoData['p']}%'),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}
