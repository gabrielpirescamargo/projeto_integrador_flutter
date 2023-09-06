import 'package:flutter/material.dart';

import 'pages/estoque_page.dart';
import 'pages/home_page.dart';
import 'pages/informacao_manutencao_page.dart';
import 'pages/login_page.dart';
import 'pages/manutencao_page.dart';
import 'pages/perfil_page.dart';
import 'pages/register_page.dart';
import 'pages/scanner_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/maintenance': (context) => MaintenancePage(),
        '/maintenanceDetails': (context) => MaintenanceDetailsPage(),
        '/scanner': (context) => ScannerPage(),
        '/estoque': (context) => EstoquePage(),
        '/perfil': (context) => PerfilPage(),
      },
    );
  }
}
