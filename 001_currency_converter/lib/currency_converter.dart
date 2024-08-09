import 'package:flutter/material.dart';

class CurrencyConverterApp extends StatefulWidget {
  const CurrencyConverterApp({super.key});

  @override
  State createState() => _StateWidget<CurrencyConverterApp>();
}

class _StateWidget<CurrencyConverterApp> extends State {
  final TextEditingController textEditingController = TextEditingController();
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF000000),
        appBar: AppBar(
          backgroundColor: Color(0xFF242424),
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Currency Converter'),
          // actions: const [Icon(Icons.monetization_on_rounded)],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: const SizedBox(
                  height: 200,
                  child: const Column(
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFAFAFA)),
                      ),
                      Text("World",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFAFAFA))),
                    ],
                  ),
                ),
              ),
              Text(
                'INR ${result == 0 ? '0' : result.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFAFAFA)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  showCursor: true,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Color(0xFF000000)),
                  decoration: const InputDecoration(
                    hintText: "enter your amount",
                    hintStyle: TextStyle(color: Color(0xFF000000)),
                    prefixIcon: Icon(Icons.monetization_on_rounded),
                    prefixIconColor: Color(0xFF000000),
                    // labelText: "Enter your amount",
                    // labelStyle: TextStyle(color: Colors.white)
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF000000),
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF000000),
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (textEditingController.text != '') {
                        setState(() {
                          result =
                              double.parse(textEditingController.text) * 83.98;
                        });
                      } else {
                        setState(() {
                          result = 0;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 15,
                        shadowColor: Colors.white38,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    child: const Text(
                      'Convert',
                      // style: TextStyle(color: Colors.red),
                    )),
              )
            ],
          ),
        ));
  }
}


/* ---- stateless widget ---- */

// class CurrencyConverterMaterialPage extends StatelessWidget {
//   const CurrencyConverterMaterialPage({super.key});

//   void something() {
//     print('hello');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController textEditingController = TextEditingController();
//     double result = 0;

//     return Scaffold(
//         backgroundColor: const Color(0xFF000000),
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 36, 36, 36),
//           foregroundColor: Colors.white,
//           centerTitle: true,
//           title: const Text('Currency Converter'),
//           // actions: const [Icon(Icons.monetization_on_rounded)],
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Column(
//                 children: [
//                   Text(
//                     "Hello",
//                     style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFFFAFAFA)),
//                   ),
//                   Text("World",
//                       style: TextStyle(
//                           fontSize: 50,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFFFAFAFA))),
//                 ],
//               ),
//               Text(
//                 result.toString(),
//                 style: const TextStyle(
//                     fontSize: 100,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xFFFAFAFA)),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: TextField(
//                   controller: textEditingController,
//                   keyboardType: TextInputType.number,
//                   showCursor: true,
//                   cursorColor: Colors.amber,
//                   style: const TextStyle(color: Color(0xFF000000)),
//                   decoration: const InputDecoration(
//                     hintText: "enter your amount",
//                     hintStyle: TextStyle(color: Color(0xFF000000)),
//                     prefixIcon: Icon(Icons.monetization_on_rounded),
//                     prefixIconColor: Color(0xFF000000),
//                     // labelText: "Enter your amount",
//                     // labelStyle: TextStyle(color: Colors.white)
//                     filled: true,
//                     fillColor: Colors.white,
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             color: Color(0xFF000000),
//                             width: 2,
//                             style: BorderStyle.solid),
//                         borderRadius: BorderRadius.all(Radius.circular(20))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             color: Color(0xFF000000),
//                             width: 2,
//                             style: BorderStyle.solid),
//                         borderRadius: BorderRadius.all(Radius.circular(20))),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: ElevatedButton(
//                     onPressed: () {
//                       result = double.parse(textEditingController.text) * 83;
//                       print(result);
//                     },
//                     style: ElevatedButton.styleFrom(
//                         elevation: 15,
//                         shadowColor: Colors.amber,
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.black,
//                         minimumSize: const Size(double.infinity, 50),
//                         shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15)))),
//                     child: const Text(
//                       'Convert',
//                       // style: TextStyle(color: Colors.red),
//                     )),
//               )
//             ],
//           ),
//         ));
//   }
// }
