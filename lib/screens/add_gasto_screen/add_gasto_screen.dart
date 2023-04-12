import 'package:controle_financeiro/data/component/gasto.dart';
import 'package:controle_financeiro/data/dao/gasto_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddGastoScreen extends StatefulWidget {
  const AddGastoScreen({super.key});

  @override
  State<AddGastoScreen> createState() => _AddGastoScreenState();
}

class _AddGastoScreenState extends State<AddGastoScreen> {
  final TextEditingController valorGasto = TextEditingController();
  final TextEditingController descricaoGasto = TextEditingController();
  final TextEditingController categoriaGasto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicione um Gasto"),
      ),
      body: Column(
        children: [
          TextField(
            controller: valorGasto,
            decoration: InputDecoration(label: Text("Valor Gasto")),
          ),
          TextField(
            controller: descricaoGasto,
            decoration: InputDecoration(label: Text("Descrição do Gasto")),
          ),
          TextField(
            controller: categoriaGasto,
            decoration: InputDecoration(label: Text("Categoria do Gasto")),
          ),
          Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
            onPressed: () {
              GastoDAO().save(int.parse(valorGasto.text), descricaoGasto.text,
                  categoriaGasto.text,true);
                  Navigator.pop(context);
            },
            child: Text("Salvar Gasto"),
          )),
        ],
      ),
    );
  }
}
