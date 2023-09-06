import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: <Widget>[
          // Background Image
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
                      onPressed: () {
                        // Check email and password
                        if (emailController.text != 'gabriel' ||
                            passwordController.text != '123') {
                          // Show a CupertinoAlertDialog with an error message
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
                                      Navigator.of(context)
                                          .pop(); // Close the AlertDialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Redirect to the home screen if login is successful
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
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
