import 'package:flutter/material.dart';

class LoomBody extends StatelessWidget {
  const LoomBody({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
