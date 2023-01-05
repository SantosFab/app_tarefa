import 'package:app_tarefa/style/custom_style_colors.dart';
import 'package:flutter/material.dart';

class BoxTextFrom extends StatelessWidget {
  final bool obscureText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final double paddingBottom;
  const BoxTextFrom({
    Key? key,
    this.obscureText = false,
    this.textInputType,
    this.controller,
    this.label,
    this.hintText,
    this.paddingBottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          label: Text(label ?? ''),
          hintText: hintText,
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: CustomStyleColors.whiter54,
              width: 3,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: CustomStyleColors.blue,
              width: 3,
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
