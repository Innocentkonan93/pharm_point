import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

class MapScreen extends StatefulWidget {
  static const nameRoute = '/map-screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final pharmArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final pharmLat = double.parse(pharmArgs['lati']);
    final pharmLong = double.parse(pharmArgs['longi']);
    final pharmId = pharmArgs['id'];
    final pharmName = pharmArgs['nom'];
    final pharmResp = pharmArgs['responsable'];
    final pharmTel = pharmArgs['tel'];

    return new Scaffold(
      appBar: new AppBar(title: new Text('Localisation')),
      body: new FlutterMap(
        options: new MapOptions(
            center: new LatLng(pharmLat, pharmLong), minZoom: 15.0),
        layers: [
          new TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/ohjsamuel/ckgu80kny29771an2xnypsfum/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib2hqc2FtdWVsIiwiYSI6ImNrZ3U3ZzJ5NjBpc3cycnAwczdzNjJudW8ifQ.HRp7aAjEf9lVf3iQm_rj-g",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoib2hqc2FtdWVsIiwiYSI6ImNrZ3U3ZzJ5NjBpc3cycnAwczdzNjJudW8ifQ.HRp7aAjEf9lVf3iQm_rj-g',
              'id': 'mapbox.mapbox-streets-v7'
            },
          ),
          new MarkerLayerOptions(markers: [
            new Marker(
              width: 45.0,
              height: 45.0,
              point: new LatLng(pharmLat, pharmLong),
              builder: (context) => new Container(
                child: IconButton(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (builder) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          height: 200,
                          child: Column(
                            children: [
                              Text(pharmName),
                              SizedBox(
                                height: 20,
                              ),
                              Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Icon(Icons.call),
                                  ),
                                  title: Text(pharmTel),
                                  trailing: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    onPressed: () {
                                      
                                    },
                                    child: Text('Appeler'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ])
        ],
      ),
    );
  }
}
