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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrincipalV(),
    );
  }
}

class PrincipalV extends StatefulWidget {
  const PrincipalV({Key? key}) : super(key: key);

  @override
  State<PrincipalV> createState() => _PrincipalVState();
}

class _PrincipalVState extends State<PrincipalV> {
  int indiceBottom = 0;
  bool ADM = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    inicializarPrefs();
  }

  void inicializarPrefs() async {
    prefs = await SharedPreferences.getInstance();
    verificarLogado();
  }

  void verificarLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuario = auth.currentUser;

    if (usuario != null) {
      String email = usuario.email ?? "";
      String uid = usuario.uid;
      print(uid);
      print(email);

      bool logadoAdm = prefs.getBool('logadoAdm') ?? false;
        print("//////////////////////////////////////////////////$logadoAdm");
        setState(() {
          ADM = logadoAdm;
        });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "imagens/Pizza.png",
          height: 60,
          alignment: Alignment.center,
        ),
      ),
      body: IndexedStack(
        index: indiceBottom,
        children: <Widget>[
          Principal(),
          Cardapio(),
          Pedidos(),
          Avaliacoes(),
          if (ADM)
            PerfilADM()
          else
            PerfilCliente(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: indiceBottom,
        fixedColor: Colors.redAccent,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (indiceB) {
          setState(() {
            indiceBottom = indiceB;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ("Inicio"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: ("Cardápio"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: ("Pedidos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: ("Avaliações"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: ("Perfil"),
          ),
        ],
      ),
    );
  }
}
