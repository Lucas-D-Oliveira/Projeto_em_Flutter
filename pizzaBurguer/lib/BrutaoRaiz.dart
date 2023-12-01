import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrutaoRaiz extends StatefulWidget {
  const BrutaoRaiz({Key? key});

  @override
  State<BrutaoRaiz> createState() => _BrutaoRaizState();
}

class _BrutaoRaizState extends State<BrutaoRaiz> {
  double largura = 180;
  double altura = 200;
  Color Fundo = Color(0xFF812A00);
  Color Letras = Colors.black;
  late List<Map<String, dynamic>> produtos = [];

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  Future<void> _carregarProdutos() async {
    try {
      QuerySnapshot<Map<String, dynamic>> documentos = await FirebaseFirestore.instance
          .collection("BrutaoRaiz")
          .get();

      setState(() {
        produtos = documentos.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print("Erro ao carregar produtos do Firebase: $e");
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 15,
            spacing: 10,
            alignment: WrapAlignment.center,
            children: _buildProdutos(),
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

  List<Widget> _buildProdutos() {
    if (produtos == null || produtos.isEmpty) {
      return [
        Text(
          "Nenhum produto encontrado.",
          style: TextStyle(color: Colors.black),
        ),
      ];
    }

    return produtos.map((produto) {
      String nome = produto["nome"] ?? "Nome não disponível";
      String preco = (produto["preco"] ?? 0).toString();
      String imageUrl = produto["caminhoImagem"] ?? "";

      return Container(
        height: altura,
        width: largura,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: largura,
                child: imageUrl.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
                    : Center(
                  child: Text(
                    "Imagem não disponível",
                    style: TextStyle(
                      fontSize: 15,
                      color: Letras,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                nome,
                style: TextStyle(
                  fontSize: 15,
                  color: Letras,
                ),
              ),
            ),
            Container(
              child: Text(
                "Preço: $preco",
                style: TextStyle(
                  fontSize: 15,
                  color: Letras,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
