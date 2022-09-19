import '../../app/constants/constants.dart';
import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(ksecondaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
