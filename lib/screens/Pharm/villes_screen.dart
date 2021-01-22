import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:pharm_point/screens/Pharm/pharm_screen.dart';



class VilleScreen extends StatefulWidget {
  static const routeName = '/ville-screen';

  @override
  _VilleScreenState createState() => _VilleScreenState();
}



class _VilleScreenState extends State<VilleScreen> {
  Future<List> getData() async {
    final res = await http.get("http://bad-event.com/pharma/getVille.php");
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pharmacies',
          style: GoogleFonts.architectsDaughter(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {})
        ],
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (ctx, ss) {
          if (ss.hasError) {
            print("Erreur");
          }
          if (ss.hasData) {
            return Column(
              children: [
                Items(list: ss.data),
              ],
            );
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

class Items extends StatefulWidget {
  List list;

  Items({this.list});

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List filteredVille = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: TextField(
          //     decoration: new InputDecoration(
          //       prefixIcon: new Icon(Icons.search),
          //       fillColor: Colors.indigo,
          //       labelText: 'Rechercher',
          //     ),
          //     onChanged: (string) {
          //       setState(() {
          //         filteredVille = widget.list
          //             .where(
          //               (element) => element.nom.toLowerCase().contains(
          //                     string.toLowerCase(),
          //                   ),
          //             )
          //             .toList();
          //         print(filteredVille);
          //       });
          //     },
          //   ),
          // ),
          Container(
            padding: EdgeInsets.all(10),
            height: 600,
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        ('${widget.list[i]['nom']}'.toUpperCase()),
                        style: GoogleFonts.comfortaa(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PharmScreen.routeName,
                          arguments: {
                            'id': widget.list[i]['id'],
                            'nom': widget.list[i]['nom'],
                          },
                        );
                      },
                    ),
                  ),
                );
              },
              itemCount: widget.list.length,
            ),
          ),
        ],
      ),
    );
  }
}

