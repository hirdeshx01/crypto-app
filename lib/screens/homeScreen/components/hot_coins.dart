import 'package:ampiy_homepage/models/crypto_maps.dart';
import 'package:flutter/material.dart';

class HotCoins extends StatelessWidget {
  final bool isLoading;
  const HotCoins({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cryptoList.keys.length,
        itemBuilder: (context, index) {
          final key = cryptoList.keys.elementAt(index);
          final icon = cryptoIcons[key];

          final price = cryptoList[key]!['c'];
          final change = cryptoList[key]!['P'];

          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        key,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 58,
                      ),
                      Icon(icon),
                    ],
                  ),
                  const Spacer(),
                  if (!isLoading) ...[
                    Text(
                      '₹$price',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$change%',
                      style: TextStyle(
                        fontSize: 14,
                        color: change != null && double.tryParse(change)! >= 0
                            ? const Color(0xFF32de84)
                            : const Color(0xFFfd5c63),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
