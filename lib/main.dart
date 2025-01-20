import 'package:flutter/material.dart';
import 'package:sophia/feature/views/estoque/estoque_page.dart';
import 'package:sophia/feature/views/login/login_page.dart';
import 'package:sophia/feature/views/movimentacoes/movimentacao_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOPHIA',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Tela inicial é a de login
      routes: {
        '/login': (context) => LoginPage(),
        '/movimentacao': (context) => MovimentacaoPage(),
        //'/dashboard': (context) => DashboardPage(),
        '/movimentacoes': (context) => MovimentacaoPage(),
        '/estoque': (context) => EstoquePage(),
        //'/configuracoes': (context) => ConfiguracoesPage(),
      },
    );
  }
}
