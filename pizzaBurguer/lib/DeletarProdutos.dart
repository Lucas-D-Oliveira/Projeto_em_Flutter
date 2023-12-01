import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeletarProdutos extends StatefulWidget {
  const DeletarProdutos({Key? key}) : super(key: key);

  @override
  _DeletarProdutosState createState() => _DeletarProdutosState();
}

class _DeletarProdutosState extends State<DeletarProdutos> {
  final TextEditingController codigoController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? tipoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "imagens/Pizza.png",
          height: 60,
          alignment: Alignment.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: tipoSelecionado,
              onChanged: (String? newValue) {
                setState(() {
                  tipoSelecionado = newValue;
                });
              },
              items: <String?>['Doces', 'BrutaoRaiz', 'Bebidas']
                  .map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value!,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: "Escolha o tipo do produto"),
            ),
            Text(
              "Digite o código do produto a ser deletado:",
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: codigoController,
              decoration: InputDecoration(
                hintText: "Código do produto",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                deletarProdutoPorCodigo();
              },
              child: Text("Deletar Produto"),
            ),
          ],
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

  void deletarProdutoPorCodigo() async {
    try {
      String codigoProduto = codigoController.text;

      if (codigoProduto.isNotEmpty && tipoSelecionado != null) {
        // Deletar o produto com o código fornecido pelo usuário
        await _firestore.collection(tipoSelecionado!).doc(codigoProduto).delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Produto deletado com sucesso!"),
          ),
        );

        // Limpar o campo de texto após a exclusão
        codigoController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.amber,
            content: Text("Digite o código do produto e escolha o tipo."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Erro ao deletar produto: $e"),
        ),
      );
    }
  }
}
