import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharm_point/models/pharms_list.dart';
import 'package:pharm_point/models/services.dart';
import 'package:pharm_point/models/villes.dart';

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
  final _debouncer = Debouncer(milliseconds: 500);

  List<Villes> ville = List();
  List<Villes> filteredVille = List();

  @override
  void initState() {
    super.initState();
    AllVilles.getVilless().then((usersFromServer) {
      setState(() {
        ville = usersFromServer;
        filteredVille = ville;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Recherchez',
                contentPadding: EdgeInsets.all(20),
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
            Container(
              height: 500,
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredVille.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PharmsList(id: filteredVille[index].id);
                      }));
                    },
                    child: Card(
                      
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              filteredVille[index].nom,
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
