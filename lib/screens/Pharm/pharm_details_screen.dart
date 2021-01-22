import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pharm_point/screens/Pharm/map_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmDetailsScreen extends StatelessWidget {
  static const routeName = '/pharm-details';

  Future<void> makeCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Nous ne pouvons pas lancer l'appel au $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    final pharmArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final pharmId = pharmArgs['id'];
    final pharmName = pharmArgs['nom'];
    final pharmResp = pharmArgs['responsable'];
    final pharmTel = pharmArgs['tel'];
    final pharmLat = pharmArgs['lati'];
    final pharmLong = pharmArgs['longi'];
    final pharmImg = pharmArgs['image'];

    var tel = pharmTel.split('/');
    var tel1 = tel[0];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 250,
            elevation: 2,
            flexibleSpace: FlexibleSpaceBar(
                // background: Image.network(
                //   pharmImg,
                //   fit: BoxFit.cover,
                // ),
                ),
            // title: Text(pharmName),
            actions: [
              IconButton(
                icon: Icon(Icons.map),
                onPressed: () {
                  print(pharmLat);
                  Navigator.pushNamed(
                    context,
                    MapScreen.nameRoute,
                    arguments: {
                      'id': pharmId,
                      'nom': pharmName,
                      'responsable': pharmResp,
                      'tel': pharmTel,
                      'lati': pharmLat,
                      'longi': pharmLong,
                    },
                  );
                },
              ),
            ],
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pharmName,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.teal[300],
                          Colors.tealAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                size: 30,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Favoris'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.map,
                                size: 30,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                print(pharmLat);
                                Navigator.pushNamed(
                                  context,
                                  MapScreen.nameRoute,
                                  arguments: {
                                    'id': pharmId,
                                    'nom': pharmName,
                                    'responsable': pharmResp,
                                    'tel': pharmTel,
                                    'lati': pharmLat,
                                    'longi': pharmLong,
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Localisation'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.call,
                                size: 30,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                makeCall('tel://$tel1');
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Appeler'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Responsable',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pharmResp,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget menuSection = Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          IconButton(
            icon: Icon(
              Icons.info,
              size: 30,
            ),
            onPressed: () {},
          ),
          SizedBox(
            height: 8,
          ),
          Text('Favoris'),
        ],
      ),
      Column(
        children: [
          IconButton(
            icon: Icon(
              Icons.map,
              size: 30,
            ),
            onPressed: () {},
          ),
          SizedBox(
            height: 8,
          ),
          Text('Localisation'),
        ],
      ),
      Column(
        children: [
          IconButton(
            icon: Icon(
              Icons.call,
              size: 30,
            ),
            onPressed: () {},
          ),
          SizedBox(
            height: 8,
          ),
          Text('Appeler'),
        ],
      ),
    ],
  ),
);
