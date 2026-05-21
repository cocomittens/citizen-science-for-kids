import 'package:flutter/material.dart';

class BackgroundImageWrapper extends StatelessWidget{
  final Widget child;
  const BackgroundImageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/mobile_web_background.png"),
          fit: BoxFit.cover
        )
      ),
      child: child
    );
  }
}