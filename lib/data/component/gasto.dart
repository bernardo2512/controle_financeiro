import 'package:controle_financeiro/data/dao/gasto_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Gasto extends StatefulWidget {
  final int id;
  final int valor;
  final String description;
  final String categoria;
  final bool ehGasto;
  final String data;
  const Gasto(
      this.id, this.valor, this.description, this.categoria, this.ehGasto,this.data,
      {super.key});

  @override
  State<Gasto> createState() => _GastoState();
}

class _GastoState extends State<Gasto> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: this.widget.ehGasto
              ? Color.fromRGBO(255, 200, 200, 1.0)
              : Color.fromRGBO(200, 255, 200, 1.0),
        ),
        width: 100,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("R\$ ${widget.valor / 100}"),
                Text(widget.description),
                Text(widget.categoria),
                Text(widget.data)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,),
                  onPressed: () {
                    setState(() {
                      GastoDAO().delete(widget.id);
                    });
                  },
                  child: Text("X")),
            )
          ],
        ),
      ),
    );
  }
}
