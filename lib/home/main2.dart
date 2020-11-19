import 'package:flutter/material.dart';
import 'package:gastos/home/firebase.dart';
import 'package:gastos/home/home0.dart';
import 'package:gastos/home/home1.dart';
import 'package:gastos/home/sing_in.dart' as t;

class Iniciar extends StatefulWidget {
  @override
  _IniciarState createState() => _IniciarState();
}

class _IniciarState extends State<Iniciar> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    FireDatos fire = FireDatos();
    t.signInWithGoogle().whenComplete(() {
      return Scaffold(
        body: t.is_Sing_In
            ? FirstScreen(fire, now.day, now.month, now.year)
            : Home0(),
      );
    });
    // return t.is_Sing_In
    //     ? FirstScreen(fire, now.day, now.month, now.year)
    //     : Home0();
  }
}
