import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pharm_point/models/pharms.dart';
import 'package:pharm_point/models/services.dart';


class PharmsList extends StatefulWidget {
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

  List<Pharms> pharms = List();
  List<Pharms> filteredPharms = List();

  @override
  void initState() {
    super.initState();
    AllPharms.getPharms().then((usersFromServer) {
      setState(() {
        pharms = usersFromServer;
        filteredPharms = pharms;
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
                    filteredPharms = pharms
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
                itemCount: filteredPharms
                    .where((element) => element.id == widget.id)
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            filteredPharms[index].nom,
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
