import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gastos/home/agregar.dart';
import 'package:gastos/home/categoria.dart';
import 'package:gastos/home/firebase.dart';
import 'package:gastos/home/home1.dart';

class SubRegistro extends StatefulWidget {
  final String titulo;
  final int icon;
  final String tipo; //G o I
  final int dia;
  final int mes;
  final int anio;
  final FireDatos fireDatos;
  SubRegistro(this.titulo, this.icon, this.tipo, this.dia, this.mes, this.anio,
      this.fireDatos);

  @override
  _SubRegistroState createState() => _SubRegistroState();
}

class _SubRegistroState extends State<SubRegistro> {
  Color colorred = Color(0xffff0000);
  Color colorgreen = Color(0xff00ff00);
  Color green;
  IconData i = Icons.ac_unit;
  String titu = '';

  @override
  void initState() {
    (widget.tipo == 'G') ? green = colorred : green = colorgreen;
    titu = this.widget.titulo;
    i = IconData(this.widget.icon, fontFamily: 'MaterialIcons');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _body(),
    );
  }

  _body() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _head(i, titu),
          _registros(),
        ],
      ),
    );
  }

  Container _registros() {
    return Container(
      decoration: _boxDecoration(15, 4),
      width: MediaQuery.of(context).size.width - 20,
      padding: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height - 200,
      child: StreamBuilder<QuerySnapshot>(
        stream: widget.fireDatos
            .sub_registros(widget.tipo, widget.mes, widget.anio, widget.titulo),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
          if (data.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: data.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return _datos(
                    data.data.docChanges[index].doc['decripcion'],
                    data.data.docChanges[index].doc['monto'],
                    data.data.docChanges[index].doc['cod'],
                    data.data.docChanges[index].doc['dia'],
                    data.data.docChanges[index].doc['mes'],
                    data.data.docChanges[index].doc['anio']);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Container _datos(String des, double monto, String id, String diae,
      String mese, int anioe) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.6 + 25,
                  child: Text('$diae/$mese/$anioe',
                      style: TextStyle(color: green, fontSize: 15))),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.all(5),
                decoration: _boxDecoration(8, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(des,
                            textAlign: TextAlign.justify,
                            style: TextStyle(color: green, fontSize: 20))),
                    Text('$monto Bs ',
                        style: TextStyle(color: green, fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
          //iconos de editar y eliminar
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Icon(Icons.edit, color: green, size: 25),
                onTap: () {
                  print('editar ${des}');
                  //Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AgregarGIE(
                          widget.tipo,
                          '',
                          '',
                          widget.fireDatos,
                          int.parse(diae),
                          int.parse(mese),
                          anioe,
                          'E${widget.tipo}',
                          id,
                          widget.titulo,
                          des,
                          monto,
                          widget.icon)));
                },
              ),
              SizedBox(width: 15),
              InkWell(
                child: Icon(Icons.delete, color: green, size: 25),
                onLongPress: () {
                  setState(() {
                    print('eliminar  ${des}');
                    widget.fireDatos.eliminar(widget.tipo, id);
                  });
                },
              )
            ],
          )
        ],
      ),
      decoration: _boxDecoration(10, 3),
    );
  }

  BoxDecoration _boxDecoration(double radius, double margen) {
    return BoxDecoration(
        border: Border.all(
          color: green,
          width: margen,
        ),
        borderRadius: BorderRadius.all(Radius.circular(radius)));
  }

  Widget _head(IconData i, String titulo) {
    return Container(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.75,
                child:
                    Text(titulo, style: TextStyle(color: green, fontSize: 30))),
            Icon(i, color: green, size: 80),
          ],
        ));
    @override
    void onBackPressed() {
      print('hola mundo estamos saliendo de la aplicacion');
    }
  }
}
