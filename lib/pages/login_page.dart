import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> performLogin() async {
    final email = emailController.text;
    final password = passwordController.text;

    final response = await http.get(
        Uri.parse('http://localhost:3000/users?email=$email&senha=$password'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData.isNotEmpty) {
        final user = jsonData[0];
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool('isLoggedIn', true);
        sharedPreferences.setString('userId', user['id'].toString());
        sharedPreferences.setString('userName', user['name']);
        sharedPreferences.setString('userManager', user['manager']);
        sharedPreferences.setString('userEmail', user['email']);

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('Login Incorreto'),
              content: Text(
                  'O email ou a senha estão incorretos. Por favor, verifique suas credenciais.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Erro de Conexão'),
            content: Text(
                'Ocorreu um erro ao se conectar à API. Tente novamente mais tarde.'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/background.png",
            width: double.infinity,
            height: 400,
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(40.0),
                color: CupertinoColors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.black,
                      ),
                      child: Text('Login'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CupertinoTextField(
                      controller: emailController,
                      placeholder: 'Email',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CupertinoTextField(
                      controller: passwordController,
                      placeholder: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CupertinoButton.filled(
                      onPressed: performLogin,
                      child: Text('Entrar'),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: Text('Ainda não tem conta?'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
