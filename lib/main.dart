import 'package:insurance_portal/constants/theme_data.dart';
import 'package:insurance_portal/providers/MenuController.dart';
import 'package:insurance_portal/providers/dark_theme_provider.dart';
import 'package:insurance_portal/providers/life_insurer_provider.dart';
import 'package:insurance_portal/providers/life_provider.dart';
import 'package:insurance_portal/providers/travel_insurer_provider.dart';
import 'package:insurance_portal/providers/vehicle_insurer_provider.dart';
import 'package:insurance_portal/providers/vehicles_provider.dart';
import 'package:insurance_portal/routes/add_underwriters/add_life_insurer.dart';
import 'package:insurance_portal/routes/add_underwriters/add_travel_insurer.dart';
import 'package:insurance_portal/routes/add_underwriters/add_vehicle_insurer.dart';
import 'package:insurance_portal/routes/clients/life_clients.dart';
import 'package:insurance_portal/routes/clients/vehicle_clients.dart';
import 'package:insurance_portal/routes/underwriter_details/vehicle_details.dart';
import 'package:insurance_portal/routes/underwriters/life_underwriters.dart';
import 'package:insurance_portal/routes/underwriters/travel_underwriters.dart';
import 'package:insurance_portal/routes/underwriters/vehicle_underwriters.dart';
import 'package:insurance_portal/routes/flip_vehicle_client.dart';
import 'package:insurance_portal/routes/underwriter_options.dart';
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
                ChangeNotifierProvider(
                  create: (_) => VehicleInsurersProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => LifeInsurersProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => InsuredVehiclesProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => InsuredLivesProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => TravelInsurersProvider(),
                ),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeData, child) {
                    return MaterialApp(
                      title: 'HillenInsure | School Project',
                      theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                      home: UserState(),
                      //initialRoute: '/',
                      routes: {
                        //   '/': (ctx) => LandingPage(),
                        MainScreen.routeName: (ctx) => MainScreen(),
                        VehicleProspective.routeName: (ctx) => VehicleProspective(),
                        FlipVehicleClient.routeName: (ctx) => FlipVehicleClient(),
                        AddVehicleInsurer.routeName: (ctx) => AddVehicleInsurer(),
                        SelectUnderwriter.routeName: (ctx) => SelectUnderwriter(),
                        AddLifeInsurer.routeName: (ctx) => AddLifeInsurer(),
                        VehicleUnderwriters.routeName: (ctx) => VehicleUnderwriters(),
                        LifeUnderwriters.routeName: (ctx) => LifeUnderwriters(),
                        VehicleClients.routeName: (ctx) => VehicleClients(),
                        LifeClients.routeName: (ctx) => LifeClients(),
                        VehicleDetails.routeName: (ctx) => VehicleDetails(),
                        TravelUnderwriters.routeName: (ctx) => TravelUnderwriters(),
                        AddTravelInsurer.routeName: (ctx) => AddTravelInsurer(),
                      },
                    );
                  }));
        });
  }
}