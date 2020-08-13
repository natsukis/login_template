import 'package:flutter/material.dart';
import 'package:login_template/model/user.dart';
import 'package:login_template/screens/wrapper.dart';
import 'package:login_template/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
        ));
  }
}
