import 'package:flutter/material.dart';

ButtonStyle authButtonStyle(Color background, Color forground) {
  return ButtonStyle(
    minimumSize: MaterialStateProperty.all<Size>(
      const Size.fromHeight(40.0),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(background),
    foregroundColor: MaterialStateProperty.all<Color>(forground),
  );
}

// * Custom Outline button style
ButtonStyle customOutlineStyle() {
  return ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
            color: Color(0xff242424), width: 0.1, style: BorderStyle.solid),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff242424)),
    minimumSize: MaterialStateProperty.all(Size.zero),
    padding: MaterialStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    ),
  );
}
