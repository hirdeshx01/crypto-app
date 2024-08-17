import 'package:flutter/material.dart';

class CryptoListView extends StatelessWidget {
  final Map<String, Map<String, dynamic>> cryptoList;

  const CryptoListView({
    super.key,
    required this.cryptoList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptoList.length,
      itemBuilder: (context, index) {
        String cryptoKey = cryptoList.keys.elementAt(index);
        Map<String, dynamic> cryptoData = cryptoList[cryptoKey]!;
        return ListTile(
          leading: const Icon(Icons.monetization_on),
          title: Text(cryptoKey),
          subtitle: Text('Price: ${cryptoData['BTCINR']}'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        );
      },
    );
  }
}
