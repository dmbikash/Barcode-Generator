import 'package:barcode_generator/provider/xl_read_provider.dart';
import 'package:flutter/material.dart';

class FileList extends StatelessWidget {
  const FileList({
    Key? key,
    required this.value,
    required this.h,
    required this.w,
  }) : super(key: key);

  final ExcelProvider value;
  final double h;
  final double w;
  @override
  Widget build(BuildContext context) {
    // here the files will be shown
    return Container(
       //color: Colors.red.withOpacity(.4),
      //color: Colors.black,
      height: value.parentFlag.contains(true)?  value.parent.length* (h *.35) <= h*.65? value.parent.length* (h *.35): h*.65 : h*.35, //h*.65 : h*.35,
      width:value.parentFlag.contains(true)? w*.5:w*.35,
      margin: EdgeInsets.all(w*.02),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: value.parent.length,
          itemBuilder: (BuildContext context, indexParent){
            //---------------------All the files will be shown in this container
            return Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black54,blurRadius: 4,offset: Offset(2,2),
                )],
                borderRadius: value.parentFlag.contains(true)?const BorderRadius.all(Radius.circular(10)) :BorderRadius.all(Radius.circular(w*.03)) ,
                color:value.parentFlag.contains(true)? Colors.grey[300]: Colors.black ,
              ),
              margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              padding: EdgeInsets.only(left: w*.02,top: h*.014,bottom:  h*.014,right: w*.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*
                       this row has two views
                       1.First it will show the parents only
                       2.After a click it will show parent and its child
                  */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //each parent is a button
                      TextButton(onPressed: () {
                        bool temp =value.parentFlag[indexParent] ;
                        value.parentFlag[indexParent]=!temp;
                        value.notifyListeners();
                      },
                          child: Text(value.parent[indexParent], style: TextStyle(
                            color: value.parentFlag.contains(true)? Colors.black :Colors.white,
                            fontSize:  h*.024,
                          ),
                          )
                      ),
                      // if parent file is selected the child list will appear is this container
                      if(value.parentFlag[indexParent])Container(
                        //color: Colors.pink[200],
                        height: h*.085*value.child[indexParent].length <= h*.4? h*.085*value.child[indexParent].length : h*.4,
                        width: w*.242,
                        child: ListView.builder(
                            itemCount: value.child[indexParent].length,
                            itemBuilder: (BuildContext context, indexChild){
                              // for each children there are two parts. child name and checkbox
                              //row contains checkbox and child name
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius:(BorderRadius.all(Radius.circular(w*.03),)),
                                  color: Colors.white,
                                ),
                                // row contains child name and checkbox will appear here
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                                  children: [
                                    //child name container
                                    Container(
                                        padding: const EdgeInsets.all(7),
                                        margin: const EdgeInsets.all(2),
                                        child: Text(value.child[indexParent][indexChild],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: h*.018,
                                          fontWeight: FontWeight.w500
                                        ),
                                        )
                                    ),
                                    //check box
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.all(2),
                                      child: Checkbox(
                                        hoverColor: Colors.redAccent.withOpacity(.2),
                                        activeColor: Colors.redAccent,
                                        value: value.selectChildFlag[indexParent][indexChild],
                                        onChanged: (bool? newValue) {
                                          value.selectChildFlag[indexParent][indexChild]=newValue!;
                                         // print(value.selectChildFlag);
                                          if(value.selectChildFlag[indexParent][indexChild]) {
                                            value.tempFindHer.add(indexParent.toString()+indexChild.toString());
                                          }
                                          if(!value.selectChildFlag[indexParent][indexChild]){
                                            try{
                                              value.tempFindHer.remove(indexParent.toString()+indexChild.toString());
                                            }catch(e){
                                              print("jhamela hoise selection e");
                                            }
                                          }
                                         // print(value.tempFindHer);
                                        //  print("listening from file list");
                                          value.notifyListeners();
                                        },
                                      ),
                                    )

                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}