import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gastos/home/sing_in.dart' as t;
import 'dart:io';
// import 'package:gastos/home/sub_registro.dart';

class FireDatos {
  final FirebaseFirestore f = FirebaseFirestore.instance;
  bool fondo = false;
  double totalGastos = 0;
  double totalIngresos;
  Stream<QuerySnapshot> queryTotal(String tipo, User user, int mes, int anio) {
    String meses = '';
    if (mes > 9) {
      meses = '$mes';
    } else {
      meses = '0$mes';
    }
    print('FIREDATOS ----------- ${user.email}');
    try {
      return f
          .collection('users')
          .doc(user.email)
          //.collection('movimiento$tipo')
          .collection('movimiento') //
          .where('tipo', isEqualTo: tipo) //
          .where('mes', isEqualTo: meses)
          .where('anio', isEqualTo: anio)
          .snapshots();
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> sub_registros(
      String tipo, int mes, int anio, String titulo) {
    String meses = '';
    if (mes > 9) {
      meses = '$mes';
    } else {
      meses = '0$mes';
    }
    User user = t.usuario;
    try {
      return f
          .collection('users')
          .doc(user.email)
          //.collection('movimiento$tipo')
          .collection('movimiento') //
          .where('tipo', isEqualTo: tipo) //
          .where('mes', isEqualTo: meses)
          .where('anio', isEqualTo: anio)
          .where('titulo', isEqualTo: titulo)
          .snapshots();
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> anual() {
    User user = t.usuario;
    return f
        .collection('users')
        .doc(user.email)
        .collection('movimiento')
        .snapshots();
  }

  Stream<QuerySnapshot> mensual(int a) {
    User user = t.usuario;
    return f
        .collection('users')
        .doc(user.email)
        .collection('movimiento')
        .where('anio', isEqualTo: a)
        .snapshots();
  }

  Stream<QuerySnapshot> mostrarCategoria(String tipo) {
    User user = t.usuario;
    try {
      return f
          .collection('users')
          .doc(user.email)
          .collection('cate$tipo')
          .snapshots();
    } catch (e) {
      print(e);
    }
  }

  eliminar(String tipo, String cod) {
    User user = t.usuario;
    try {
      f
          .collection('users')
          .doc(user.email)
          //.collection('movimiento$tipo')
          .collection('movimiento') //
          .doc(cod)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  editarGI(String tipo, String cod, String titulo, int iconS, String descrip,
      double dinero) {
    User user = t.usuario;
    try {
      f
          .collection('users')
          .doc(user.email)
          //.collection('movimiento$tipo')
          .collection('movimiento')
          .doc(cod)
          .update({
        'titulo': titulo,
        'icon': iconS,
        'decripcion': descrip,
        'monto': dinero
      });
    } catch (e) {
      print(e);
    }
  }

  crearteRegistroGI(String tipo, DateTime ram, int dia, int mes, int anio,
      String titulo_seleccion, int icon_selec, String descrip, double dinero) {
    String dias = '';
    if (dia > 9) {
      dias = '$dia';
    } else {
      dias = '0$dia';
    }
    String meses = '';
    if (mes > 9) {
      meses = '$mes';
    } else {
      meses = '0$mes';
    }
    try {
      f
          .collection('users')
          .doc(t.usuario.email)
          //.collection('movimiento$tipo')
          .collection('movimiento') //
          .doc(
              '$anio-$meses-$dias ${ram.hour}:${ram.minute}:${ram.second}:${ram.hashCode}')
          .set({
        'cod':
            '$anio-$meses-$dias ${ram.hour}:${ram.minute}:${ram.second}:${ram.hashCode}',
        'dia': dias,
        'mes': meses,
        'anio': anio,
        'titulo': titulo_seleccion,
        'icon': icon_selec,
        'decripcion': descrip,
        'monto': dinero,
        'tipo': tipo //
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> autocreacion() async {
    Map<String, dynamic> add1 = {
      'icono': 57898,
      'titulo': 'casa',
      'eliminar': 'no',
    };
    Map<String, dynamic> add2 = {
      'icono': 58833,
      'titulo': 'Educación',
      'eliminar': 'no',
    };
    Map<String, dynamic> add3 = {
      'icono': 58006,
      'titulo': 'Entretenimiento y diversión',
      'eliminar': 'no',
    };
    Map<String, dynamic> add4 = {
      'icono': 57576,
      'titulo': 'Higiéne',
      'eliminar': 'no',
    };
    Map<String, dynamic> add5 = {
      'icono': 58961,
      'titulo': 'Ropa y calzado',
      'eliminar': 'no',
    };
    Map<String, dynamic> add6 = {
      'icono': 58001,
      'titulo': 'Salud',
      'eliminar': 'no',
    };
    Map<String, dynamic> add7 = {
      'icono': 59865,
      'titulo': 'Seguros',
      'eliminar': 'no',
    };
    Map<String, dynamic> add8 = {
      'icono': 58765,
      'titulo': 'Transporte',
      'eliminar': 'no',
    };
    //tipo I
    Map<String, dynamic> add9 = {
      'icono': 58312,
      'titulo': 'Pensiones',
      'eliminar': 'no',
    };
    Map<String, dynamic> add10 = {
      'icono': 58074,
      'titulo': 'Pensiones alimentarias',
      'eliminar': 'no',
    };
    Map<String, dynamic> add11 = {
      'icono': 58822,
      'titulo': 'Salario',
      'eliminar': 'no',
    };
    Map<String, dynamic> add12 = {
      'icono': 60895,
      'titulo': 'Trabajos extra',
      'eliminar': 'no',
    };
    Map<String, dynamic> addFull = {
      'Casa': add1,
      'Educación': add2,
      'Entretenimiento y diversión': add3,
      'Higiéne': add4,
      'Ropa y calzado': add5,
      'Salud': add6,
      'Seguros': add7,
      'Transporte': add8
    };
    Map<String, dynamic> addFull2 = {
      'Pensiones': add9,
      'Pensiones alimentarias': add10,
      'Salario': add11,
      'Trabajos extra': add12
    };
    var ff = f.collection('users').doc(t.usuario.email);
    addFull.forEach((key, value) async {
      await ff.collection('cateG').doc(key).set(value);
    });
    addFull2.forEach((key, value) async {
      await ff.collection('cateI').doc(key).set(value);
    });
    return Future.value(true);
  }

  createCategory(String tipo, int i, String descrip, String eliminar) {
    f
        .collection('users')
        .doc(t.usuario.email)
        .collection('cate$tipo')
        .doc(descrip)
        .set({'icono': i, 'titulo': descrip, 'eliminar': eliminar});
  }

  eliminarCategoria(String tipo, String cod) async {
    User user = t.usuario;
    try {
      print('eliminar catergoria :  $cod   $tipo');
      f
          .collection('users')
          .doc(user.email)
          .collection('cate$tipo')
          .doc(cod)
          .delete();

      List<DocumentSnapshot> documentList = (await f
              .collection('users')
              .doc(user.email)
              //.collection('movimiento$tipo')
              .collection('movimiento') //
              .where('titulo', isEqualTo: cod)
              .get())
          .docs;
      print('esto tienes que leer el docuemnto');

      documentList.forEach((element) {
        print(
            '${element['titulo']}   ${element['monto']}  ${element['decripcion']}');

        f
            .collection('users')
            .doc(user.email)
            //.collection('movimiento$tipo')
            .collection('movimiento') //
            .doc(element['cod'])
            .update({'titulo': 'Categoria eliminada reasignar', 'icon': 59136});
      });
    } catch (e) {
      print(e);
    }
  }
}
