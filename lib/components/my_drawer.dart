import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
            ),
            child: Column(
              children: [
                Text(
                  'SETOR',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Admin Page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
              ],
            ),
          ),
          ListTile(
            onTap: () => Navigator.popAndPushNamed(context, '/home_page'),
            leading: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
          ListTile(
            leading: Icon(
              Icons.group,
            ),
            title: Text('Users'),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/motor_page'),
            leading: Icon(
              Icons.motorcycle,
            ),
            title: Text('Motor'),
          ),
          ListTile(
            leading: Icon(
              Icons.receipt,
            ),
            title: Text('Transaksi'),
          ),
        ],
      ),
    );
  }
}
