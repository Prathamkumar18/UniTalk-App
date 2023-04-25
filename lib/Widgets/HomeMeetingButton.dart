import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeMeetingButton extends StatefulWidget {
  final Icon icon;
  final String text;
  final VoidCallback onPressed;
  const HomeMeetingButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

  @override
  State<HomeMeetingButton> createState() => _HomeMeetingButtonState();
}

class _HomeMeetingButtonState extends State<HomeMeetingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 160,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 225, 235, 249),
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        InkWell(
          onTap: widget.onPressed,
          child: Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(20)),
            child: widget.icon,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.text,
          style:
              TextStyle(color: Color.fromARGB(255, 74, 74, 74), fontSize: 18),
        ),
      ]),
    );
  }
}
