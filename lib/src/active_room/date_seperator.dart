import 'package:flutter/material.dart';

class DateSeperator extends StatelessWidget {
  final DateTime date;
  const DateSeperator({required this.date, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 59,
      child: Row(children: [
        const Divider(color: Color.fromRGBO(207, 228, 255, 1)),
        const SizedBox(
          width: 16,
        ),
        Text(date.toString())
      ]));
}
