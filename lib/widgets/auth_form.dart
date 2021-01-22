import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharm_point/screens/accueil/tabs_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';


class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final userNameController = TextEditingController();
  final repSecreteController = TextEditingController();
  final passWordController = TextEditingController();

  String _userName = '';
  String message = '';
  String dataUser;
  int session;

  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _isLoading = false;

  void _trySubmit() {
    //
    FocusScope.of(context).unfocus();

    final isValid = _formkey.currentState.validate();
  }

  String data = '';
  String nameKey = '_key_name';

  Future<bool> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(nameKey, userNameController.text);
  }

  Future<String> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getString(nameKey);
  }

  setData() {
    loadData().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _addUser() {
    var url = "http://bad-event.com/pharma/addUsers.php";
    http.post(url, body: {
      "userName": userNameController.text,
      "repScrete": repSecreteController.text,
      "passWord": passWordController.text,
    });

    setState(() {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text('Inscription réussie'),
            backgroundColor: Colors.green),
      );
      _isLogin = !_isLogin;
    });
  }

  Future<List> _login() async {
    _isLoading = !_isLoading;

    final response =
        await http.post('http://bad-event.com/pharma/loginUsers.php', body: {
      "userName": userNameController.text,
      "passWord": passWordController.text,
    });

    var dataUser = json.decode(response.body);

    if (dataUser.length == 1) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TabsScreen(),
          ),
        );
      });
    } else {
      setState(() {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Connexion échouée'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
    return dataUser;
  }

  // ignore: missing_return
  Future<int> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Username', _userName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  _isLogin ? 'Connexion' : 'Inscription',
                  style: GoogleFonts.exo(
                    fontWeight: FontWeight.w900,
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formkey,
                  child: Center(
                    child: Column(
                      children: [
                        // Container(
                        //   height: 60,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white.withOpacity(0.1),
                        //     borderRadius: BorderRadius.circular(30),
                        //     border: Border.all(
                        //       width: 1,
                        //       color: Colors.black.withOpacity(0.1),
                        //     ),
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         height: 60,
                        //         width: 60,
                        //         decoration: BoxDecoration(
                        //           color: Colors.black.withOpacity(0.1),
                        //           borderRadius: BorderRadius.circular(50),
                        //         ),
                        //         child: Icon(Icons.person),
                        //       ),
                        //       Container(
                        //         width: 230,
                        //         child: Center(
                        //           child: TextFormField(
                        //             controller: userNameController,
                        //             key: ValueKey('userName'),
                        //             validator: (value) {
                        //               if (value.isEmpty || value.length < 4) {
                        //                 return 'Nom trop court';
                        //               }
                        //               return null;
                        //             },
                        //             textAlign: TextAlign.center,
                        //             style: GoogleFonts.comfortaa(
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.black.withOpacity(0.1),
                        //             ),
                        //             decoration: InputDecoration(
                        //               hintText: 'Identifiant',
                        //               hintStyle: TextStyle(
                        //                 color: Colors.white.withOpacity(0.6),
                        //                 fontSize: 16,
                        //               ),
                        //               border: InputBorder.none,
                        //               errorStyle: TextStyle(
                        //                 color: Colors.yellowAccent,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              width: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(Icons.person),
                              ),
                              Container(
                                width: 230,
                                child: Center(
                                  child: TextFormField(
                                    controller: userNameController,
                                    key: ValueKey('userName'),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.comfortaa(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Identifiant:',
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 16,
                                      ),
                                      border: InputBorder.none,
                                      errorStyle: TextStyle(
                                        color: Colors.yellowAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!_isLogin)
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                width: 1,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                            child: Row(
                              children: [
                                
                                Container(
                                  width: 269,
                                  child: Center(
                                    child: TextFormField(
                                      controller: repSecreteController,
                                      key: ValueKey('repSec'),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.comfortaa(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Réponse Sécrète:',
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 16,
                                        ),
                                        border: InputBorder.none,
                                        errorStyle: TextStyle(
                                          color: Colors.yellowAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(Icons.card_giftcard),
                                ),
                              ],
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              width: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(Icons.lock_outlined, size: 30,),
                              ),
                              Container(
                                width: 230,
                                child: Center(
                                  child: TextFormField(
                                    controller: passWordController,
                                    key: ValueKey('userPassWord'),
                                    validator: (value) {
                                      if (value.isEmpty ||
                                          value.length < 5 ||
                                          value.contains('12')) {
                                        return 'Mot de passe trop court';
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.comfortaa(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Mot de passe',
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 16,
                                      ),
                                      border: InputBorder.none,
                                      errorStyle: TextStyle(
                                        color: Colors.yellowAccent,
                                      ),
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // if (!_isLogin)
                        //   DropdownButton(
                        //     isExpanded: true,
                        //     items: _accountType.map((value) {
                        //       return DropdownMenuItem(
                        //         value: value,
                        //         child: Text(value),
                        //       );
                        //     }).toList(),
                        //     value: _selectedType,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         _selectedType = value;
                        //       });
                        //     },
                        //   ),
                        if (_isLoading)
                          Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.white,
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            _isLogin
                                ? 'Connexion'.toUpperCase()
                                : 'Inscription'.toUpperCase(),
                            style: GoogleFonts.exo(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              !_isLogin ? _addUser() : _login();
                              setState(() {
                                userNameController.clear();
                                repSecreteController.clear();
                                passWordController.clear();
                              });
                            }
                          },
                        ),
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            _isLogin ? 'Créer un compte' : 'Déjà un compte ?',
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isLogin)
                  FlatButton(
                    child: Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(color: Colors.yellowAccent),
                    ),
                    onPressed: () {},
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
