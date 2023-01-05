import 'dart:async';

import 'package:app_tarefa/resources/login/repository_login_firebaseauth.dart';
import 'package:app_tarefa/style/custom_style_button.dart';
import 'package:app_tarefa/utils/utils_show_dialog.dart';
import 'package:app_tarefa/widget/box_text_from.dart';
import 'package:app_tarefa/widget/my_app.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final RepositoryLoginFireBaseAuth _repositoryLoginFireBaseAuth;
  late final TextEditingController? _controllerEmail;
  late final TextEditingController? _controllerPassWord;
  late final TextEditingController? _controllerCreateNewUserEmail;
  late final TextEditingController? _controllerCreateNewUserPassWord;
  @override
  void initState() {
    super.initState();

    _repositoryLoginFireBaseAuth = RepositoryLoginFireBaseAuth();
    _controllerEmail = TextEditingController()
      ..text = 'fabriciosantos.dev@gmail.com';
    _controllerPassWord = TextEditingController()..text = '123456';
    _controllerCreateNewUserEmail = TextEditingController()
      ..text = 'fabriciosantos.dev@gmail.com';
    _controllerCreateNewUserPassWord = TextEditingController()..text = '123456';
    User? user = _repositoryLoginFireBaseAuth.hasUser();
    if (user != null) {
      Timer.run(() {
        Navigator.of(context).pushReplacementNamed(MyApp.pageToDoList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxTextFrom(
              paddingBottom: 8,
              label: 'Por favor, digite o e-mail',
              hintText: 'Ex: exemplo@exemplo.com',
              textInputType: TextInputType.emailAddress,
              controller: _controllerEmail,
            ),
            BoxTextFrom(
              label: 'Por favor, digite a senha',
              obscureText: true,
              controller: _controllerPassWord,
            ),
            ElevatedButton(
              onPressed: () {
                _repositoryLoginFireBaseAuth
                    .logIntoWithEmailAndPassword(
                        email: _controllerEmail!.text,
                        password: _controllerPassWord!.text)
                    .then((value) {
                  if (value != null) {
                    Navigator.of(context)
                        .pushReplacementNamed(MyApp.pageToDoList);
                  }
                });
              },
              style: CustomStyleButton.homeButtonLogin,
              child: const Text('Iniciar sessão'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Não tens uma conta? '),
                TextButton(
                  onPressed: () {
                    showdialogCreateUser(
                      context,
                      controllerCreateNewUserEmail:
                          _controllerCreateNewUserEmail,
                      controllerCreateNewUserPassWord:
                          _controllerCreateNewUserPassWord,
                      onPressedOfCreate: () {
                        _repositoryLoginFireBaseAuth
                            .createNewUserEmailAndPassWord(
                          email: _controllerCreateNewUserEmail!.text,
                          password: _controllerCreateNewUserPassWord!.text,
                          name: 'fabricio',
                        )
                            .then(
                          (user) {
                            if (user != null) {
                              Navigator.of(context)
                                  .pushReplacementNamed(MyApp.pageToDoList);
                            }
                          },
                        );
                      },
                      onPressedOfCancel: () => Navigator.of(context).pop(),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Text('Inscreva-se agora'),
                ),
              ],
            ),
            GoogleAuthButton(
              text: 'Entrar com Google',
              onPressed: () {
                _repositoryLoginFireBaseAuth.isLoggedWithGoogle().then(
                  (user) {
                    if (user != null) {
                      Navigator.of(context)
                          .pushReplacementNamed(MyApp.pageToDoList);
                    }
                  },
                );
              },
              themeMode: ThemeMode.dark,
            ),
          ],
        ),
      ),
    );
  }
}
