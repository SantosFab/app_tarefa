import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginFirebaseAuth {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Future<User?> loginAuthWithGoogle() async {
    try {
      //Realizar login usando uma conta do google
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        //Pegar o IDtoken e accessToken da conta logada
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        //OAuthCredential é do FireBaseAuth, obtendo credencial para o login no FireBaseAuth
        final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        //Passando a credencial e realizando login no FireBase
        //A diferença para outros plataformas é que será passada outro provider como parâmetro e não o do google
        final UserCredential userCredential =
            await auth.signInWithCredential(oAuthCredential);
        //Por fim, resta somente recuperar o usuário logado
        User? user = userCredential.user;
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<User?> createUserWithEmailAndPassWord({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        user.updateDisplayName(name[0].toUpperCase() + name.substring(1));
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signInFirebaseWithEmailAndPassWord(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  User? hasUser() {
    try {
      if (user != null) {
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  String idOfUser() {
    String userId = user!.uid;
    return userId;
  }

  Future<void> dispose() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
