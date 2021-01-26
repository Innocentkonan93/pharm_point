import 'package:flutter/material.dart';
import 'package:pharm_point/models/pharms_list.dart';
import 'package:pharm_point/screens/Pharm/map_screen.dart';
import 'package:pharm_point/screens/Pharm/pharm_details_screen.dart';
import 'package:pharm_point/screens/Pharm/pharm_screen.dart';
import 'package:pharm_point/widgets/menu_item.dart';

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
        '/': (ctx) => MenuItem(),
        PharmsList.routeName: (ctx) => PharmsList(),
        PharmDetailsScreen.routeName: (ctx) => PharmDetailsScreen(),
        MapScreen.nameRoute: (ctx) => MapScreen(),
      },
    );
  }
}
