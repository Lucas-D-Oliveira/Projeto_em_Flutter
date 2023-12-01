import 'package:flutter/material.dart';
import 'package:pizzaburguer/Bebidas.dart';
import 'package:pizzaburguer/BrutaoRaiz.dart';
import 'package:pizzaburguer/BurguersGoumert.dart';
import 'package:pizzaburguer/Combos.dart';
import 'package:pizzaburguer/Doces.dart';
import 'package:pizzaburguer/Dogs.dart';
import 'package:pizzaburguer/MiniBurguer.dart';
import 'package:pizzaburguer/Molhos.dart';
import 'package:pizzaburguer/Pizzas.dart';
import 'package:pizzaburguer/Porcoes.dart';
import 'package:pizzaburguer/TrocaItem.dart';

class Cardapio extends StatefulWidget {
  const Cardapio({super.key});

  @override
  State<Cardapio> createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {
  double larguraI = 100;
  double alturaI = 100;
  Color Fundo = Color(0xFFD9D9D9);
  Color Letras = Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 15,
            spacing: 10,
            alignment: WrapAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BrutaoRaiz()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lunch_dining, size: 32),
                      SizedBox(height: 8),
                      Text("BRUTÃO RAIZ", textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BurguersGoumert()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lunch_dining, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "BURGUER'S GOUMERT",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Letras),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MiniBurguer()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lunch_dining, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "MINI BURGUER",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Letras),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Bebidas()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_drink_rounded, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "BEBIDAS",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Letras),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dogs()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lunch_dining, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "DOG'S",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Letras),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Doces()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cookie, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "DOCES",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Letras),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Combos()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fastfood_rounded, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "COMBOS",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Letras),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Molhos()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.water_drop_rounded, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "MOLHOS",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Letras),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Porcoes()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.room_service, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "PORÇÕES",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Letras),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pizzas()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_pizza, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "PIZZAS",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Letras),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrocaItem()),
                  );
                },
                child: Container(
                  width: larguraI,
                  height: alturaI,
                  decoration: BoxDecoration(
                    color: Fundo,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.change_circle, size: 32),
                      SizedBox(height: 8),
                      Text(
                        "TROCA DE ITEM",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Letras),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
