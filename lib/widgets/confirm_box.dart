import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmBox extends StatelessWidget {
  final String title, text;
  final VoidCallback callback;
  const ConfirmBox({
    required this.text,
    required this.title,
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: const Color(0xff242424),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 3.5,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(text: "Yes continue", onPressed: callback),
                SimpleBtn1(
                  text: "Cancel",
                  onPressed: () {
                    Get.back();
                  },
                  invertedColors: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  const SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      Key? key})
      : super(key: key);

  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          alignment: Alignment.center,
          side: MaterialStateProperty.all(const BorderSide(
            width: 1,
            color: Colors.red,
          )),
          padding: MaterialStateProperty.all(const EdgeInsets.only(
            right: 25,
            left: 25,
            top: 0,
            bottom: 0,
          )),
          backgroundColor: MaterialStateProperty.all(
              invertedColors ? accentColor : Colors.red),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          )),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: invertedColors ? Colors.red : accentColor, fontSize: 16),
      ),
    );
  }
}
