import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WidgetDismissible extends StatelessWidget {
  final String keyOfDismissible;
  final Widget child;
  final void Function() funcaoDelete;
  final void Function() funcaoEdit;
  const WidgetDismissible({
    Key? key,
    required this.keyOfDismissible,
    required this.child,
    required this.funcaoDelete,
    required this.funcaoEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(keyOfDismissible),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            icon: Icons.create_rounded,
            backgroundColor: Colors.red,
            label: 'Editar',
            onPressed: (context) {
              funcaoEdit();
            },
          ),
          SlidableAction(
            icon: Icons.delete,
            backgroundColor: Colors.red,
            label: 'Deletar',
            onPressed: (context) {
              funcaoDelete();
            },
          ),
        ],
      ),
      child: child,
    );
  }
}
