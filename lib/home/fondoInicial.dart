import 'package:flutter/material.dart';
import 'package:gastos/home/firebase.dart';

class FondoInicial extends StatefulWidget {
  @override
  _FondoInicialState createState() => _FondoInicialState();
}

Color green = Colors.lightGreenAccent[700];

class _FondoInicialState extends State<FondoInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          color: Colors.red,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
          child: Column(
            children: [
              Icon(
                Icons.ac_unit_outlined,
                color: green,
              ),
              Icon(Icons.ac_unit_outlined),
              Icon(Icons.ac_unit_outlined),
              Icon(Icons.ac_unit_outlined),
            ],
          ),
        ));
  }
}
