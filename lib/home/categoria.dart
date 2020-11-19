import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gastos/home/firebase.dart';
import 'package:gastos/home/home1.dart';
import 'package:gastos/home/sing_in.dart' as sing;
//import 'package:gastos/home/sing_in.dart' as t;

import 'agregar.dart';

class CategoriaGI extends StatefulWidget {
  final String tipo;
  final FireDatos fireDatos;
  final int dia;
  final int mes;
  final int anio;
  CategoriaGI(this.tipo, this.fireDatos, this.dia, this.mes, this.anio);
  @override
  _CategoriaGIState createState() => _CategoriaGIState();
}

class _CategoriaGIState extends State<CategoriaGI> {
  Color colorred = Color(0xffff0000);
  Color colorgreen = Color(0xff00ff00);
  Color green;
//parametros de entrada
  String tipoGI;
//parametros al agregar
  String descrip = '';
  IconData iconSelected;
  //FireDatos fireDatos = FireDatos();
  FireDatos fireDatos;
  //var _quey;
  @override
  void initState() {
    (widget.tipo == 'G') ? green = colorred : green = colorgreen;
    fireDatos = widget.fireDatos;
    iconSelected = Icons.error;
    //_quey = fireDatos.mostrarCategoria(widget.tipo);
    super.initState();
  }

  final icons = [
    Icons.account_balance_rounded,
    Icons.airplanemode_active,
    Icons.card_giftcard,
    Icons.airport_shuttle,
    Icons.album_sharp,
    Icons.apartment,
    Icons.attach_file,
    Icons.attach_money,
    Icons.request_quote_outlined,
    Icons.audiotrack_outlined,
    Icons.auto_stories,
    Icons.backpack,
    Icons.bolt,
    Icons.business,
    Icons.business_center_outlined,
    Icons.cake_outlined,
    Icons.call,
    Icons.camera_alt_outlined,
    Icons.checkroom,
    Icons.child_care,
    Icons.child_friendly_outlined,
    Icons.two_wheeler_rounded,
    Icons.monetization_on_sharp,
    Icons.chrome_reader_mode_outlined,
    Icons.clean_hands_outlined,
    Icons.cleaning_services_outlined,
    Icons.color_lens_outlined,
    Icons.colorize_rounded,
    Icons.computer,
    Icons.confirmation_num_outlined,
    Icons.construction,
    Icons.content_cut,
    Icons.content_paste,
    Icons.create_outlined,
    Icons.credit_card,
    Icons.crop_original,
    Icons.deck_outlined,
    Icons.delete_outline,
    Icons.desktop_mac,
    Icons.directions_boat_outlined,
    Icons.directions_bus_outlined,
    Icons.directions_car_outlined,
    Icons.directions_subway_outlined,
    Icons.directions_bike,
    Icons.eco_outlined,
    Icons.electrical_services,
    Icons.emoji_events_outlined,
    Icons.emoji_food_beverage_outlined,
    Icons.emoji_objects_outlined,
    Icons.event_seat_outlined,
    Icons.explore_outlined,
    Icons.extension_outlined,
    Icons.fastfood_outlined,
    Icons.favorite_border,
    Icons.filter_hdr_outlined,
    Icons.filter_vintage_outlined,
    Icons.folder_open,
    Icons.food_bank_outlined,
    Icons.format_paint_outlined,
    Icons.free_breakfast_outlined,
    Icons.gamepad_outlined,
    Icons.help_center_outlined,
    Icons.home_outlined,
    Icons.hotel_outlined,
    Icons.icecream,
    Icons.keyboard_outlined,
    Icons.kitchen,
    Icons.liquor,
    Icons.local_dining,
    Icons.local_fire_department,
    Icons.local_florist_outlined,
    Icons.local_gas_station_outlined,
    Icons.local_grocery_store_outlined,
    Icons.local_hospital_outlined,
    Icons.local_laundry_service_outlined,
    Icons.local_movies_outlined,
    Icons.monetization_on_outlined,
    Icons.motorcycle_outlined,
    Icons.pets,
    Icons.pool,
    Icons.shield,
    Icons.sanitizer_outlined,
    Icons.self_improvement,
    Icons.smoking_rooms_outlined,
    Icons.sports_basketball_outlined,
    Icons.sports_esports_outlined,
    Icons.sports_motorsports_outlined,
    Icons.sports_soccer,
    Icons.sports_volleyball_outlined,
    Icons.stay_current_portrait,
    Icons.store_mall_directory_outlined,
    Icons.vpn_key_outlined,
    Icons.wallet_travel_outlined,
    Icons.watch_outlined
  ];
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
        padding: EdgeInsets.only(top: 35),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _head(),
            _cuerpo(),
          ],
        ),
      ),
    );
  }

  Container _cuerpo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width - 20,
      child: Row(
        children: [
          _icons(),
          Container(
            width: MediaQuery.of(context).size.width * 0.78,
            height: MediaQuery.of(context).size.height - 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _seleccion(),
                _icons_selected(),
                _descripcion(),
                _botones(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _seleccion() {
    return Container(
        //margin: EdgeInsets.only(left: 50), //
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width - 100,
        padding: EdgeInsets.all(5), //
        decoration: _boxDecoration(20, 3),
        child: Container(
          //color: Colors.red,
          //height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              Text('Categorias', style: TextStyle(color: green, fontSize: 15)),
              Expanded(
                //height: 243,
                child: StreamBuilder<QuerySnapshot>(
                  stream: fireDatos.mostrarCategoria(widget.tipo),
                  //stream: _quey,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return _categoriasf(snapshot.data.docs);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget _categoriasf(List<QueryDocumentSnapshot> docs) {
    Map<String, int> categorias =
        docs.fold({}, (Map<String, int> map, element) {
      if (!map.containsKey(element['titulo'])) {
        map[element['titulo']] = element['icono'];
      }
      return map;
    });
    Map<String, String> categoriasEli =
        docs.fold({}, (Map<String, String> map, element) {
      if (!map.containsKey(element['titulo'])) {
        map[element['titulo']] = element['eliminar'];
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
          var eli = categoriasEli[titu];
          return _selected(icon, titu, eli);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Widget _categorias(AsyncSnapshot<QuerySnapshot> snapshot) {
    try {
      return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: snapshot.data.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return _selected(
              snapshot.data.docChanges[index].doc['icono'],
              snapshot.data.docChanges[index].doc['titulo'],
              snapshot.data.docChanges[index].doc['eliminar']);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Widget _selected(int i, String titulo, String eliminar) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: _boxDecoration(10, 3),
          margin: EdgeInsets.symmetric(vertical: 3),
          padding: EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Icon(IconData(i, fontFamily: 'MaterialIcons'),
                    color: green),
              ),
              Container(
                  width: eliminar == 'no'
                      ? MediaQuery.of(context).size.width * 0.55
                      : MediaQuery.of(context).size.width * 0.48,
                  child: Text(
                    titulo,
                    style: TextStyle(color: green, fontSize: 15),
                    textAlign: TextAlign.justify,
                  )),
              (eliminar == 'no')
                  ? SizedBox()
                  : InkWell(
                      child: Icon(
                        Icons.delete,
                        color: green,
                        size: 25,
                      ),
                      onLongPress: () {
                        setState(() {
                          print('eliminar $titulo');
                          fireDatos.eliminarCategoria(widget.tipo, titulo);
                        });
                      },
                    )
            ],
          ),
        ),
      ],
    );
  }

  Widget _descripcion() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextFormField(
          onChanged: (String valor) {
            descrip = valor;
            print(valor);
          },
          style: TextStyle(color: green),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: green, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: "Titulo",
            labelStyle: TextStyle(color: green),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: green, width: 3.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ));
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
              //iconSelected = Icons.help_center_outlined;
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FirstScreen(
                      fireDatos, widget.dia, widget.mes, widget.anio)));
            },
          ),
          RaisedButton(
              child: Text('Guardar'),
              color: green,
              onPressed: () {
                if (descrip != '' && iconSelected != Icons.error) {
                  Navigator.of(context).pop(Offset.infinite);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AgregarGIE(
                          widget.tipo,
                          '',
                          '',
                          fireDatos,
                          widget.dia,
                          widget.mes,
                          widget.anio,
                          '',
                          '',
                          descrip,
                          '',
                          0,
                          iconSelected.codePoint)));
                  descrip = descrip[0].toUpperCase() + descrip.substring(1);
                  setState(() {
                    // fireDatos.f
                    //     .collection('users')
                    //     .doc(sing.usuario.email)
                    //     .collection('cate${widget.tipo}')
                    //     .doc(descrip)
                    //     .set({
                    //   'icono': iconSelected.codePoint,
                    //   'titulo': descrip,
                    //   'eliminar': 'si'
                    // });
                    fireDatos.createCategory(
                        widget.tipo, iconSelected.codePoint, descrip, 'si');
                  });
                  print('Creando :v XD');
                } else {
                  print('falta datos');
                  _showMyDialog();
                }
              }),
        ],
      ),
    );
  }

  Widget _icons_selected() {
    return Container(
      alignment: Alignment.center,
      child: Icon(iconSelected, size: 200, color: green),
    );
  }

  Widget _icons() {
    return Container(
      decoration: _boxDecoration(10, 4),
      width: 60,
      height: MediaQuery.of(context).size.height - 150,
      child: _mostrar_icons(),
    );
  }

  Container _head() {
    String titulo = 'falla';
    if (this.widget.tipo == 'G') {
      titulo = 'Agregar categoria en gastos';
    } else if (this.widget.tipo == 'I') {
      titulo = 'Agragar categoria en Ingresos';
    }
    return Container(
      //alignment: Alignment(0.0, 0.0),
      child: Text(
        titulo,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30, color: green),
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

  Widget _mostrar_icons() {
    return ListView.builder(
      padding: EdgeInsets.all(0.0),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              iconSelected = icons[index];
              print('hola mundo');
            });
          },
          child: Container(
            color: (iconSelected == icons[index]) ? green : Colors.transparent,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Icon(
              icons[index],
              color: (iconSelected == icons[index]) ? Colors.black : green,
              size: 30,
            ),
          ),
        );
      },
    );
  }

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
                Text('Seleccione un icono o', style: TextStyle(color: green)),
                Text('coloque datos en titulo', style: TextStyle(color: green)),
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
}
