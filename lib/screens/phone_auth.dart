// import 'package:flutter/material.dart';
// import 'package:flip_card/flip_card.dart';
// import '../palette.dart';
// import 'package:flutter/services.dart';
// import 'package:pin_code_text_field/pin_code_text_field.dart';
// import './CreatProfile.dart';
//
// class phone_auth extends StatefulWidget {
//   const phone_auth() : super();
//
//   @override
//   State<phone_auth> createState() => _phone_authState();
// }
//
// class _phone_authState extends State<phone_auth> {
//   GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
//   final phoneController = TextEditingController();
//   final TextEditingController _textEditingController =
//       new TextEditingController();
//   void submitNumber() {
//     print("insert number submission here");
//     FocusScope.of(context).requestFocus(new FocusNode());
//     phoneController.clear();
//     cardKey.currentState?.toggleCard();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: primary,
//         body: Center(
//           child: SingleChildScrollView(
//               child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: 100,
//                 width: 100,
//                 child: Image.asset(
//                   'assets/images/icon.png',
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               const Text("اهلاً بك في دوّار",
//                   textAlign: TextAlign.center,
//                   textDirection: TextDirection.rtl,
//                   style: Wheader),
//               Container(
//                   width: double.infinity,
//                   margin: const EdgeInsets.symmetric(
//                     vertical: 10,
//                     horizontal: 15,
//                   ),
//                   child: FlipCard(
//                       key: cardKey,
//                       flipOnTouch: false,
//                       front: Card(
//                         elevation: 20,
//                         child: Container(
//                           padding: EdgeInsets.all(5),
//                           child: Column(children: [
//                             const Text("ادخل رقم الهاتف",
//                                 textAlign: TextAlign.end,
//                                 textDirection: TextDirection.rtl,
//                                 style: Gparagraph),
//                             SizedBox(
//                                 height: 50,
//                                 width: 200,
//                                 child: TextField(
//                                     style: Gparagraph,
//                                     decoration: InputDecoration(
//
//                                       hintText: '09xxxxxxxx',
//                                       prefixStyle: Gparagraph,
//                                       border: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: primary, width: 2.0),
//                                           borderRadius:
//                                               BorderRadius.circular(25.0)),
//                                       focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: primary, width: 2.0),
//                                           borderRadius:
//                                               BorderRadius.circular(25.0)),
//                                     ),
//                                     controller: phoneController,
//                                     keyboardType: TextInputType.number,
//                                     inputFormatters: [
//                                       FilteringTextInputFormatter.allow(
//                                           RegExp(r'^\d+\.?\d{0,4}'))
//                                     ])),
//                             TextButton(
//                               child: Text(
//                                 "تحقق",
//                                 style: Wparagraph,
//                               ),
//                               style: flatButtonStyle,
//                               onPressed: submitNumber,
//                             )
//                           ]),
//                         ),
//                       ),
//                       back: Card(
//                           elevation: 20,
//                           child: Container(
//                             padding: EdgeInsets.all(5),
//                             child: Column(children: [
//                               Text("ادخل رمز التحقق",
//                                   textAlign: TextAlign.end,
//                                   textDirection: TextDirection.rtl,
//                                   style: Gparagraph),
//                               PinCodeTextField(
//                                 autofocus: true,
//                                 controller: _textEditingController,
//                                 maxLength: 4,
//                                 highlight: true,
//                                 hasUnderline: false,
//                                 hideCharacter: true,
//                                 pinBoxColor: Colors.white,
//                                 highlightPinBoxColor: Colors.white,
//                                 onDone: (text) {
//                                   print(_textEditingController.text);
//                                 },
//                                 highlightColor: primary,
//                                 defaultBorderColor: primary,
//                                 hasTextBorderColor: primary,
//                                 maskCharacter: '*',
//                                 pinTextStyle: Gparagraph,
//                               ),
//                               TextButton(
//                                 child: Text(
//                                   "تأكيد",
//                                   style: Wparagraph,
//                                 ),
//                                 style: flatButtonStyle,
//                                 onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>  CreatProfile()));},
//                               )
//                             ]),
//                           ))))
//             ],
//           )),
//         ));
//   }
// }
// final ButtonStyle flatButtonStyle = TextButton.styleFrom(
//   primary: Colors.white,
//   minimumSize: Size(88, 44),
//   padding: EdgeInsets.symmetric(horizontal: 16.0),
//   shape: const RoundedRectangleBorder(
//     borderRadius: BorderRadius.all(Radius.circular(2.0)),
//   ),
//   backgroundColor: primary,
// );
//
