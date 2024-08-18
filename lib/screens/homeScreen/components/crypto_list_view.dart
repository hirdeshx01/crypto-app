import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoListView extends StatelessWidget {
  final Map<String, Map<String, dynamic>> cryptoList;
  final Map<String, String> cryptoFullName;
  final Map<String, IconData> cryptoIcons;

  const CryptoListView({
    super.key,
    required this.cryptoList,
    required this.cryptoFullName,
    required this.cryptoIcons,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptoList.length,
      itemBuilder: (context, index) {
        String cryptoKey = cryptoList.keys.elementAt(index);
        Map<String, dynamic> cryptoData = cryptoList[cryptoKey]!;
        String fullName = cryptoFullName[cryptoKey] ?? 'Unknown';

        double currentPrice = double.parse(cryptoData['c']);
        String formatCurrentPrice =
            NumberFormat.currency(locale: 'en_IN', symbol: '₹')
                .format(currentPrice);

        Color posOrNeg = double.parse(cryptoData['P']) >= 0
            ? const Color(0xFF32de84)
            : const Color(0xFFfd5c63);

        IconData icon = cryptoIcons[cryptoKey]!;

        return ListTile(
          leading: Icon(icon),
          title: Text(cryptoKey),
          subtitle: Text(fullName),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatCurrentPrice,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    double.parse(cryptoData['P']) >= 0
                        ? Icons.arrow_drop_up_sharp
                        : Icons.arrow_drop_down_sharp,
                    color: posOrNeg,
                  ),
                  Text(
                    '${cryptoData['P']}%',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: posOrNeg,
                        ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {},
        );
      },
    );
  }
}
