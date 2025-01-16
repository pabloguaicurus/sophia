import 'package:flutter/material.dart';
import 'package:sophia/feature/views/login/login_page.dart';
import 'package:sophia/feature/views/movimentacoes/movimentacao_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOPHIA',
      home: LoginPage(),
    );
  }
}
