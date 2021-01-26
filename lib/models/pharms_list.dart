import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharm_point/models/pharms.dart';
import 'package:pharm_point/models/services.dart';
import 'package:pharm_point/screens/Pharm/pharm_details_screen.dart';

class PharmsList extends StatefulWidget {
  static const routeName = '/pharms-list';
  final String id;
  PharmsList({this.id});
  @override
  _PharmsListState createState() => _PharmsListState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _PharmsListState extends State<PharmsList> {
  final _debouncer = Debouncer(milliseconds: 500);
  var isLoaded = false;
  String id;
  List<Pharms> pharms = [];
  List<Pharms> filteredPharms = [];
  List<Pharms> pharmList = [];

  @override
  void initState() {
    super.initState();
    AllPharms.getPharms().then((pharmsFromServer) {
      setState(() {
        pharms = pharmsFromServer;
        filteredPharms = pharms;
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final villeData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final villeId = villeData['id'];
    final villeNom = villeData['nom'];
    return Scaffold(
      appBar: AppBar(
        title: Text(villeNom.toString().toUpperCase()),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: isLoaded
            ? ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredPharms
                        .where((element) => element.idVille == villeId)
                        .length +
                    1,
                itemBuilder: (BuildContext context, int index) {
                  pharmList = filteredPharms
                      .where((element) => element.idVille == villeId)
                      .toList();
                  return index == 0 ? _searchBar() : _listItem(index - 1);
                },
              )
            : Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
      ),
    );
  }

  _searchBar() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Recherchez',
            hintStyle: TextStyle(color: Colors.white),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search)),
        onChanged: (string) {
          _debouncer.run(() {
            setState(() {
              pharmList = pharms
                  .where(
                    (element) => element.nom
                        .toLowerCase()
                        .contains(string.toLowerCase()),
                  )
                  .toList();
            });
          });
        },
      ),
    );
  }

  _listItem(index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PharmDetailsScreen.routeName, arguments: {
          'id': pharmList[index].id,
          'nom': pharmList[index].nom,
          'responsable': pharmList[index].responsable,
          'longi': pharmList[index].longi,
          'lati': pharmList[index].lati,
          'image': pharmList[index].image,
          'tel': pharmList[index].tel,
        });
        print(pharmList[index].id);
      },
      child: Card(
        child: Container(
          height: 80,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                pharmList[index].nom,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
