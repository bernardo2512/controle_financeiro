import 'package:controle_financeiro/data/component/gasto.dart';
import 'package:controle_financeiro/data/dao/gasto_dao.dart';
import 'package:controle_financeiro/screens/add_entrada_screen/add_entrada_sreen.dart';
import 'package:controle_financeiro/screens/add_gasto_screen/add_gasto_screen.dart';
import 'package:controle_financeiro/services/save_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchCategoria = TextEditingController();
  List<Gasto> listaGasto = [];

  @override
  void initState() {
    GastoDAO().getAll().then((value) => {setState(() => listaGasto = value)});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int somatorioGasto = 0;
    int somatorioEntrada = 0;
    for (var element in listaGasto) {
      if (element.ehGasto) {
        somatorioGasto += element.valor;
      } else {
        somatorioEntrada += element.valor;
      }
    }

    return Column(
      children: [
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Total SAIDA:R\$ ${somatorioGasto / 100}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Total ENTRADA:R\$ ${somatorioEntrada / 100}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "${somatorioEntrada - somatorioGasto < 0 ? "Divida" : "Saldo"}:R\$ ${(somatorioEntrada - somatorioGasto) / 100}"),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: SizedBox(
                width: 275,
                child: TextField(
                  controller: searchCategoria,
                  decoration:
                      InputDecoration(label: Text("Busque por Categoria")),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    listaGasto = listaGasto
                        .where((element) =>
                            element.categoria == searchCategoria.text)
                        .toList();
                    searchCategoria.clear();
                  });
                },
                child: Icon(Icons.search)
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  SavePdf(listaGasto).salvar();
                },
                child: Icon(Icons.download)
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddGastoScreen()),
                ).then((value) => () {
                      GastoDAO()
                          .getAll()
                          .then((value) => setState(() => listaGasto = value));
                    })
              },
              child: Text("Adicionar Gasto"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddEntradaScreen()),
                ).then((value) => () {
                      GastoDAO()
                          .getAll()
                          .then((value) => setState(() => listaGasto = value));
                    })
              },
              child: Text("Adicionar Entrada"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              onPressed: () => {
                GastoDAO()
                    .getAll()
                    .then((value) => {setState(() => listaGasto = value)})
              },
              child: Text("Recarregar"),
            ),
          ],
        ),
        Expanded(
            child: ListView(
          children: [...listaGasto],
        ))
      ],
    );
  }
}
