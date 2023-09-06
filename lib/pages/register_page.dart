import 'package:flutter/cupertino.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: <Widget>[
          // Imagem de fundo
          Image.asset(
            "assets/background.png",
            width: double.infinity, // Ocupa toda a largura da tela
            height: 400, // Ocupa toda a altura da tela
            fit: BoxFit.cover, // Preenche todo o espaço disponível
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(40.0),
                color: CupertinoColors.white, // Fundo branco com transparência
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Formulário de login
                    DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.black),
                      child: Text('Cadastrar'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CupertinoTextField(
                      placeholder: 'Nome',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CupertinoTextField(
                      placeholder: 'Email',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CupertinoTextField(
                      placeholder: 'Senha',
                      obscureText: true, // Para senhas
                    ),
                    SizedBox(
                      height: 20.0,
                    ), // Espaçamento entre campos e botões
                    CupertinoButton.filled(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text('Cadastrar'),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text('Ja tem uma conta?'),
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
