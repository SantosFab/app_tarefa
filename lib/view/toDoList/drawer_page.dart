import 'package:app_tarefa/resources/login/repository_login_firebaseauth.dart';
import 'package:app_tarefa/utils/when_the_value_is_unknown.dart';
import 'package:app_tarefa/widget/my_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  late final FirebaseAuth _firebaseAuth;
  late final User? user;
  //corrigir isso
  late final RepositoryLoginFireBaseAuth _repositoryLoginFireBaseAuth;
  @override
  void initState() {
    _firebaseAuth = FirebaseAuth.instance;
    user = _firebaseAuth.currentUser;
    _repositoryLoginFireBaseAuth = RepositoryLoginFireBaseAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user;
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(
              user != null
                  ? user!.email!
                  : WhenTheValueIsUnknown.emailOfDrawerHeader,
            ),
            accountName: Text(
              user != null && user!.displayName != null
                  ? user!.displayName!
                  : WhenTheValueIsUnknown.nameOfDrawerHeader,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user != null && user!.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : const AssetImage(
                          WhenTheValueIsUnknown.addressOfCiCleAvatarPhotoAsset)
                      as ImageProvider,
            ),
            decoration: const BoxDecoration(color: Colors.white12),
          ),
          /*  const ListTile(
            trailing: Icon(Icons.arrow_forward),
            title: Text('Sair'),
            leading: Icon(Icons.logout),
          ),
          const ListTile(
            trailing: Icon(Icons.arrow_forward),
            title: Text('Sair'),
            leading: Icon(Icons.logout),
          ), */
          ListTile(
            trailing: const Icon(Icons.arrow_forward),
            title: const Text('Sair'),
            leading: const Icon(Icons.logout),
            onTap: () {
              _repositoryLoginFireBaseAuth.dispose().then((value) {
                Navigator.of(context).pushReplacementNamed(MyApp.pagehome);
              });
            },
          ),
        ],
      ),
    );
  }
}
