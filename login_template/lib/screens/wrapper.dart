import 'package:flutter/material.dart';
import 'package:login_template/model/user.dart';
import 'package:login_template/screens/authenticate/authenticate.dart';
import 'package:login_template/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either home or authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
