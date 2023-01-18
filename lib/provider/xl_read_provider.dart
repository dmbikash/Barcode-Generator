import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';

import '../model/excel_data_model.dart';



class ExcelProvider with ChangeNotifier{

  Map data =Map();
  // Map data= {
  //   "Device" : {
  //     "D-mouse": ['mouse1','mouse2','mouse3'],
  //     "D-keyboard": ['keyboard','keyboard2','keyboard3'],
  //     "D-ups": ['ups','ups','ups'],
  //   },
  //   "Kfc" : {
  //     "K-mouse": ['mouse1','mouse2','mouse3'],
  //     "k_keyboard": ['keyboard1','keyboard2','keyboard3'],
  //     "K-ups": ['ups1','ups2','ups3'],
  //   },
  //
  // };

  // List parent =["Device","kfc"];
  // List parentFlag=[false, false];
  List parent =[];
  List parentFlag=[];

  void makeParent(Map data){
    // for (var key in data.keys) {
    //   print(key);
    parent =[];
    parentFlag=[];
    for (var key in data.keys) {
      parent.add(key.toString().trim());
      parentFlag.add(false);
    }
  //  print('parent');
  //  print(parent);
  }

  List<List<String>> child=[]; //[[D-mouse, D-keyboard, D-ups], [K-mouse, k_keyboard, K-ups]]
 // List<List<String>> child = [['D-mouse', 'D-keyboard', 'D-ups','D-mouse', 'D-keyboard', 'D-ups','D-mouse', 'D-keyboard', 'D-ups','D-mouse', 'D-keyboard', 'D-ups',], ['K-mouse', 'k_keyboard', 'K-ups']] ;
  List<List<bool>> selectChildFlag=[];
  void makeChild(data){
    child=[];
    selectChildFlag=[];
    for(int i=0; i<parent.length;i++){
      List <String>temp=[];
      List <bool>tempFlag=[];
      for (var key in data[parent[i]].keys) {
        //print(key);
        temp.add(key);
        tempFlag.add(false);
      }
      child.add(temp);
      selectChildFlag.add(tempFlag);
    }
   // print('child');
  //  print(child);
   // print(selectChildFlag);
  }

  bool importedExcelFiles=false;
  bool showBarCodes=false;







  List <String> findHer = [];
  List  <String> tempFindHer = [];
  String history="";





  List allCodes=[];
  List<List> result =[] ;

  late String parentKey ;
  late String childKey;
  late int parentIndex;
  late int childIndex;


  List findBarcode(String codex){
    //print("codex");
    //print(codex);
     parentIndex = int.parse(codex[0]);
     childIndex = int.parse(codex[1]);
    //print(parentIndex );
   // print(childIndex );
    //print("ok--1");
   // print(parent);
   // print(child);
   // print("ok--xxx");
    parentKey =parent[parentIndex];
     childKey =child[parentIndex][childIndex];

  //  print(parentKey);
  //  print(childKey);
    Map childData = data[parentKey];
    List children = childData[childKey];
    return children;
  }


  void finalBox(){
  // List findHer = ["01","03"];
    List temp = [];
    result=[];
    for(int i=0; i<findHer.length; i++){
      temp=findBarcode(findHer[i]);
      result.add(temp);
     // print('result');
     // print(result);
      logMaker(result[i]);

    //  print(result);
   //   print("okk---2");
    }
   // print('result');
   // print(result);
    codes(result);
  }

  void codes(result){
    allCodes=[];
    for(int i=0; i<result.length; i++){
      List tempfile =result[i];
      for(int j=0; j<tempfile.length; j++){
        allCodes.add(tempfile[j].toString());

      }
    }
    slider_max_position= allCodes.length.toDouble();
    currentSliderValue= slider_max_position;
   // print(allCodes);
    notifyListeners();
  }




//----------
  Map colselog = {
    'parent' : '',
    'child'  : '',
    'totalItems' : "",
    'time' : '',
  };



void logMaker( List result){
  history="";
  String start = "Barcode History \n";
  String catagory = "Catagory: ${parent[parentIndex]} \n Item Name: ${ child [parentIndex][childIndex]} \n";
  String amount = "Item's Amount: ${ result.length}\n";
  //print(start+catagory+amount);
  history= (start+catagory+amount);


}





























 // -------















  double currentSliderValue = 0;
  double excel_data_amount = 0;
  double slider_max_position = 0;
  List<dynamic> barcodes =[];
  int noOfBarcodes =0;
  String? filePath;
  void pickFile(BuildContext context) async {

    final resultFile = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (resultFile == null) return;
   // print("ase");
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
   // print("result files.first.name");
   // print(result.files.first.name);
   // print("result.files.first.path");
    filePath = resultFile.files.first.path!;
   // print(filePath);


    ///
    //var file = "Path_to_pre_existing_Excel_File/excel_file.xlsx";
    try{
      var bytes = File(filePath!).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
     // print(excel.tables);
      barcodes =[];
      for (var table in excel.tables.keys) { //{Sheet1: Instance of 'Sheet', Sheet2: Instance of 'Sheet'}
       // print("table------------------"); //sheet Name
       // print(table); //sheet Name
       // print("column no");
      //  print(excel.tables[table]!.maxCols);
        noOfBarcodes = excel.tables[table]!.maxRows;
       // print("row no");
       // print(excel.tables[table]!.maxRows);
        //print(excel.tables[table]);
        for (var row in excel.tables[table]!.column) {
          Iterable code =row.map((e) => e?.value);
          dynamic eachColumnCodes=[];
          for(final element in code) {
          //  print("element print korchi");
            //print(element);
            if(element !=null)eachColumnCodes.add(element);
          }
          barcodes.add(eachColumnCodes);
        }
        break;

        // String text = barcodes[3];
        // List<String> result = text.split(',');
        // print("MMH ----------- MMH");
        // print(result[0]);
        // print(result[1]);
        // print(result[2]);

      }

      //print(barcodes[0]);
      barcodes[0].removeAt(0);
      //print(barcodes);
      ExcelDataModel Exceldata = ExcelDataModel();

      data=Exceldata.getData(barcodes);
    //  print("data");
     // print(data);
      findHer =[];
      tempFindHer=[];
      allCodes=[];
      slider_max_position=0;
      currentSliderValue=0;
      makeParent(data);
      makeChild(data);

     // print("gese data eceldatamodel e");

      if(barcodes.length>0)excel_data_amount = barcodes.length.toDouble()-1;
      //currentSliderValue=slider_max_position;
      //print(barcodes.length);

      //print(barcodes[3]);
      //print(barcodes[3][1]);
      if(excel_data_amount>0){
        importedExcelFiles = true;
      }
      notifyListeners();
     // print(barcodes[10]);
    }
    on FormatException{
      print("FormatException");
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('File Did not Upload!!!'),
          content: const Text('Please select an exel (.xlxs) file'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }catch(e){
      print("Exception piais  ${e} ");
    }
  }
    void slide(double x){
      currentSliderValue = x;
      notifyListeners();
    }

}