// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TelaMeusLanchesVazio extends StatelessWidget {
//   const TelaMeusLanchesVazio({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         ListView(
//           shrinkWrap: true,
//           children: [
//             const Icon(Icons.fastfood, size: 100),
//             const SizedBox(height: 15),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 SizedBox(
//                   height: 150,
//                   width: 300,
//                   child: TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       'MONTE SEU PRÓPRIO HAMBÚRGUER',
//                       style: GoogleFonts.oxygen(
//                         fontSize: 35,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       top: 60, bottom: 60, left: 50, right: 50),
//                   child: Text(
//                     'Você ainda não montou nenhum lanche.',
//                     style: GoogleFonts.oxygen(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//             Text(
//               'Dê um nome as suas criações, e elas aparecerão aqui.',
//               style: GoogleFonts.oxygen(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20)
//           ],
//         ),
//       ],
//     );
//   }
// }
