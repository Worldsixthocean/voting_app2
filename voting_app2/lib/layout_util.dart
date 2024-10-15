import 'package:flutter/material.dart';

class WidthFull extends StatelessWidget {
  final Widget child;

  const WidthFull({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints: const BoxConstraints.expand(),
      child: child,
    );
  }

}
