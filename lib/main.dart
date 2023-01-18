
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:barcode_generator/provider/xl_read_provider.dart';
import 'package:barcode_generator/screen/barcode_printing%20page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/home.dart';


void main() {
  runApp(
    MultiProvider(providers:
    [
      ChangeNotifierProvider(create: (_) => ExcelProvider())
    ],child: MyApp(),

    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => AnimatedSplashScreen(
          splash: const Text("Barcode Generator",
          style: TextStyle(
            fontSize: 50,
            color: Colors.black,
            letterSpacing: .2,
            fontWeight: FontWeight.w500
          ),
          ),
          nextScreen: Home(),
          duration:1000,
          splashTransition: SplashTransition.fadeTransition,
          ),
        'BarCodePrintingPage': (context) => BarCodePrintingPage(),

      },
    );
  }
}





//---------------do not delete the bellow comments------


///// ///////////////////////////////////////////////////////////
//                                                              /
// if (_maxRows > 0 && maxCols > 0) {                           /
// _data = List.generate(maxCols, (colIndex) {                  /
// print(colIndex);                                             /
// print('colIndex');                                           /
// return List.generate(_maxRows, (rowIndex) {                  /
// if (_sheetData[rowIndex] != null &&                          /
// _sheetData[rowIndex]![colIndex] != null) {                   /
// return _sheetData [rowIndex]![colIndex];                     /
// }                                                            /
// return null;                                                 /
// });                                                          /
// });                                                          /
// }                                                            /
///// ///////////////////////////////////////////////////////////

