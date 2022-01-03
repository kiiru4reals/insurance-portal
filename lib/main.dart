import 'package:insurance_portal/constants/theme_data.dart';
import 'package:insurance_portal/providers/MenuController.dart';
import 'package:insurance_portal/providers/dark_theme_provider.dart';
import 'package:insurance_portal/routes/vehicle_prospective.dart';
import 'package:insurance_portal/screens/main_screen.dart';
import 'package:insurance_portal/screens/user_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(
                  create: (_) => MenuController(),
                ),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeData, child) {
                    return MaterialApp(
                      title: 'Flutter Demo',
                      theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                      home: UserState(),
                      //initialRoute: '/',
                      routes: {
                        //   '/': (ctx) => LandingPage(),
                        MainScreen.routeName: (ctx) => MainScreen(),
                        VehicleProspective.routeName: (ctx) => VehicleProspective(),
                      },
                    );
                  }));
        });
  }
}