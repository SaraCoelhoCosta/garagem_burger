import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComboBox extends StatelessWidget {
  final String? value;
  /// Recebe um Map de 'id' e 'descricao', que corresponderam ao [value]
  /// e [child] do [DropdownMenuItem], respectivamente.
  final List<Map<String, String>>? items;
  final void Function(String?)? onChanged;

  const ComboBox({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(left: 12, right: 8),
        child: DropdownButton<String>(
          menuMaxHeight: kMinInteractiveDimension * 3 + 10,
          underline: Container(),
          dropdownColor: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          value: value,
          style: GoogleFonts.oxygen(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          items: items!.map((item) {
            return DropdownMenuItem<String>(
              value: item['id'],
              child: Text(item['descricao']!),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
