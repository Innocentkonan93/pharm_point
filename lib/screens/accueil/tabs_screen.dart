import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharm_point/screens/accueil/home_screen.dart';
import 'package:pharm_point/screens/Pharm/msg_screen.dart';
import 'package:pharm_point/screens/Pharm/profil_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomeScreen(),
        'title': 'Services',
      },
      {
        'page': MessageScreen(),
        'title': 'Messages',
      },
      {
        'page': ProfilScreen(),
        'title': 'Profil',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
          style: GoogleFonts.architectsDaughter(
              fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[300],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category_outlined,
            ),
            label: 'Services',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.sms_outlined,
              ),
              label: 'Messages'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
