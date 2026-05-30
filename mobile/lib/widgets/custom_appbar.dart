import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final String subtitle;
  const CustomAppbar({super.key, required this.title, required this.subtitle});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Padding(
            padding: EdgeInsetsGeometry.only(top: 10.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title, style: TextStyle(fontSize: 34)
              ),
            )
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(bottom: 10.0),
            child: Text(subtitle,
            style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white
            )
            )
          )]
        )
      )
    );
  }
}