import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: ListView(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Digite o e-mail"),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Digite a senha"),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  cadastrarUsuario();
                },
                child: Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: Text("Voltar"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void cadastrarUsuario() async {
    try {
      String email = emailController.text;
      String senha = senhaController.text;

      if (email.isNotEmpty && senha.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: senha,
        );

        print('Usuário cadastrado: ${userCredential.user?.email}');


        emailController.clear();
        senhaController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.amber,
            content: Text("Preencha todos os campos."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Erro ao cadastrar usuário: $e"),
        ),
      );
    }
  }
}
