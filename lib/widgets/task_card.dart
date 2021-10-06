import 'package:flutter/material.dart';



class TaskCard extends StatelessWidget {
  final Widget child;
  final String info;
  final String buttonText;
  final Function onPressed;

  TaskCard({this.buttonText, this.info, this.child, this.onPressed});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink[100]),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.pink[100],
                  offset: Offset(-2, -1),
                  blurRadius: 5),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child,
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(info,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 25,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
                  child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.pinkAccent,
                      child: MaterialButton(
                        onPressed: onPressed,
                        child: Text(
                          buttonText,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
