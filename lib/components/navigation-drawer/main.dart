import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NavigationDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(34, 150, 243, 1),
        child: ListView(
          children: [
            SizedBox(height: 40),
            drawerTile(
                icon: Icons.home,
                text: 'Dashboard',
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/dashboard',
                    (route) => false,
                  );
                }),
            drawerTile(
              icon: Icons.people,
              text: 'Members',
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/members',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerTile({
    required String text,
    required IconData icon,
    required void Function() onTap,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onTap,
    );
  }
}
