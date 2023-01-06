import 'package:app_tarefa/resources/login/login_firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepositoryLoginFireBaseAuth {
  final LoginFirebaseAuth _loginFirebaseAuth = LoginFirebaseAuth();

  Future<User?> isLoggedWithGoogle() =>
      _loginFirebaseAuth.loginAuthWithGoogle();

  Future<User?> createNewUserEmailAndPassWord({
    required String email,
    required String password,
    required String name,
  }) {
    String nameComplet = '';
    name.split(' ').forEach(
      (letter) {
        String letterFirstUppaerCase =
            letter[0].toUpperCase() + letter.substring(1);

        if (nameComplet == '') {
          nameComplet = letterFirstUppaerCase;
        } else {
          nameComplet += ' $letterFirstUppaerCase';
        }
      },
    );

    Future<User?> user = _loginFirebaseAuth.createUserWithEmailAndPassWord(
      email: email,
      password: password,
      name: nameComplet,
    );
    return user;
  }

  Future<User?> logIntoWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _loginFirebaseAuth.signInFirebaseWithEmailAndPassWord(
        email: email,
        password: password,
      );

  User? hasUser() => _loginFirebaseAuth.hasUser();

  String idUser() => _loginFirebaseAuth.idOfUser();

  Future<void> dispose() => _loginFirebaseAuth.dispose();
}
