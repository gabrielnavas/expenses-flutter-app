import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;

  const AdaptativeButton(
      {required this.onPressed, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: child,
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
            ),
            onPressed: onPressed,
            child: child,
          );
  }
}
