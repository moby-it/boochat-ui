import 'package:flutter/cupertino.dart';

class OnlineDot extends StatelessWidget {
  const OnlineDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: Color.fromRGBO(26, 205, 130, 1)),
    );
  }
}
