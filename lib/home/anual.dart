import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gastos/home/firebase.dart';
import 'package:gastos/home/meses.dart';
import 'package:gastos/home/sing_in.dart' as user;

class FondoAnual extends StatefulWidget {
  @override
  _FondoAnualState createState() => _FondoAnualState();
}

Color colorred = Color(0xffff0000);
Color colorgreen = Color(0xff00ff00);
Color green = colorgreen;

class _FondoAnualState extends State<FondoAnual> {
  FireDatos fireDatos = FireDatos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 35),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            _anual(),
          ],
        ));
  }

  Widget _anual() {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
      stream: fireDatos.anual(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
        if (data.hasData) {
          return _total(data.data.docs);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Widget _total(List<QueryDocumentSnapshot> docs) {
    Map<int, double> aniosList = docs.fold({}, (Map<int, double> map, element) {
      print('lista   ${element['anio']}');
      if (!map.containsKey(element['anio'])) {
        map[element['anio']] = 0;
      }
      if (element['tipo'] == 'I') {
        map[element['anio']] += element['monto'];
      } else {
        map[element['anio']] -= element['monto'];
      }
      return map;
    });
    print('////////////////ANIOS ${aniosList.keys.length}');
    Map<int, double> ingresosList =
        docs.fold({}, (Map<int, double> map, element) {
      if (!map.containsKey(element['anio'])) {
        map[element['anio']] = 0;
      }
      if (element['tipo'] == 'I') {
        map[element['anio']] += element['monto'];
      }
      return map;
    });
    Map<int, double> gastosList =
        docs.fold({}, (Map<int, double> map, element) {
      if (!map.containsKey(element['anio'])) {
        map[element['anio']] = 0;
      }
      if (element['tipo'] == 'G') {
        map[element['anio']] += element['monto'];
      }
      return map;
    });
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: aniosList.keys.length,
      itemBuilder: (BuildContext context, int index) {
        var anio = aniosList.keys.elementAt(index);
        var balance = aniosList[anio];
        var ingreso = ingresosList[anio];
        var gasto = gastosList[anio];
        return _meses(anio, ingreso, gasto, balance);
      },
    );
  }

  BoxDecoration _boxDecoration(double d, double a) {
    return BoxDecoration(
        border: Border.all(
          color: green,
          width: a,
        ),
        borderRadius: BorderRadius.all(Radius.circular(d)));
  }

  Widget _meses(int i, double ingreso, double gasto, double balance) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: _boxDecoration(20, 3),
      // height: MediaQuery.of(context).size.height * 0.22,
      child: Column(
        children: [
          Text(
            '$i',
            style: TextStyle(color: green, fontSize: 30),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: _boxDecoration(10, 2),
            padding: EdgeInsets.all(10),
            // width: MediaQuery.of(context).size.width - 40,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ingresos',
                          style: TextStyle(color: green, fontSize: 20)),
                      Text('$ingreso Bs',
                          style: TextStyle(color: green, fontSize: 20))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gastos',
                          style: TextStyle(color: colorred, fontSize: 20)),
                      Text('$gasto Bs',
                          style: TextStyle(color: colorred, fontSize: 20))
                    ],
                  ),
                ),
                Container(
                  color: colorgreen,
                  height: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Balance',
                          style: TextStyle(color: green, fontSize: 20)),
                      Text('$balance Bs',
                          style: TextStyle(color: green, fontSize: 20))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 30,
                    decoration: _boxDecoration(20, 2),
                    child: Text(
                      'Detalle',
                      style: TextStyle(color: colorgreen),
                    ),
                  ),
                  onTap: () {
                    print('detalle');
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Meses(i)));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
