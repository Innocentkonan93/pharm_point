import 'package:flutter/material.dart';
import 'package:pharm_point/screens/Pharm/map_screen.dart';
import 'package:pharm_point/screens/Pharm/pharm_details_screen.dart';
import 'package:pharm_point/screens/Pharm/pharm_screen.dart';
import 'package:pharm_point/screens/Pharm/villes_screen.dart';
import 'package:pharm_point/screens/centreSante/sante_screen.dart';
import 'package:pharm_point/screens/clinics/clinic_screen.dart';
import 'package:pharm_point/screens/login/login_screen.dart';
import 'package:pharm_point/widgets/pref.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharma',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // canvasColor: Color.fromRGBO(255, 254, 229, 1),
        // fontFamily: 'RobotoCondensed',
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => LoginScreen(),
        VilleScreen.routeName: (ctx) => VilleScreen(),
        PharmScreen.routeName: (ctx) => PharmScreen(),
        PharmDetailsScreen.routeName: (ctx) => PharmDetailsScreen(),
        ClinicScreen.nameRoute: (ctx) => ClinicScreen(),
        MapScreen.nameRoute: (ctx) => MapScreen(),
        SanteScreen.nameRoute: (ctx) => SanteScreen(),
      },
    );
  }
}
