import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizzaburguer/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilCliente extends StatefulWidget {
  const PerfilCliente({super.key});

  @override
  State<PerfilCliente> createState() => _PerfilClienteState();
}

class _PerfilClienteState extends State<PerfilCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("Clientes"),
          ),
          Center(
            child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }
}

