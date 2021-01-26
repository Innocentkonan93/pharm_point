import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pharm_point/models/villes_list.dart';

class MenuItem extends StatefulWidget {
  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  double top = 0;
  double left = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Health Point'), Icon(Icons.location_on)],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: FadeInRightBig(
        child: Stack(
          children: [
            _stackChildren(
              'Pharmacies',
              Icons.medical_services,
              0.6,
              Colors.orangeAccent,
              () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VilleList(),
                  ),
                );
              },
            ),
            _stackChildren(
              'Hôpitaux',
              Icons.medical_services,
              0.4,
              Colors.white,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Service bientôt disponible'),
                  ),
                );
              },
            ),
            _stackChildren(
              'Hôpitaux',
              Icons.medical_services,
              0.2,
              Colors.white,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Service bientôt disponible'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _stackChildren(
    String title,
    IconData icon,
    double bottom,
    Color color,
    Function onTap, {
    Image image,
  }) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * bottom,
      right: MediaQuery.of(context).size.width * 0.28,
      left: MediaQuery.of(context).size.width * 0.28,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          elevation: 25,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: color,
            ),
            height: 130,
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
