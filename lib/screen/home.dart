import 'package:barcode_generator/provider/xl_read_provider.dart';
import 'package:desktop_window/desktop_window.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/select_files_box.dart';
import 'components/upload_excel_file_box.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ////////////////////////////////////////////////////// window size part start
  String _windowSize = 'Unknown';

  @override
  void initState() {
    super.initState();
  }
  Future _getWindowSize() async {
    var size = await DesktopWindow.getWindowSize();
    setState(() {
      _windowSize = '${size.width} x ${size.height}';
    });
  }
 ////////////////////////////////////////////////////// window size part end


  String? filePath;  // storing the file path here

  @override
  Widget build(BuildContext context) {

    DesktopWindow.setMinWindowSize(Size(1200, 800));   // min  window size

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Barcode Generator',
            style:TextStyle(fontWeight: FontWeight.w500,fontSize:23)
        ),
        centerTitle: true,
      ),
      body: Consumer<ExcelProvider>(
        builder: (BuildContext context, value,  child)
        {
          // contains excel uploading box and the select file box
          return Container(
            width: w,
            height: h*.99,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // select excel file box
                UploadExcelFileBox(h: h, w: w,context: context, value: value,),
                // file upload hole select koro
                if(value.importedExcelFiles)SelectFilesBox(h: h, w: w, value: value, context: context,),
                //if(false)BarcodeView(w: w, itemCount: value.currentSliderValue.toInt(), barcodes: value.barcodes,),
              ],
            ),);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height:h*.05,
          child: Center(
            child: RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'T E', style: TextStyle(fontWeight: FontWeight.w500,fontSize: 23)),
                  TextSpan(text: ' A',style:TextStyle(fontWeight: FontWeight.w500,fontSize: 23,color: Colors.red)),
                  TextSpan(text: ' M',style:TextStyle(fontWeight: FontWeight.w500,fontSize: 23)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}






