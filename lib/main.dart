import 'package:flutter/material.dart';
import 'home_page.dart';
import 'theme.dart';

void main() {
  runApp(OfflinePayApp());
}

class OfflinePayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OfflinePay',
      theme: AppTheme.darkTheme,
      home: HomePage(),
    );
  }
}
