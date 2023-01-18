import 'package:barcode_generator/provider/xl_read_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/barcode_view.dart';

class BarCodePrintingPage extends StatefulWidget {
  const BarCodePrintingPage({Key? key}) : super(key: key);

  @override
  State<BarCodePrintingPage> createState() => _BarCodePrintingPageState();
}

class _BarCodePrintingPageState extends State<BarCodePrintingPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: RichText(
          text: TextSpan(
            children: const <TextSpan>[
              TextSpan(text: 'T E', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
              TextSpan(text: ' A',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.red)),
              TextSpan(text: ' M',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ExcelProvider>(builder: (BuildContext context, value, child){
         return Container(
           margin: EdgeInsets.all(20),
           // color: Colors.red,
             child: Center(child: BarcodeView(w: w, itemCount: value.currentSliderValue.toInt(), barcodes: value.allCodes,history: value.history,)));
    }),

    );
  }
}
