import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../globalparam/global_param.dart';
import '../pages/theme/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
           DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade600, Colors.grey.shade800, Colors.black],
              ),
            ),
            child: const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("lib/img/profile.png"),
                radius: 40,
              ),
            ),
          ),
         /* ...GlobalParams.menus.map((item) {
            return Column(
              children: [
                ListTile(
                  title: Text('${item['title']}', style: TextStyle(fontSize: 20)),
                  leading: item['icon'],
                  trailing: const Icon(Icons.arrow_right, color: Colors.orange),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the drawer
                  },
                ),
                Divider(color: Colors.grey[400], height: 4),
              ],
            );
          }),*/
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.topCenter,
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return CupertinoSwitch(
                    value: themeProvider.isDarkMode,
                    onChanged: (bool value) {
                      themeProvider.toggleTheme();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
