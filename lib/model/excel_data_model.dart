import 'package:flutter/material.dart';

class ExcelDataModel {
  Map getData(List data) {

      List list = [[' Device/Product', ' MONITOR', 'x1', 'x2'],
        ['Device/Product', ' mouse', 'y1', 'y2'],
        [ 'new/old', ' LAPTOP', ' z1', 'z2',],
      ];

       list=data;

      //print(list);
      var parentMap = Map();
      String parent = "";
      // var childMap =Map();
      for (int i = 0; i < list.length; i++) {
        // print("yes");
        List eachList = list[i];
        parent = eachList[0].toString().trim();
        String child = eachList[1].toString().trim();
       // print("ashsi");
        for (int j = 0; j < 2; j++) {
          eachList.removeAt(0);
        }
        var childMap = Map();
        childMap.addEntries(
            [
              MapEntry(child, eachList),
            ]
        );
       // print("child");
       // print(childMap); //-----------------
        if (!parentMap.containsKey(parent.toString().trim())) {
          //print(parent);
          // print(i);
         // print("no");
          parentMap.addEntries(
              [
                MapEntry(parent, childMap),
              ]
          );
        } else {
          //print("yes");
          parentMap[parent].addEntries(
              [
                MapEntry(child, eachList),
              ]
          );
        }
        //print("parent");
        //print(parentMap);
      }

//     parentMap.addEntries(
//         [
//           MapEntry(parent,childMap),
//         ]
//     );
      //print(childMap);
      print(parentMap);
  return  parentMap;
  }
  }
