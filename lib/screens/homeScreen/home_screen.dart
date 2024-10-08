import 'dart:convert';

import 'package:ampiy_homepage/models/crypto_maps.dart';
import 'package:ampiy_homepage/screens/coins_screen.dart';
import 'package:ampiy_homepage/screens/homeScreen/components/button_row.dart';
import 'package:ampiy_homepage/screens/homeScreen/components/chart.dart';
import 'package:ampiy_homepage/screens/homeScreen/components/crypto_list_view.dart';
import 'package:ampiy_homepage/screens/homeScreen/components/hot_coins.dart';
import 'package:ampiy_homepage/screens/homeScreen/components/zones.dart';
import 'package:ampiy_homepage/screens/profile_screen.dart';
import 'package:ampiy_homepage/screens/trading_screen.dart';
import 'package:ampiy_homepage/screens/wallet_screen.dart';
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
  int _currentIndex = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    final clrScheme = Theme.of(context).colorScheme;

    final List<Widget> screens = [
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'MY BALANCE',
                  style: txtTheme.titleMedium!.copyWith(
                    color: clrScheme.onSurface.withAlpha(150),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '₹69,420', //for demonstration purposes only
                  style: txtTheme.displayMedium,
                ),
              ),
              const SizedBox(height: 24),
              const ButtonRow(),
              const SizedBox(height: 24),
              Text(
                'Coins',
                style: txtTheme.titleLarge,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CryptoListView(
                      cryptoList: cryptoList,
                      cryptoFullName: cryptoFullName,
                      cryptoIcons: cryptoIcons,
                    ),
              const SizedBox(height: 24),
              Text(
                'Market Variation Spectrum',
                style: txtTheme.titleLarge,
              ),
              const PriceChangeDistributionChart(),
              const SizedBox(height: 24),
              Text(
                'Hot Coins',
                style: txtTheme.titleLarge,
              ),
              HotCoins(
                isLoading: _isLoading,
              ),
              const SizedBox(height: 24),
              Text(
                'Zones',
                style: txtTheme.titleLarge,
              ),
              const ZoneCard(
                title: 'Solana',
                icon: Icons.whatshot,
                change: '+18.95%',
                changeColor: Color(0xFF32de84),
                newTag: true,
              ),
              const ZoneCard(
                title: 'Launchpool',
                icon: Icons.whatshot,
                change: '+9.94%',
                changeColor: Color(0xFF32de84),
                newTag: true,
              ),
              const ZoneCard(
                title: 'Megadrop',
                icon: Icons.security,
                change: '+0.93%',
                changeColor: Color(0xFF32de84),
                newTag: false,
              ),
              const ZoneCard(
                title: 'AI',
                icon: Icons.memory,
                change: '+39.95%',
                changeColor: Color(0xFF32de84),
                newTag: false,
              ),
            ],
          ),
        ),
      ),
      const CoinsScreen(),
      const TradingScreen(),
      const WalletScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coins'),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(clrScheme),
      body: screens[_currentIndex],
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

  Widget _buildBottomNavigationBar(ColorScheme colorScheme) {
    return BottomNavigationBar(
      selectedItemColor: const Color.fromARGB(255, 41, 25, 255),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_rounded),
          label: 'Coins',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.swap_vert_rounded,
          ),
          label: 'Trade',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet_rounded),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_4_rounded),
          label: 'Profile',
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
