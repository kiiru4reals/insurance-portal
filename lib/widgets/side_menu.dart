import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurance_portal/constants/color.dart';
import 'package:insurance_portal/providers/dark_theme_provider.dart';
import 'package:insurance_portal/screens/main_screen.dart';
import 'package:insurance_portal/screens/new_admin_user.dart';
import 'package:insurance_portal/screens/underwriters.dart';
import 'package:insurance_portal/screens/user.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final _uname = user!.displayName;
    final _email = user!.email;
    final name = _uname;
    final email = _email;
    final urlImage =
        'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg';
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Drawer(
      child: Material(
        color: ColorConsts.bgColor,
        // color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: _uname.toString(),
              email: _email.toString(),
              onClicked: () {},
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Dashboard',
                    icon: Icons.dashboard,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Underwriters',
                    icon: Icons.verified,
                    onClicked: () => selectedItem(context, 1),
                  ),
/*                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Profile',
                    icon: Icons.person,
                    onClicked: () => selectedItem(context, 2),
                  ),*/
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Add new user',
                    icon: Icons.person_add,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ListTileSwitch(
                    hoverColor: Colors.grey.shade700,
                    value: themeChange.darkTheme,
                    leading: Icon(
                      Icons.dark_mode,
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        themeChange.darkTheme = value;
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Colors.blue,
                    title: Text(
                      'Dark theme',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Sign out',
                    icon: Icons.logout,
                    onClicked: () async {
                      Navigator.pop(context);
                      await _auth.signOut();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.grey.shade700;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UnderWriters(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewAdminUser(),
        ));
        break;
    }
  }
}
