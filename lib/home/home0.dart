import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:gastos/home/agregar.dart';
import 'package:gastos/home/fondoInicial.dart';
import 'package:gastos/home/home1.dart';
import 'package:gastos/home/sing_in.dart' as t;
import 'package:flutter/services.dart' show rootBundle;
import 'package:gastos/home/firebase.dart';

class Home0 extends StatefulWidget {
  @override
  _Home0State createState() => _Home0State();
}

Color green = Colors.lightGreenAccent[700];

class _Home0State extends State<Home0> {
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/config.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                width: 300,
                height: 300,
                child: Image.network(
                    'https://thumbs.dreamstime.com/b/se%C3%B1al-de-ne%C3%B3n-del-bolso-dinero-s%C3%ADmbolo-que-brilla-intensamente-brillante-en-un-fondo-negro-128052593.jpg'),
              ),
              RaisedButton(
                disabledColor: Colors.black,
                child: Text(
                  "Entrar",
                  style: TextStyle(color: Colors.black),
                ),
                splashColor: Colors.black,
                color: green,
                onPressed: () {
                  t.signInWithGoogle().whenComplete(() {
                    if (t.is_Sing_In) {
                      FireDatos fire = FireDatos();
                      fire.autocreacion().whenComplete(() {
                        DateTime now = DateTime.now();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FirstScreen(
                                fire, now.day, now.month, now.year)));
                      });

                      // fire.createCategory('G', 57898, 'Casa', 'no');
                      // fire.createCategory('G', 58833, 'Educación', 'no');
                      // fire.createCategory(
                      //     'G', 58006, 'Entretenimiento y diversión', 'no');
                      // fire.createCategory('G', 57576, 'Higiéne', 'no');
                      // fire.createCategory('G', 58961, 'Ropa y calzado', 'no');
                      // fire.createCategory('G', 58001, 'Salud', 'no');
                      // fire.createCategory('G', 59865, 'Seguros', 'no');
                      // fire.createCategory('G', 58765, 'Transporte', 'no');
                      // fire.createCategory('I', 58312, 'Pensiones', 'no');
                      // fire.createCategory(
                      //     'I', 58074, 'Pensiones alimentarias', 'no');
                      // fire.createCategory('I', 58822, 'Salario', 'no');
                      // fire.createCategory('I', 60895, 'Trabajos extra', 'no');
                      // fire.create_categoria();
                    }
                  });
                },
                onLongPress: () {
                  //t.signOutGoogle();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
