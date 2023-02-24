import 'package:flutter/material.dart';

class Hover extends StatefulWidget {
  final Color color;
  final Color defaultColor;
  final Widget child;
  const Hover(
      {required this.color,
      required this.child,
      this.defaultColor = Colors.transparent,
      Key? key})
      : super(key: key);

  @override
  State<Hover> createState() => _HoverState();
}

class _HoverState extends State<Hover> {
  Color? color;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (details) => setState(() {
        color = widget.color;
      }),
      onExit: (details) => setState(() {
        color = widget.defaultColor;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color ?? widget.defaultColor),
        child: widget.child,
      ),
    );
  }
}
