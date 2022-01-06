import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = 'Penny Hofstader';
    final email = 'penny@bazinga.biz';
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 41,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'),
                  ),
                ),
                Text(
                name,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(
                  email,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            icon: Icons.dashboard_sharp,
            press: () {},
          ),
          DrawerListTile(
            title: "Manage Users",
            icon: Icons.manage_accounts_sharp,
            press: () {},
          ),
          DrawerListTile(
            title: "Underwriters",
            icon: Icons.verified_sharp,
            press: () {},
          ),
          DrawerListTile(
            title: "Transactions",
            icon: Icons.receipt_long_sharp,
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            icon: Icons.person_sharp,
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            icon: Icons.settings_sharp,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: Colors.purple,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
