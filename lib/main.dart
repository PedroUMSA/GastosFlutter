// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gastos/home/categoria.dart';
import 'package:gastos/home/firebase.dart';
import 'package:gastos/home/home0.dart';
import 'package:gastos/home/home1.dart';
import 'package:gastos/home/login_state.dart';
import 'package:gastos/home/main2.dart';
import 'package:gastos/home/sing_in.dart';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gastos/home/sing_in.dart' as t;

import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:provider/provider.dart'; //vertical

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //metodo para que la orientacion se mantenga en vertical

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //runApp(Phoenix(child: MyApp()));
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     FireDatos fire = FireDatos();
//     DateTime now = DateTime.now();
//     return ChangeNotifierProvider<LoginState>(
//       builder: (BuildContext context, child) {
//         LoginState();
//       },
//       child: MaterialApp(
//         title: 'Gastos',
//         routes: {
//           '/': (BuildContext context) {
//             var state = Provider.of<LoginState>(context);
//             if (state.isLoggerdIn()) {
//               return Home0();
//             } else {
//               return FirstScreen(fire, now.day, now.month, now.year);
//             }
//           }
//         },
//       ),
//     );
//   }
// }
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final GoogleSignIn ggg = GoogleSignIn();
  // bool _issignin = false;
  // @override
  // Widget build(BuildContext context) {
  //   var signedIn = ggg.isSignedIn();
  //   return FutureBuilder<User>(
  //     future: FirebaseAuth.instance.currentUser,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         User user = snapshot.data;
  //         DateTime now = DateTime.now();
  //         return FirstScreen(fireDatos, now.day, now.month, now.year);
  //       } else {
  //         return Home0();
  //       }
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    FireDatos fire = FireDatos();
    DateTime now = DateTime.now();
    // t.isSingIn().whenComplete(() {
    //   if (t.usuario != null) {
    //     FirstScreen(fire, now.day, now.month, now.year);
    //   } else {
    //     Home0();
    //   }
    // });
    // print('AAAAAAAAAAAAAAAAAAAA         ${FirebaseAuth.instance.currentUser}');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'Home0',
      routes: {
        'Home0': (BuildContext context) => Home0(),
        'Home1': (BuildContext context) =>
            FirstScreen(fire, now.day, now.month, now.year),
        'Home3': (BuildContext context) => Iniciar(),
      },
    );
  }
}
