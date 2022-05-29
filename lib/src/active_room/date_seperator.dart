import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const seperatorColor = Color.fromRGBO(207, 228, 255, 1);

class DateSeperator extends StatelessWidget {
  final DateTime date;
  const DateSeperator({required this.date, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 59,
      child: Row(children: [
        const SizedBox(
          width: 60,
          child: Divider(
            color: seperatorColor,
            thickness: 1,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          _dateSeperatorString(),
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: seperatorColor),
        )
      ]));
  String _dateSeperatorString() {
    if (date.day == DateTime.now().day) {
      return "Today ${DateFormat("dd/MM").format(date)}";
    } else {
      return DateFormat("EEEE dd/MM").format(date);
    }
  }
}
