import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pharm_point/widgets/auth_form.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.teal[100],
                Colors.teal[300],
                Colors.teal[700],
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              SlideInDown(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 185,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Image.asset('assets/images/icon.png'),
                  ),
                ),
              ),
              SlideInDown(child: AuthForm()),
            ],
          ),
        ),
      ),
    );
  }
}
