import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _registerUser(BuildContext context) async {
    final url = Uri.parse('http://localhost:3000/users');

    final response = await http.post(
      url,
      body: {
        'name': nameController.text,
        'email': emailController.text,
        'senha': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Successful registration
      final responseData = json.decode(response.body);
      // You can handle the response data as needed
      print(responseData);
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Handle errors, e.g., display an error message to the user
      print('Registration failed');
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
                      child: Text('Cadastrar'),
                    ),
                    SizedBox(height: 20.0),
                    CupertinoTextField(
                      controller: nameController,
                      placeholder: 'Nome',
                    ),
                    SizedBox(height: 10.0),
                    CupertinoTextField(
                      controller: emailController,
                      placeholder: 'Email',
                    ),
                    SizedBox(height: 10.0),
                    CupertinoTextField(
                      controller: passwordController,
                      placeholder: 'Senha',
                      obscureText: true,
                    ),
                    SizedBox(height: 20.0),
                    CupertinoButton.filled(
                      onPressed: () {
                        _registerUser(context);
                      },
                      child: Text('Cadastrar'),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text('Já tem uma conta?'),
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
