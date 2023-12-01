import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizzaburguer/Cadastro.dart';
import 'package:pizzaburguer/PerfilADM.dart';
import 'package:pizzaburguer/PrincipalV.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController campoUsuario = TextEditingController();
  TextEditingController campoSenha = TextEditingController();
  String emailU = "";
  String senha = "";
  FirebaseAuth _auth = FirebaseAuth.instance;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    inicializarPrefs();
    FirebaseAppCheck.instance.activate();
    verificarUsuario();
  }

  void inicializarPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void verificarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? usuario = await auth.currentUser;

    if (usuario != null) {

      bool isAdmin = (emailU == "adm@gmail.com" && senha == "123456adm");

      prefs.setBool('logadoAdm', isAdmin);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PrincipalV()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: campoUsuario,
                  decoration: InputDecoration(
                    labelText: "Digite seu nome de usuário",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: campoSenha,
                  decoration: InputDecoration(
                    labelText: "Digite sua senha",
                  ),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                   emailU = campoUsuario.text;
                   senha = campoSenha.text;

                  if (emailU.isEmpty || emailU.length < 4) {
                    mostrarSnackbar("Digite um nome de usuário válido");
                  } else if (senha.isEmpty || senha.length < 6) {
                    mostrarSnackbar("Digite uma senha válida");
                  } else {
                    try {
                      UserCredential userCredential =
                      await _auth.signInWithEmailAndPassword(
                        email: emailU,
                        password: senha,
                      );

                      if (userCredential.user != null) {
                        verificarUsuario();
                      } else {
                        mostrarSnackbar("Usuário ou senha incorretos");
                      }
                    } catch (e) {
                      mostrarSnackbar("Erro ao realizar o login: $e");
                    }
                  }
                },
                child: Text("Entrar"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cadastro()),
                      );
                    },
                    child: Text("Cadastrar"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void mostrarSnackbar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red,
      ),
    );
  }
}
