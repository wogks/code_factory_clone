import 'package:codfac/user/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'NotoSans'),
      home: const SplashScreen(),
    );
  }
}
