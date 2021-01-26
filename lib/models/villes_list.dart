import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharm_point/models/pharms.dart';
import 'package:pharm_point/models/pharms_list.dart';
import 'package:pharm_point/models/services.dart';
import 'package:pharm_point/models/villes.dart';
import 'package:pharm_point/screens/Pharm/pharm_screen.dart';

class VilleList extends StatefulWidget {
  @override
  _VilleListState createState() => _VilleListState();
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

class _VilleListState extends State<VilleList> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);
  var isLoaded = false;

  List<Villes> ville = [];
  List<Villes> filteredVille = [];
  List<Pharms> pharmsList = [];

  @override
  void initState() {
    super.initState();
    AllVilles.getVilless().then((usersFromServer) {
      setState(() {
        ville = usersFromServer;
        filteredVille = ville;
        isLoaded = true;
      });
    });
    AllPharms.getPharms().then((pharmsFromServer) {
      setState(() {
        pharmsList = pharmsFromServer;
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacies'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: isLoaded
            ? ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredVille.length + 1,
                itemBuilder: (BuildContext context, int index) {
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
        color: Colors.orangeAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Recherchez...',
          hintStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: (string) {
          _debouncer.run(() {
            setState(() {
              filteredVille = ville
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
    final pharmsListById = pharmsList
        .where((element) => element.idVille == filteredVille[index].id)
        .toList();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PharmsList.routeName,
          arguments: {
            'id': filteredVille[index].id,
            'nom': filteredVille[index].nom,
          },
        );
        print(filteredVille[index].id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          child: Container(
            height: 250,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'http://bad-event.com/pharma/pharmImg/${filteredVille[index].image}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Positioned(
                        bottom: -25,
                        left: MediaQuery.of(context).size.width * 0.38,
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 25,
                            )),
                      ),
                      Align(
                        child: Positioned(
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              filteredVille[index].nom.toUpperCase(),
                              style: TextStyle(
                                fontSize: 36.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       filteredVille[index].nom.toUpperCase(),
                      //       style: TextStyle(
                      //         fontSize: 20.0,
                      //         fontWeight: FontWeight.w400,
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                pharmsListById.length.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                pharmsListById.length == 0
                                    ? 'Pharmacie'
                                    : 'Pharmacies',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
