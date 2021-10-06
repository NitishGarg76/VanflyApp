import 'package:flutter/material.dart';

class TaskBarButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final Color onTapColor;
  final Color labelColor;

  TaskBarButton({this.label, this.onTap, this.onTapColor, this.labelColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink[100]),
            color: onTapColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),

            boxShadow: [
              BoxShadow(
                  color: Colors.pink[100],
                  offset: Offset(-2, -1),
                  blurRadius: 5),
            ],
          ),
          child: Center(
              child: Text(
            label,
            style: TextStyle(
                fontSize: 18, color: labelColor, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
