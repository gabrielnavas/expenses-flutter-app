import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function(String)? onSubmitted;
  final String? placeholder;
  final TextInputType? keyboardType;

  const AdaptativeTextField(
      {required this.textEditingController,
      this.onSubmitted,
      this.placeholder,
      this.keyboardType,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _renderIos() : _renderAndroid();
  }

  TextField _renderAndroid() {
    return TextField(
      controller: textEditingController,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(labelText: placeholder),
      keyboardType: keyboardType,
    );
  }

  CupertinoTextField _renderIos() {
    return CupertinoTextField(
      controller: textEditingController,
      onSubmitted: onSubmitted,
      placeholder: placeholder,
      keyboardType: keyboardType,
    );
  }
}
