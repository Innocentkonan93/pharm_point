import 'package:flutter/material.dart';
import 'package:pharm_point/models/pharms.dart';
import 'package:pharm_point/models/services.dart';

class PharmsScreen extends StatefulWidget {
  @override
  _PharmsScreenState createState() => _PharmsScreenState();
}

class _PharmsScreenState extends State<PharmsScreen> {
  List<Pharms> pharmList = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    AllPharms.getPharms().then((pharmsFromServer) {
      setState(() {
        pharmList = pharmsFromServer;

        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
