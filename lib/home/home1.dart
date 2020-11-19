import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastos/home/agregar.dart';
import 'package:gastos/home/anual.dart';
import 'package:gastos/home/categoria.dart';
import 'package:gastos/home/firebase.dart';
import 'package:gastos/home/fondoInicial.dart';
import 'package:gastos/home/home0.dart';
import 'package:gastos/home/sing_in.dart' as t;
import 'package:gastos/home/sub_registro.dart';
import 'package:gastos/home/firebase.dart';
import 'package:gastos/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class FirstScreen extends StatefulWidget {
  final FireDatos fireDatos;
  final int dia;
  final int mes;
  final int anio;
  FirstScreen(this.fireDatos, this.dia, this.mes, this.anio);
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

//variables
int dia;
int mes;
int anio;
FireDatos fireDatos;

///
bool tipo = false;
var fecha = '';
var cod;
Color colorred = Color(0xffff0000);
Color colorgreen = Color(0xff00ff00);
Color green = colorgreen;
bool fondoini = false;

class _FirstScreenState extends State<FirstScreen> {
  //
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // AndroidInitializationSettings _androidInitializationSettings;
  // IOSInitializationSettings _iosInitializationSettings;
  // InitializationSettings _initializationSettings;

  //

  //
  DateTime d = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    DateTime pick = await showDatePicker(
      context: context,
      initialDate: d,
      firstDate: DateTime(anio - 2),
      lastDate: DateTime(anio + 4),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            brightness: Brightness.dark,
            primaryColor: green,
            accentColor: green,
            colorScheme: ColorScheme.highContrastDark(
                primary: tipo ? Color(0xffff0000) : Color(0xff1bff22),
                surface: const Color(0xff121212),
                background: const Color(0xff121212),
                onPrimary: Colors.black,
                onSecondary: Colors.black,
                onSurface: green,
                onBackground: green,
                onError: Colors.black,
                brightness: Brightness.dark),
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
          ),
          child: child,
        );
      },
    );
    if (pick != null && pick != d) {
      print('Fecha seleccionada :${d.toString()}');
      setState(() {
        if (d.month != pick.month || d.year != pick.year) {
          tipo = false;
          tipo ? green = colorred : green = colorgreen;
        }
        dia = pick.day;
        mes = pick.month;
        anio = pick.year;
        d = pick;
      });
    }
  }

  @override
  void initState() {
    dia = widget.dia;
    mes = widget.mes;
    anio = widget.anio;
    fireDatos = this.widget.fireDatos;
    // initializing();
    // tz.initializeTimeZones();
    super.initState();
  }

  //notificaciones
//   void initializing() async {
//     // _androidInitializationSettings = AndroidInitializationSettings('app_icon');
//     // _iosInitializationSettings = IOSInitializationSettings(
//     //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     // _initializationSettings = InitializationSettings(
//     //     android: _androidInitializationSettings,
//     //     iOS: _iosInitializationSettings);
//     // await flutterLocalNotificationsPlugin.initialize(_initializationSettings,
//     //     onSelectNotification: onSelectNotification);

// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//             onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     final MacOSInitializationSettings initializationSettingsMacOS =
//         MacOSInitializationSettings();
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsIOS,
//             macOS: initializationSettingsMacOS);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: selectNotification);
//   }

  // Future selectNotification(String payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  //   // await Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute<void>(builder: (context) => MyApp()),
  //   // );
  // }

  // void _showNotificationsTime() async {
  //   await flutterLocalNotificationsPlugin.cancelAll();
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       1,
  //       'Gastos',
  //       'No olvides registrar tus Ingresos y Gastos',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails('your channel id',
  //               'your channel name', 'your channel description')),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  // Future<void> notification() async {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'channelId',
  //     'channelName',
  //     'channelDescription',
  //     priority: Priority.high,
  //     importance: Importance.max,
  //     ticker: 'test',
  //   );
  //   IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
  //   NotificationDetails details = NotificationDetails(
  //       android: androidNotificationDetails, iOS: iosNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'hello there', 'notificacion', details);
  // }

  // Future<void> notificationTime() async {
  //   var time = DateTime.now().add(Duration(minutes: 1));
  //   AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'channelId',
  //     'channelName',
  //     'channelDescription',
  //     priority: Priority.high,
  //     importance: Importance.max,
  //     ticker: 'test',
  //   );
  //   IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
  //   NotificationDetails details = NotificationDetails(
  //       android: androidNotificationDetails, iOS: iosNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'hello there', 'notificacion', details);
  // }

  // Future onSelectNotification(String payload) {
  //   if (payload != null) {
  //     print(payload);
  //   }
  // }

  // Future onDidReceiveLocalNotification(
  //     int id, String title, String body, String payload) async {
  //   return CupertinoAlertDialog(
  //     title: Text(title),
  //     content: Text(body),
  //     actions: [
  //       CupertinoDialogAction(
  //         child: Text('ok google'),
  //         isDefaultAction: true,
  //         onPressed: () {
  //           print('hola mundo');
  //         },
  //       ),
  //     ],
  //   );
  // }
  // Future onDidReceiveLocalNotification(
  //     int id, String title, String body, String payload) async {
  //   // display a dialog with the notification details, tap ok to go to another page
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: Text(title),
  //       content: Text(body),
  //       actions: [
  //         CupertinoDialogAction(
  //           isDefaultAction: true,
  //           child: Text('Ok'),
  //           onPressed: () async {
  //             //Navigator.of(context, rootNavigator: true).pop();
  //             // await Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //     builder: (context) => MyApp(),
  //             //   ),
  //             // );
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
  //fin notificaciones

  @override
  Widget build(BuildContext context) {
    // String diaL = DateFormat('EEEE').format(now); //dia en ingles
    //tipo ? green = colorgreen : colorred;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _body(),
      // bottomNavigationBar: BottomAppBar(
      //   notchMargin: 8.0,
      //   shape: CircularNotchedRectangle(),
      //   child: Row(
      //     //mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Icon(
      //         Icons.ac_unit,
      //         color: green,
      //         size: 50,
      //       ),
      //       Icon(Icons.ac_unit, color: green),
      //       Icon(Icons.ac_unit, color: green),
      //       Icon(Icons.ac_unit, color: green),
      //     ],
      //   ),
      // ),
      floatingActionButton: _getFAB(),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.transparent,
      //   child: _getFAB(),
      // ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _getFAB() {
    return SpeedDial(
      overlayColor: Colors.black,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22, color: Colors.black),
      backgroundColor: green,
      visible: true,
      curve: Curves.bounceIn,
      onOpen: () {
        print('SE PRESIONO CATEGORIA');

        // _showNotificationsTime();
        // if (fondoini) {
        //   Navigator.of(context)
        //       .push(MaterialPageRoute(builder: (context) => FondoInicial()));
        // }
      },
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(Icons.monetization_on_outlined, color: Colors.black),
            backgroundColor: green,
            onTap: () {
              print('adiconar IG');
              // _read();
              //Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AgregarGIE(
                      tipo ? 'G' : 'I',
                      '',
                      '',
                      /*this.widget.*/ fireDatos,
                      dia,
                      mes,
                      anio,
                      '',
                      '',
                      '',
                      '',
                      0,
                      0)));
            },
            label: tipo ? 'Adicionar gasto' : 'Adicionar ingreso',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16.0),
            labelBackgroundColor: green),
        // FAB 2
        SpeedDialChild(
            child: Icon(Icons.list_alt, color: Colors.black),
            backgroundColor: green,
            onTap: () {
              print('adicionar categoria GI');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoriaGI(
                      tipo ? 'G' : 'I',
                      /*this.widget.*/ fireDatos,
                      dia,
                      mes,
                      anio)));
            },
            label: tipo
                ? 'Añadir categoria de gastos'
                : 'Añadir categoria de ingresos',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16.0),
            labelBackgroundColor: green)
      ],
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _header(),
            _fechaAndTotal(),
            _registros(),
            SizedBox(height: 5),
            InkWell(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width / 2,
                decoration: _boxDecoration(50, 2),
                alignment: Alignment.center,
                child: Text(
                  'Montos Anuales',
                  style: TextStyle(color: green),
                ),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FondoAnual())),
            )
            //_singOut(),
          ],
        ),
      ),
    );
  }

  Container _registros() {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height * 0.67,
      decoration: _boxDecoration(18, 5),
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          //desplegar los registros
          Text(t.usuario.displayName,
              style: TextStyle(color: green, fontSize: 20)),
          Expanded(
            //container
            //height: 100,
            //width: MediaQuery.of(context).size.width - 50,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  fireDatos.queryTotal(tipo ? 'G' : 'I', t.usuario, mes, anio),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
                if (data.hasData) {
                  return _categoriacon_total(data.data.docs);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _categoriacon_total(List<QueryDocumentSnapshot> docs) {
    Map<String, double> categorias =
        docs.fold({}, (Map<String, double> map, element) {
      if (!map.containsKey(element['titulo'])) {
        map[element['titulo']] = 0.0;
      }
      map[element['titulo']] += element['monto'];
      return map;
    });
    Map<String, int> categoriasIcon =
        docs.fold({}, (Map<String, int> map, element) {
      if (!map.containsKey(element['titulo'])) {
        map[element['titulo']] = element['icon'];
      }
      return map;
    });
    print(categorias);
    print(categoriasIcon);

    try {
      return ListView.builder(
        padding: EdgeInsets.all(0.0),
        itemCount: categorias.keys.length,
        itemBuilder: (BuildContext context, int index) {
          var key = categorias.keys.elementAt(index);
          var data = categorias[key];
          var dataicon = categoriasIcon[key];
          return _reg_ing_gas(key, dataicon, data);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Widget _reg_ing_gas(String titulo2, int i, double total) {
    if (titulo2 == 'Fondo inicial') {
      setState(() {
        fondoini = true;
      });
    }
    return InkWell(
        //enviar los datos del sub grupo
        onTap: () {
          print(titulo2);
          // Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SubRegistro(
                  titulo2, i, tipo ? 'G' : 'I', dia, mes, anio, fireDatos)));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          height: 50,
          width: MediaQuery.of(context).size.width - 32,
          decoration: _boxDecoration(10, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Icon(IconData(i, fontFamily: 'MaterialIcons'),
                      color: green, size: 30),
                  SizedBox(width: 10),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(titulo2,
                          style: TextStyle(color: green, fontSize: 15)))
                ],
              ),
              Text(
                '${total} Bs ',
                style: TextStyle(color: green, fontSize: 20),
              )
            ],
          ),
        ));
  }

  Container _fechaAndTotal() {
    switch (mes) {
      case 1:
        fecha = '${dia} Enero ${anio}';
        break;
      case 2:
        fecha = '${dia} Febrero ${anio}';
        break;
      case 3:
        fecha = '${dia} Marzo ${anio}';
        break;
      case 4:
        fecha = '${dia} Abril ${anio}';
        break;
      case 5:
        fecha = '${dia} Mayo ${anio}';
        break;
      case 6:
        fecha = '${dia} Junio ${anio}';
        break;
      case 7:
        fecha = '${dia} Julio ${anio}';
        break;
      case 8:
        fecha = '${dia} Agosto ${anio}';
        break;
      case 9:
        fecha = '${dia} Septiembre ${anio}';
        break;
      case 10:
        fecha = '${dia} Octubre ${anio}';
        break;
      case 11:
        fecha = '${dia} Noviembre ${anio}';
        break;
      case 12:
        fecha = '${dia} Diciembre ${anio}';
        break;
      default:
    }
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: StreamBuilder<QuerySnapshot>(
            stream:
                fireDatos.queryTotal(tipo ? 'G' : 'I', t.usuario, mes, anio),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
              if (data.hasData) {
                return _totalMoney(data.data.docs);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
          _total()
        ],
      ),
    );
  }

  Widget _totalMoney(List<QueryDocumentSnapshot> docs) {
    double montoTotal = docs
        .map((e) => e['monto'])
        .fold(0.0, (previousValue, element) => previousValue + element);
    if (tipo) {
      fireDatos.totalGastos = montoTotal;
      print("TOTAL GASTOS");
      print(fireDatos.totalGastos);
    } else {
      fireDatos.totalIngresos = montoTotal;
      print('TOTAL INGRESOS');
      print(fireDatos.totalIngresos);
    }
    return Container(
        child: Column(
      children: [
        Text('$montoTotal Bs', style: TextStyle(color: green, fontSize: 35)),
        Text(
          'Total ${tipo ? 'Gastos' : 'Ingresos'}',
          style: TextStyle(color: green, fontSize: 10),
        )
      ],
    ));
  }

  Widget _total() {
    return Container(
        padding: EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child:
                  Icon(Icons.calendar_today_outlined, color: green, size: 40),
              onTap: () {
                //ir a calendario
                _selectDate(context);
                print('calendario XD');
              },
            ),
            Text(fecha, style: TextStyle(color: green, fontSize: 20)),
            InkWell(
              child: Icon(
                Icons.logout,
                color: green,
                size: 40,
              ),
              onTap: () {
                print('cerrar secion');
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('Home0');
                t.signOutUser();
                tipo = false;
                tipo ? green = colorred : green = colorgreen;
                // Navigator.of(context).pop();
                // Navigator.of(context).pushNamed('Home0');
              },
            ),
          ],
        ));
  }

  Widget _header() {
    return Container(
      child: _ingreso_gasto(),
      width: MediaQuery.of(context).size.width - 20,
      height: 60,
      decoration: _boxDecoration(20, 3),
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

  BoxDecoration _boxDecorationSelected(double d, double a) {
    return BoxDecoration(
        color: green,
        border: Border.all(
          color: green,
          width: a,
        ),
        borderRadius: BorderRadius.all(Radius.circular(d)));
  }

  Row _ingreso_gasto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_inkWell('Ingresos', !tipo), _inkWell('Gastos', tipo)],
    );
  }

  InkWell _inkWell(String ig, bool b) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        height: 50,
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: b ? _boxDecorationSelected(15, 3) : BoxDecoration(),
        child: Center(
          child: Text(
            ig,
            style: TextStyle(
                color: b ? Colors.black : green, fontSize: b ? 25 : 15),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          print('ingresos XD************');
          tipo = !tipo;
          tipo ? green = colorred : green = colorgreen;
        });
      },
    );
  }
}
