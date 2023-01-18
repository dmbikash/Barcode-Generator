import 'package:barcode_generator/provider/xl_read_provider.dart';
import 'package:flutter/material.dart';
import 'package:barcode_generator/screen/components/fileList.dart';
class SelectFilesBox extends StatelessWidget {
  const SelectFilesBox({
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
      height: h*.85, //value.parentFlag.contains(true)? h*.8:h*.5,
      width:w*.5,//value.parentFlag.contains(true)? w*.5:w*.35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 2),
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey[300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //header title ( select files )
          selectFilesHeader(),
          // list of files
          FileList(value: value, h: h, w: w),
          //submit button
          if(value.parentFlag.contains(true))ElevatedButton(
              onPressed: (){
                value.findHer=value.tempFindHer;
                value.noOfBarcodes;
                value.finalBox();
              //  print("notifying from select files");
                value.notifyListeners();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 40),
                elevation: 6,
                padding: EdgeInsets.symmetric(vertical: w*.01,horizontal: h*.01),
                backgroundColor: Colors.black,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              child:Text("Submit",
                style: TextStyle(
                  fontSize: h*.025,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ],
      ),
    );
  }



  Container selectFilesHeader() {
    return Container(
      width: w*.333,
      height: h*.05,
          decoration: BoxDecoration(

            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(w*.03)),
          ),
          margin: EdgeInsets.only(top: h*.01),
          child: Center(
            child: Text("Select Files",
              style: TextStyle(
                  color: Colors.black,
                  fontSize:  h*.028,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        );
  }
}

