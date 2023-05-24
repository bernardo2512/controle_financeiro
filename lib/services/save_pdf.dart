import 'dart:io';

import 'package:controle_financeiro/data/component/gasto.dart';
import 'package:controle_financeiro/data/writer/gasto_writer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SavePdf {
  List<Gasto> listaGasto;


  SavePdf(this.listaGasto);

  salvar() async {
    final pdf = pw.Document();
    final List<GastoWriter> listaGastoWriter =[];
    listaGasto.forEach((element) => listaGastoWriter.add(GastoWriter(element)));


    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
           ...listaGastoWriter 
          ],
        ); 
      }));
      final output = await getTemporaryDirectory();
      final file = await File("${output.path}/example.pdf").create(recursive: true);
      print(output.path);
      await file.writeAsBytes(await pdf.save());
  }



}