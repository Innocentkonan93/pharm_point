import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharm_point/screens/Pharm/pharm_details_screen.dart';

class PharmScreen extends StatelessWidget {
  static const routeName = '/pharm-screen';
  @override
  Widget build(BuildContext context) {
    final villeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final villeId = villeArgs['id'];
    final villeName = villeArgs['nom'];

    Future<List> getPharm() async {
      final res = await http
          .get("http://bad-event.com/pharma/getPharm.php?id=$villeId");
      return json.decode(res.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$villeName'.toUpperCase(),
          style: GoogleFonts.architectsDaughter(),
        ),
      ),
      body: FutureBuilder<List>(
        future: getPharm(),
        builder: (ctx, ss) {
          if (ss.hasError) {
            print("Erreur");
          }
          if (ss.hasData) {
            return Items(list: ss.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  List list;

  Items({this.list});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search),
                  fillColor: Colors.indigo,
                  labelText: 'Rechercher'),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 60),
            height: 600,
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                    child: Container(
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.notesMedical,
                      size: 35,
                      color: Colors.teal,
                    ),
                    title: Text(
                      list[i]['nom'],
                      style: GoogleFonts.comfortaa(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      list[i]['tel'],
                      style: GoogleFonts.comfortaa(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.withOpacity(0.7)),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PharmDetailsScreen.routeName,
                        arguments: {
                          'id': list[i]['id'],
                          'nom': list[i]['nom'],
                          'responsable': list[i]['responsable'],
                          'tel': list[i]['tel'],
                          'lati': list[i]['lati'],
                          'longi': list[i]['longi'],
                          'image': list[i]['image'],
                        },
                      );
                    },
                  ),
                ));
              },
              itemCount: list.length,
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
