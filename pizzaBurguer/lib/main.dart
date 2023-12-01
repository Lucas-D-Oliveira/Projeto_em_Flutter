import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:pizzaburguer/Avaliacoes.dart';
import 'package:pizzaburguer/Cardapio.dart';
import 'package:pizzaburguer/Login.dart';
import 'package:pizzaburguer/Pedidos.dart';
import 'package:pizzaburguer/PerfilADM.dart';
import 'package:pizzaburguer/PerfilCliente.dart';
import 'package:pizzaburguer/Principal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAppCheck.instance.activate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}