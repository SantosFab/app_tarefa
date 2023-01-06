import 'package:app_tarefa/resources/login/repository_login_firebaseauth.dart';
import 'package:app_tarefa/utils/when_the_value_is_unknown.dart';
import 'package:app_tarefa/widget/my_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  final void Function() callback;
  const DrawerPage({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  void Function() get metodListOfTodo => widget.callback;
  late final User? user;
  late final RepositoryLoginFireBaseAuth _repositoryLoginFireBaseAuth;
  @override
  void initState() {
    _repositoryLoginFireBaseAuth = RepositoryLoginFireBaseAuth();
    user = _repositoryLoginFireBaseAuth.hasUser();
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
          ListTile(
            leading: const Icon(Icons.delete_forever_outlined),
            title: const Text('Apagar tudo'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              metodListOfTodo();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            trailing: const Icon(Icons.arrow_forward),
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
