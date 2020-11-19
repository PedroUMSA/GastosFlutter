import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:gastos/home/categoria.dart';
import 'package:gastos/home/home1.dart';
// import 'package:gastos/home/sing_in.dart' as t;
import 'package:gastos/home/sub_registro.dart';
// import 'package:intl/intl.dart';
// import 'dart:math';
import 'package:gastos/home/firebase.dart';
// import 'dart:io';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AgregarGIE extends StatefulWidget {
  final String tipo;
  final String nombre;
  final String monto;
  final FireDatos fireDatos;
  final int dia;
  final int mes;
  final int anio;
  // datos de edicion
  final String tipoE;
  final String codE;
  final String tituloE;
  final String descripE;
  final double montoE;
  final int iconE;

  AgregarGIE(
      this.tipo,
      this.nombre,
      this.monto,
      this.fireDatos,
      this.dia,
      this.mes,
      this.anio,
      this.tipoE,
      this.codE,
      this.tituloE,
      this.descripE,
      this.montoE,
      this.iconE);
  @override
  _AgregarGIEState createState() => _AgregarGIEState();
}

// const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
// Random _rnd = Random();
// String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
//     length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class _AgregarGIEState extends State<AgregarGIE> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String ti;
  String nom;
  String mon;
  Color colorred = Color(0xffff0000);
  Color colorgreen = Color(0xff00ff00);
  Color green;
//datos del tiempo

////parametros
  String titulo_seleccion = '';
  int icon_selec;
  String descripcion = ' ';
  double dinero = 0.0;

  //FIN CALENDARIO

  var _quey;
  FireDatos fireDatos;
  double totalIngreso;
  double totalGastos;

  int dia;
  int mes;
  int anio;
  @override
  void initState() {
    (widget.tipo == 'G') ? green = colorred : green = colorgreen;
    ti = this.widget.tipo;
    nom = this.widget.nombre;
    mon = this.widget.monto;
    fireDatos = widget.fireDatos;
    print(
        'PARAMETROS DE EDICION ${widget.tipoE}  ${widget.codE}  ${widget.tituloE}  ${widget.montoE}  ${widget.descripE}');
    titulo_seleccion = widget.tituloE;
    icon_selec = widget.iconE;
    descripcion = widget.descripE;
    dinero = widget.montoE;
    //
    _quey = fireDatos.mostrarCategoria(widget.tipo);
    totalIngreso = fireDatos.totalIngresos;
    totalGastos = fireDatos.totalGastos;

    dia = widget.dia;
    mes = widget.mes;
    anio = widget.anio;

    initializing();
    tz.initializeTimeZones();

    super.initState();
  }

  //notificaciones
  void initializing() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => MyApp()),
    // );
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              //Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MyApp(),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

  void _showNotificationsTime(String tipo) {
    if (tipo == 'I') {
      _tipo_notificacion(
          0, 'No olvides registrar tus Ingresos', Duration(days: 1));
    } else if (tipo == 'G') {
      _tipo_notificacion(
          1, 'No olvides registrar tus Gastos', Duration(days: 1));
    }
    DateTime timeHora = DateTime.now();
    if (timeHora.hour < 22 && timeHora.day < 10) {
      int horaPro = 22 - timeHora.hour;
      int diaPro = 10 - timeHora.day;
      print('MES PROGRAMADO ENTRO         $horaPro          $diaPro');
      _tipo_notificacion(
          2,
          'No olvides registrar tus Ingresos y Gastos mensuales',
          Duration(days: diaPro, hours: horaPro));
    }
  }

  void _tipo_notificacion(int i, String s, Duration duration) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        i,
        'Gastos',
        s,
        tz.TZDateTime.now(tz.local).add(duration),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description',
                priority: Priority.high,
                importance: Importance.max,
                ticker: 'test')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _titulo(ti),
            Text(
              '${dia} - ${mes} - ${anio}',
              style: TextStyle(color: green, fontSize: 20),
            ),
            _seleccion(),
            //_agregar_tipo(),
            _monto(),
            _botones(),
          ],
        ),
      ),
    );
  }

  Container _botones() {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            child: Text('Cancelar'),
            color: green,
            onPressed: () {
              String subtitu = titulo_seleccion;
              descripcion = '';
              titulo_seleccion = '';
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              if (widget.tipoE != '') {
                print(
                    'EDICION DATOS CANCELAR ${subtitu}asd  ${icon_selec} ${widget.tipo} ${widget.dia} ${widget.mes}  ${widget.anio}  ${widget.fireDatos}');

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SubRegistro(
                        widget.tituloE,
                        widget.iconE,
                        widget.tipo,
                        widget.dia,
                        widget.mes,
                        widget.anio,
                        widget.fireDatos)));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FirstScreen(widget.fireDatos,
                        widget.dia, widget.mes, widget.anio)));
              }
            },
          ),
          MaterialButton(
            child: Text('Guardar'),
            color: green,
            onPressed: () {
              if (dinero > 0 && titulo_seleccion != '') {
                // if (widget.tipoE == 'EG') {
                //   totalGastos = totalGastos - widget.montoE;
                // }
                if (totalIngreso >= (totalGastos + dinero - widget.montoE) ||
                    dinero <= widget.montoE ||
                    widget.tipo == 'I' ||
                    widget.tipoE == 'EI') {
                  print('Correcto');
                  _guardarDatos();
                } else {
                  print('Incorrecto');
                  _monto_exedido();
                }
                // String ram = getRandomString(5);

              } else {
                //mensaje de alerta
                print('faltan datos   dinero: $dinero    $titulo_seleccion');
                _showMyDialog();
              }
            },
          ),
        ],
      ),
    );
  }

  //guardar datos
  _guardarDatos() {
    DateTime now = DateTime.now();
    if (descripcion != '') {
      descripcion = descripcion[0].toUpperCase() + descripcion.substring(1);
    }
    dinero = double.parse(dinero.toStringAsFixed(1));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    if (widget.tipoE != '') {
      fireDatos.editarGI(widget.tipo, widget.codE, titulo_seleccion, icon_selec,
          descripcion, dinero);
      String aux = titulo_seleccion;
      descripcion = '';
      titulo_seleccion = '';

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SubRegistro(aux, icon_selec, widget.tipo,
              widget.dia, widget.mes, widget.anio, widget.fireDatos)));
    } else {
      fireDatos.crearteRegistroGI(widget.tipo, now, widget.dia, widget.mes,
          widget.anio, titulo_seleccion, icon_selec, descripcion, dinero);
      descripcion = '';
      titulo_seleccion = '';
      //notificacion
      _showNotificationsTime(widget.tipo);
      //
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FirstScreen(
              this.widget.fireDatos, widget.dia, widget.mes, widget.anio)));
    }
  }

  //
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[800],
          title: Text('Alerta en datos', style: TextStyle(color: green)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Seleccione una categoria o',
                    style: TextStyle(color: green)),
                Text('coloque datos correctos en monto',
                    style: TextStyle(color: green)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: green)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //MONTO EXEDIDO
  Future<void> _monto_exedido() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[800],
          title: Text('Limite de Dinero', style: TextStyle(color: green)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Los gastos superaran a', style: TextStyle(color: green)),
                Text('los ingresos registrados',
                    style: TextStyle(color: green)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancelar',
                style: TextStyle(color: green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar de todas\nformas',
                  style: TextStyle(color: green)),
              onPressed: () {
                Navigator.of(context).pop();
                _guardarDatos();
                //   Navigator.of(context).pop();
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => FirstScreen(
                //           fireDatos, widget.dia, widget.mes, widget.anio)));
                //
              },
            ),
          ],
        );
      },
    );
  }
  //

  Container _monto() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          //monto
          TextFormField(
            onChanged: (String valor) {
              try {
                dinero = double.parse(valor);
                print(valor);
              } catch (e) {
                //mesaje de error
                print(e);
                valor = '';
                dinero = 0;
                print('coloque un numero correcto  $dinero');
              }
            },
            initialValue: (widget.tipoE != '') ? '${widget.montoE}' : '',
            keyboardType: TextInputType.number,
            style: TextStyle(color: green),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: green, width: 3.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              labelText: "Monto",
              labelStyle: TextStyle(color: green),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: green, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          //descripcion
          TextFormField(
            onChanged: (String valor) {
              descripcion = valor;
              print(valor);
            },
            initialValue: (widget.tipoE != '') ? widget.descripE : '',
            keyboardType: TextInputType.text,
            style: TextStyle(color: green),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: green, width: 3.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              labelText: "Descripción",
              labelStyle: TextStyle(color: green),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: green, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget _contarSeleccion(List<QueryDocumentSnapshot> docs) {
  //   Map<String, int> iconselec = docs.fold({}, (Map<String, int> map, element) {
  //     if (!map.containsKey(element['titulo'])) {
  //       map[element['titulo']] = element['icon'];
  //     }
  //     return map;
  //   });
  //   return ListView.builder(
  //     padding: EdgeInsets.all(0.0),
  //     itemCount: iconselec.keys.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       var key = iconselec.keys.elementAt(index);
  //       var icon = iconselec[key];
  //       return _selected(icon, key);
  //     },
  //   );
  // }

  Container _seleccion() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width - 100,
      padding: EdgeInsets.all(6),
      //color: Colors.red,
      decoration: _boxDecoration(20, 3),
      //child: Container(
      //height: 500,
      child: Column(
        children: [
          Text('Categorias', style: TextStyle(color: green, fontSize: 15)),
          Expanded(
            //height: 243,
            child: StreamBuilder(
              //stream: fireDatos.mostrarCategoria(widget.tipo),
              stream: _quey,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return _categoriasf(snapshot.data.docs);
              },
            ),
          )
        ],
      ),
      //)
    );
  }

  Widget _categoriasf(List<QueryDocumentSnapshot> docs) {
    Map<String, int> categorias =
        docs.fold({}, (Map<String, int> map, element) {
      if (!map.containsKey(element['titulo'])) {
        map[element['titulo']] = element['icono'];
      }
      return map;
    });
    try {
      return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: categorias.keys.length,
        itemBuilder: (BuildContext context, int index) {
          var titu = categorias.keys.elementAt(index);
          var icon = categorias[titu];
          return _selected(icon, titu);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // Widget _agregar_tipo() {
  //   return (widget.tipoE != '')
  //       ? Container()
  //       : InkWell(
  //           onTap: () {
  //             //Navigator.of(context).pop();
  //             Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (context) => CategoriaGI(ti, this.widget.fireDatos,
  //                     widget.dia, widget.mes, widget.anio)));
  //           },
  //           child: Container(
  //               width: MediaQuery.of(context).size.width * 0.8,
  //               padding: EdgeInsets.all(5),
  //               decoration: _boxDecoration(20, 3),
  //               alignment: Alignment(0.0, 0.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Icon(
  //                     Icons.add,
  //                     size: 20,
  //                     color: green,
  //                   ),
  //                   Text('Agregar Categoria',
  //                       style: TextStyle(color: green, fontSize: 15))
  //                 ],
  //               )),
  //         );
  // }

  Widget _selected(int i, String titulo) {
    bool b = false;
    if (titulo_seleccion == titulo) {
      b = true;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              setState(() {
                titulo_seleccion = titulo;
                icon_selec = i;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 3),
              padding: EdgeInsets.all(6),
              decoration:
                  b ? _boxDecorationSelected(10, 2) : _boxDecoration(10, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Icon(IconData(i, fontFamily: 'MaterialIcons'),
                        color: b ? Colors.black : green),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        titulo,
                        style: TextStyle(
                            color: b ? Colors.black : green, fontSize: 15),
                        textAlign: TextAlign.justify,
                      )),
                ],
              ),
            )),
      ],
    );
  }

  BoxDecoration _boxDecorationSelected(double d, double a) {
    return BoxDecoration(
        color: green,
        border: Border.all(
          color: green,
          width: a,
        ),
        borderRadius: BorderRadius.all(Radius.circular(d)));
  }

  Container _titulo(String titulo) {
    String enu = 'fallo';
    if (widget.tipoE != '' && widget.codE != '') {
      if (widget.tipoE == 'EG') {
        enu = 'Editar Gasto';
      } else if (widget.tipoE == 'EI') {
        enu = 'Editar Ingreso';
      }
    } else {
      if (titulo == 'G') {
        enu = 'Agregar gasto';
      } else if (titulo == 'I') {
        enu = 'Agregar ingreso';
      } else if (titulo == 'E') {
        enu = 'Editar';
      }
    }

    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - 20,
      child: Center(
        child: Text(
          '$enu',
          style: TextStyle(color: green, fontSize: 40),
        ),
      ),
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
}
