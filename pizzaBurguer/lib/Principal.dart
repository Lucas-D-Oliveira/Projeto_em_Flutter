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

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {



  double larguraP = 350;
  double alturaP = 300;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(//Fundo
        width: double.infinity,
        padding: EdgeInsets.only(top: 20, bottom: 20),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
        ),
        //color: Colors.white,
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 15,
            spacing: 10,
            alignment: WrapAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      child: Text(""
                          "PROMOÇÕES",
                        textAlign: TextAlign.center, //alinhamento do texto
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                ),
              ),
              Container( //1
                height: alturaP,
                width: larguraP,
                decoration: BoxDecoration(
                  color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('imagens/promo1.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
              ), //1
              Container( //2
                //color: Colors.blue,
                height: alturaP,
                width: larguraP,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('imagens/promo2.jpg'),
                        fit: BoxFit.cover,
                      )
                  ),
              ),//2
              Container(//3
                // color: Colors.purpleAccent,
                height: alturaP,
                width: larguraP,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                image: AssetImage('imagens/promo3.jpg'),
                fit: BoxFit.cover,
              )
                ),

              ),//3
              Container(//4
                //color: Colors.red,
                height: alturaP,
                width: larguraP,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('imagens/promo4.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
              ),//4
            ],
          ),//promos
        ),
      ),//fundo

    );
  }
}

