import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  final String text;
  final bool isMuted;
  final Function(bool) onChanged;
  final Icon icon;
  const Options({
    Key? key,
    required this.text,
    required this.isMuted,
    required this.onChanged,
    required this.icon,
  }) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.icon,
              SizedBox(
                width: 10,
              ),
              Text(
                widget.text,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Switch(value: widget.isMuted, onChanged: widget.onChanged),
        ],
      ),
    );
  }
}
