import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class ProdutoCadastro extends StatefulWidget {
  const ProdutoCadastro({Key? key}) : super(key: key);

  @override
  _ProdutoCadastroState createState() => _ProdutoCadastroState();
}

class _ProdutoCadastroState extends State<ProdutoCadastro> {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoController = TextEditingController();

  String? tipoSelecionado;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

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
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: ListView(
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
              TextFormField(
                controller: codigoController,
                decoration: InputDecoration(labelText: "Digite o código do produto"),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(labelText: "Digite o nome do produto"),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: descricaoController,
                decoration: InputDecoration(labelText: "Digite a descrição do produto"),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: precoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Digite o preço do produto"),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  selecionarImagem();
                },
                child: Text("Selecionar Imagem"),
              ),
              _imageFile == null
                  ? Container()
                  : Image.file(
                File(_imageFile!.path),
                height: 100,
                width: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  verificarEAdicionarProduto();
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

  Future<void> selecionarImagem() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> uploadImagem(String codigo) async {
    if (_imageFile == null) return;

    try {
      String path = 'imagens/$tipoSelecionado/$codigo.png';
      await firebase_storage.FirebaseStorage.instance.ref(path).putFile(File(_imageFile!.path));


      String imageUrl = await firebase_storage.FirebaseStorage.instance.ref(path).getDownloadURL();


      await db.collection(tipoSelecionado!).doc(codigo).set({
        "nome": nomeController.text,
        "descricao": descricaoController.text,
        "preco": double.parse(precoController.text),
        "caminhoImagem": imageUrl,
      });
    } catch (e) {
      print("Erro ao fazer upload da imagem: $e");
    }
  }

  void verificarEAdicionarProduto() async {
    try {
      if (tipoSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.amber,
            content: Text("Escolha o tipo do produto."),
          ),
        );
        return;
      }

      String codigo = codigoController.text.trim();

      if (codigo.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.amber,
            content: Text("Digite o código do produto."),
          ),
        );
        return;
      }

      DocumentSnapshot<Map<String, dynamic>> result =
      await db.collection(tipoSelecionado!).doc(codigo).get();

      if (result.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.amber,
            content: Text("Já existe um produto com o mesmo código!"),
          ),
        );
      } else {
        await uploadImagem(codigo);

        codigoController.clear();
        nomeController.clear();
        descricaoController.clear();
        precoController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Produto cadastrado com sucesso!"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Erro ao cadastrar produto!"),
        ),
      );
    }
  }
}
