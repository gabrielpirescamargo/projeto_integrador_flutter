import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String userName = '';
  String userEmail = '';
  String userManager = '';
  String managerName = ''; // Para armazenar o nome do manager

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final isLoggedIn = sharedPreferences.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      final userNameValue = sharedPreferences.getString('userName') ?? '';
      final userEmailValue = sharedPreferences.getString('userEmail') ?? '';
      final userManagerValue = sharedPreferences.getString('userManager') ?? '';

      // Busque os dados do manager se userManager não for vazio
      if (userManagerValue.isNotEmpty) {
        // Faça a solicitação HTTP para buscar os dados do manager
        final response = await http
            .get(Uri.parse('http://localhost:3000/users?id=$userManagerValue'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data is List && data.isNotEmpty) {
            final managerData = data[
                0]; // Supondo que a resposta seja uma lista com um único usuário
            final managerNameValue = managerData['name'] ?? '';

            setState(() {
              userName = userNameValue;
              userEmail = userEmailValue;
              userManager = userManagerValue;
              managerName = managerNameValue;
            });
          }
        }
      } else {
        setState(() {
          userName = userNameValue;
          userEmail = userEmailValue;
          userManager = userManagerValue;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Perfil'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo, $userName',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Email: $userEmail',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Manager: $userManager',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Nome do Manager: $managerName', // Exibe o nome do manager
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
