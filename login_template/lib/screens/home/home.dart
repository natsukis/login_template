import 'package:flutter/material.dart';
import 'package:login_template/screens/home/personalinfo.dart';
import 'package:login_template/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showInfoPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SingleChildScrollView(
                          child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: PersonalInfo(),
              ),
            );
          });
    }

    return 
    //StreamProvider<List<Brew>>.value(
     // value: DatabaseService().brews,
     // child: 
      Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: Text('Coffe Time'),
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Logout')),
              FlatButton.icon(
                  onPressed: () {
                    _showInfoPanel();
                  },
                  icon: Icon(Icons.settings),
                  label: Text('Mis Datos')),
            ],
          ),
          body: Container(               
          //    child: BrewList()
          ),
    );
  }
}
