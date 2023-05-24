import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pdf/widgets.dart' as pw;

import '../component/gasto.dart';

class GastoWriter extends pw.StatelessWidget {
  final Gasto gasto;

  GastoWriter(this.gasto);


  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5.0),
      child: pw.Container(
        width: 100,
        height: 70,
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Column(
              children: [
                pw.Text("R\$ ${gasto.valor / 100}"),
                pw.Text(gasto.description),
                pw.Text(gasto.categoria),
                pw.Text(gasto.data),
                pw.Text(gasto.ehGasto? "Gasto" : "Entrada")
              ],
            ),
          ],
        ),
      ),
    );
  }

 
}