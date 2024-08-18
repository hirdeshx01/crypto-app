import 'package:cryptofont/cryptofont.dart';
import 'package:flutter/material.dart';

Map<String, String> cryptoFullName = {
  'BTC': 'Bitcoin',
  'ETH': 'Ethereum',
  'XRP': 'Ripple',
  'DOGE': 'Dogecoin',
  'ADA': 'Cardano',
  'DOT': 'Polkadot',
  'UNI': 'Uniswap',
  'LINK': 'Chainlink',
};

Map<String, IconData> cryptoIcons = {
  'BTC': CryptoFontIcons.btc,
  'ETH': CryptoFontIcons.eth,
  'XRP': CryptoFontIcons.xrp,
  'DOGE': CryptoFontIcons.doge,
  'ADA': CryptoFontIcons.ada,
  'DOT': CryptoFontIcons.dot,
  'UNI': CryptoFontIcons.uni,
  'LINK': CryptoFontIcons.link,
};

Map<String, Map<String, dynamic>> cryptoList = {
  'BTC': {},
  'ETH': {},
  'XRP': {},
  'DOGE': {},
  'ADA': {},
  'DOT': {},
  'UNI': {},
  'LINK': {},
};
