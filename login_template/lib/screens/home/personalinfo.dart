import 'package:flutter/material.dart';
import 'package:login_template/model/user.dart';
import 'package:login_template/model/userdata.dart';
import 'package:login_template/services/constant.dart';
import 'package:login_template/services/database.dart';
import 'package:login_template/services/loading.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {

  final _formkey = GlobalKey<FormState>();

  String _email;
  String _name;
  String _lastName;
  String _mobile;
  String _address;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            
            UserData userData = snapshot.data;

            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Actualice sus datos personales.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: userData.email,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a email' : null,
                    onChanged: (val) => setState(() => _email = val),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Ingrese un nombre' : null,
                    onChanged: (val) => setState(() => _name = val),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: userData.lastName,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Ingrese un apellido' : null,
                    onChanged: (val) => setState(() => _lastName = val),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: userData.mobile,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Ingrese numero telefono' : null,
                    onChanged: (val) => setState(() => _mobile = val),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: userData.address,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Ingrese direccion' : null,
                    onChanged: (val) => setState(() => _address = val),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Actualizar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formkey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                          _email ?? userData.email, 
                          _name ?? userData.name, 
                          _lastName ?? userData.lastName,
                          _mobile ?? userData.mobile,
                          _address ?? userData.address
                          );
                          Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
