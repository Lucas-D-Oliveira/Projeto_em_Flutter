import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlterarProdutos extends StatefulWidget {
  const AlterarProdutos({Key? key}) : super(key: key);

  @override
  _AlterarProdutosState createState() => _AlterarProdutosState();
}

class _AlterarProdutosState extends State<AlterarProdutos> {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController novaDescricaoController = TextEditingController();
  final TextEditingController novoPrecoController = TextEditingController();
  final TextEditingController novoNomeController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Padding(
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
                "Digite o código do produto:",
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
                  recuperarDadosProduto();
                },
                child: Text("Buscar"),
              ),
              SizedBox(height: 20),
              Text(
                "Dados do Produto:",
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: novoNomeController,
                decoration: InputDecoration(
                  hintText: "Novo nome do produto",
                ),
              ),
              TextField(
                controller: novaDescricaoController,
                decoration: InputDecoration(
                  hintText: "Nova descrição do produto",
                ),
              ),
              TextField(
                controller: novoPrecoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Novo preço do produto",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  alterarProduto();
                },
                child: Text("Alterar Produto"),
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

  void recuperarDadosProduto() async {
    try {
      String codigoProduto = codigoController.text;

      if (codigoProduto.isNotEmpty && tipoSelecionado != null) {
        DocumentSnapshot<Map<String, dynamic>> produto =
        await _firestore.collection(tipoSelecionado!).doc(codigoProduto).get();

        if (produto.exists) {
          novoNomeController.text = produto["nome"];
          novaDescricaoController.text = produto["descricao"];
          novoPrecoController.text = produto["preco"].toString();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.amber,
              content: Text("Nenhum produto encontrado com este código."),
            ),
          );
        }
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
          content: Text("Erro ao recuperar dados do produto: $e"),
        ),
      );
    }
  }

  void alterarProduto() async {
    try {
      String codigoProduto = codigoController.text;

      if (codigoProduto.isNotEmpty && tipoSelecionado != null) {
        await _firestore.collection(tipoSelecionado!).doc(codigoProduto).update({
          "nome": novoNomeController.text,
          "descricao": novaDescricaoController.text,
          "preco": double.parse(novoPrecoController.text),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Produto alterado com sucesso!"),
          ),
        );

        codigoController.clear();
        novoNomeController.clear();
        novaDescricaoController.clear();
        novoPrecoController.clear();
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
          content: Text("Erro ao alterar produto: $e"),
        ),
      );
    }
  }
}
