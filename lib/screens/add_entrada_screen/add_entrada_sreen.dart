import 'package:controle_financeiro/data/dao/gasto_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddEntradaScreen extends StatefulWidget {
  const AddEntradaScreen({super.key});

  @override
  State<AddEntradaScreen> createState() => _AddEntradaScreenState();
}

class _AddEntradaScreenState extends State<AddEntradaScreen> {
  final TextEditingController valorEntrada = TextEditingController();
  final TextEditingController descricaoEntrada = TextEditingController();
  final TextEditingController categoriaEntrada = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicione uma Entrada"),
      ),
      body: Column(
        children: [
          TextField(
            controller: valorEntrada,
            decoration: InputDecoration(label: Text("Valor Entrada")),
          ),
          TextField(
            controller: descricaoEntrada,
            decoration: InputDecoration(label: Text("Descrição da Entrada")),
          ),
          TextField(
            controller: categoriaEntrada,
            decoration: InputDecoration(label: Text("Categoria da Entrada")),
          ),
          Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
            onPressed: () {
              GastoDAO().save(int.parse(valorEntrada.text), descricaoEntrada.text,
                  categoriaEntrada.text,false);
                  Navigator.pop(context);
            },
            child: Text("Salvar Entrada"),
          )),
        ],
      ),
    );
  }
}
