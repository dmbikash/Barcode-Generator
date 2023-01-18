import 'package:barcode_generator/provider/xl_read_provider.dart';
import 'package:flutter/material.dart';


class UploadExcelFileBox extends StatelessWidget {
  const UploadExcelFileBox({
    Key? key,
    required this.h,
    required this.w,
    required this.value,
    required this.context,
  }) : super(key: key);

  final double h;
  final double w;
  final ExcelProvider value;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 2),
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey[300],
      ),
      height: h*.5,
      width: w*.35,
      // ----upload excel file + slider + show barcode
      child: Column(
        children: [
          //-------------Upload Excel File
          Container(
            margin: EdgeInsets.only(top:h*.1105),
            decoration: BoxDecoration(
            boxShadow: const [
                BoxShadow(color: Colors.black54,blurRadius: 4,offset: Offset(2,2),
                )],
                color: Colors.blue[200],
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            width: w*.2,
            height:h*.08,
            child:  ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(w*.03)))),
              child: Text("Upload Excel FIle",style:TextStyle(fontWeight: FontWeight.w500,fontSize: h *.0220)),
              onPressed:(){
                value.pickFile(context);
              },
            ),
          ),
         //-------------slider
          Container(
            width: 200,
            child: Slider(
              activeColor: Colors.redAccent,
              inactiveColor: Colors.black,
              value:value.currentSliderValue >value.allCodes.length.toDouble()?value.allCodes.length.toDouble(): value.currentSliderValue,
              max: value.slider_max_position,
              label: value.currentSliderValue.round().toString(),
              onChanged: (double slider_input) {
                value.slide(slider_input);
              },
            ),
          ),
          //-------------Total BarCode : Text
          Text("Total BarCode: ${ value.currentSliderValue.toInt()}",style: TextStyle(
            fontSize: h*.030,
            fontWeight: FontWeight.w500,
            ),
          ),
          //-------------SHow Barcode if file has been selected
          if(value.findHer.isNotEmpty)Container(
            margin: EdgeInsets.only(top: h*.01),
            decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.black54,blurRadius: 4,offset: Offset(2,2),
              )],
                color: Colors.blue[200],
                borderRadius: const BorderRadius.all(Radius.circular(50))
            ),
            width: w*.2,
            height:h*.08,
            child:  ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(w*.03)))),
              child: Text("Show Barcodes",style:TextStyle(fontWeight: FontWeight.w500,fontSize: h *.0220)),
              onPressed:(){
                Navigator.pushNamed(context, 'BarCodePrintingPage');
              },
            ),
          ),
        ],
      ),
    );
  }
}