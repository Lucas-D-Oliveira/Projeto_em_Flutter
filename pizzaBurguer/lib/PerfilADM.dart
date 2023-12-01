import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizzaburguer/AlterarProdutos.dart';
import 'package:pizzaburguer/DeletarProdutos.dart';
import 'package:pizzaburguer/Login.dart';
import 'package:pizzaburguer/ProdutoCadastro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilADM extends StatefulWidget {
  const PerfilADM({Key? key});

  @override
  State<PerfilADM> createState() => _PerfilADMState();
}

class _PerfilADMState extends State<PerfilADM> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //Fundo
      width: double.infinity,
      padding: EdgeInsets.only(top: 20, bottom: 20),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeletarProdutos()),
                );
              },
              child: Text("Deletar produtos"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdutoCadastro()),
                );
              },
              child: Text("Cadastrar produto"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlterarProdutos()),
                );
              },
              child: Text("Alterar produto"),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();


                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text("Deslogar"),
            ),
          ],
        ),
      ),
    );
  }
}
