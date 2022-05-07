import 'package:flutter/material.dart';

class CardFlexibleSimple extends StatelessWidget {
  final String urlImage;
  final String text;

  const CardFlexibleSimple({
    Key? key,
    required this.urlImage,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                image: DecorationImage(
                  image: AssetImage(urlImage),
                  fit: BoxFit.cover,
                ),
              ),
              width: MediaQuery.of(context).size.height * 0.13,
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FittedBox(
                child: Text(
                  text, // max: 27 caracteres
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(12),
            //   height: 100,
            //   width: 200,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: const [
            //       Text(
            //         'Carne', // max: 27 caracteres
            //         style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
