import 'package:controle_financeiro/data/component/gasto.dart';
import 'package:controle_financeiro/data/dao/gasto_dao.dart';
import 'package:controle_financeiro/screens/add_entrada_screen/add_entrada_sreen.dart';
import 'package:controle_financeiro/screens/add_gasto_screen/add_gasto_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Text("Total GASTO:R\$ ${somatorioGasto/100}"),
              Text("Total ENTRADA:R\$ ${somatorioEntrada/100}"),
              Text("Total:R\$ ${(somatorioEntrada-somatorioGasto)/100}"),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddGastoScreen()),
                ).then((value) => setState(() {
                      GastoDAO()
                          .getAll()
                          .then((value) => {setState(() => listaGasto = value)});
                    }))
              },
              child: Text("Adicionar Gasto"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddEntradaScreen()),
                ).then((value) => setState(() {
                      GastoDAO()
                          .getAll()
                          .then((value) => {setState(() => listaGasto = value)});
                    }))
              },
              child: Text("Adicionar Entrada"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey
              ),
              onPressed: () => {
                setState(() {
                  GastoDAO()
                          .getAll()
                          .then((value) => {setState(() => listaGasto = value)});
                },)
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
