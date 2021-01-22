import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharm_point/widgets/grid_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal[300],
              Colors.tealAccent,
            ],
          ),
        ),

        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       'assets/images/wall.png',
        //     ),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Bienvenu,',
              style: GoogleFonts.robotoCondensed(fontSize: 20),
            ),
            Expanded(
              child: GridScreen(),
            )
          ],
        ),
      ),
    );
  }
}
