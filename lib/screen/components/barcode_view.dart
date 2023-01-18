import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class BarcodeView extends StatelessWidget {
   BarcodeView({
    Key? key,
    required this.w,
    required this.itemCount,
    required this.barcodes,
    required this.history,
  }) : super(key: key);

  final double w;
  int itemCount ;
  List<dynamic> barcodes ;
  String history ;

  @override
  Widget build(BuildContext context) {

    if(false)return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      height: w*.6,
      width: w*.25,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(w*.015))
      ),
      child:ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index){
             return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("TEAM Group"),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: w*.02,
                    vertical: w*.005,
                  ),
                  padding: EdgeInsets.only(bottom:w*.005),

                  height: 100,
                  child: PdfPreview(
                    build: (format) => _generatePdf(format, "lalala"),
                  ),
                ),
                Text(barcodes[index].toString()),
                SizedBox(height: w*.015,),
              ],
            );
          }
      ),
    );
    if(true) {
      return Container(
       // color: Colors.lightBlueAccent,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(20),
      child: PdfPreview(dpi: 300,
          build: (format) => _generatePdf(format, "title"),

        ),
    );
    }

  }


   Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
     final font = await PdfGoogleFonts.nunitoExtraLight();

     pdf.addPage(
       pw.Page(
         pageFormat: format,
         build: (context) {
           return pw.ListView.builder(
             itemCount:itemCount,
             itemBuilder: ( context, int index ){
               return pw.Container(
                // color: PdfColors.pink,
                 padding: pw.EdgeInsets.all(0),
                 child: pw.Column(
                     mainAxisAlignment: pw.MainAxisAlignment.center,
                     children: [
                       pw.Container(
                         width:140,
                         decoration: pw.BoxDecoration(
                           borderRadius: pw.BorderRadius.all(pw.Radius.circular(0)),
                           border: pw.Border.all(color: PdfColors.black,width: .51)

                         ),
                        // margin: pw.EdgeInsets.all(0),
                           child: pw.Center(
                             child: pw.Text("TEAM Group",
                               style: pw.TextStyle(fontSize: 10),
                             )
                           ),
                       ),
                       pw.Container(
                         //margin: pw.EdgeInsets.all(2),
                         width: 140,
                         height: 50,
                         decoration: pw.BoxDecoration(border: pw.Border.all(width: .5)),
                         //color: PdfColors.red,
                         margin: pw.EdgeInsets.only(bottom: 4),
                         child:pw.BarcodeWidget(padding: pw.EdgeInsets.all(1),
                           data: barcodes[index],height: 30,
                           margin: pw.EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 5),
                           barcode: pw.Barcode.code128(),textStyle: pw.TextStyle(fontSize: 10),
                             textPadding:2,
                           drawText: true,
                         ),
                       ),

                       if(false)pw.Text(
                           "Log: ${history}"
                       ),
                     ]
                 ),
               );
             },
           );
         },
       ),
     );

     return pdf.save();
   }
}