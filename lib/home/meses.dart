import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gastos/home/firebase.dart';

class Meses extends StatefulWidget {
  final int anio;
  Meses(this.anio);
  @override
  _MesesState createState() => _MesesState();
}

Color colorred = Color(0xffff0000);
Color colorgreen = Color(0xff00ff00);
Color green = colorgreen;

class _MesesState extends State<Meses> {
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
            Text(
              '${widget.anio}',
              style: TextStyle(color: colorgreen, fontSize: 40),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: fireDatos.mensual(widget.anio),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
                  if (data.hasData) {
                    return _mesesmonto(data.data.docs);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }

  BoxDecoration _boxDecoration(double d, double a) {
    return BoxDecoration(
        border: Border.all(
          color: green,
          width: a,
        ),
        borderRadius: BorderRadius.all(Radius.circular(d)));
  }

  Widget _mesesmonto(List<QueryDocumentSnapshot> docs) {
    Map<String, double> mesesR =
        docs.fold({}, (Map<String, double> map, element) {
      print('lista   ${element['anio']}');
      if (!map.containsKey(element['mes'])) {
        map[element['mes']] = 0;
      }
      if (element['tipo'] == 'I') {
        map[element['mes']] += element['monto'];
      } else {
        map[element['mes']] -= element['monto'];
      }
      return map;
    });
    Map<String, double> mesI =
        docs.fold({}, (Map<String, double> map, element) {
      if (!map.containsKey(element['mes'])) {
        map[element['mes']] = 0;
      }
      if (element['tipo'] == 'I') {
        map[element['mes']] += element['monto'];
      }
      return map;
    });
    Map<String, double> mesG =
        docs.fold({}, (Map<String, double> map, element) {
      if (!map.containsKey(element['mes'])) {
        map[element['mes']] = 0;
      }
      if (element['tipo'] == 'G') {
        map[element['mes']] += element['monto'];
      }
      return map;
    });
    print('//////////////////////////////////////////');
    print('${mesesR.keys.length}      mes  ${mesesR}');
    print('${mesI.keys.length}      ingreso  ${mesI}');
    print('${mesG.keys.length}      gasto  ${mesG}');
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: mesesR.keys.length,
      itemBuilder: (BuildContext context, int index) {
        var mesactual = mesesR.keys.elementAt(index);
        var balance = mesesR[mesactual];
        var ingreso = mesI[mesactual];
        var gasto = mesG[mesactual];
        print(
            '*******************  mesacutal $mesactual  balance: $balance  ingreso :$ingreso  gato:$gasto');
        return _meses(mesactual, ingreso, gasto, balance);
      },
    );
  }

  Widget _meses(
      String mesactual, double ingreso, double gasto, double balance) {
    String fecha = '';
    switch (mesactual) {
      case '01':
        fecha = 'Enero';
        break;
      case '02':
        fecha = 'Febrero';
        break;
      case '03':
        fecha = 'Marzo';
        break;
      case '04':
        fecha = 'Abril';
        break;
      case '05':
        fecha = 'Mayo';
        break;
      case '06':
        fecha = 'Junio';
        break;
      case '07':
        fecha = 'Julio';
        break;
      case '08':
        fecha = 'Agosto';
        break;
      case '09':
        fecha = 'Septiembre';
        break;
      case '10':
        fecha = 'Octubre';
        break;
      case '11':
        fecha = 'Noviembre';
        break;
      case '12':
        fecha = 'Diciembre';
        break;
      default:
    }
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20),
      decoration: _boxDecoration(20, 3),
      //height: MediaQuery.of(context).size.height * 0.17,
      child: Column(
        children: [
          Text(
            '$fecha',
            style: TextStyle(color: green, fontSize: 25),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: _boxDecoration(10, 2),
            width: MediaQuery.of(context).size.width - 40,
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
        ],
      ),
    );
  }
}
