import 'package:flutter/material.dart';

Color selectedColor = Colors.pink[400];

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final bool selected;
  final Function onPressed;

  CategoryCard({this.icon, this.name, this.selected, this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _selected ? selectedColor : Colors.pink[50],
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: _selected ? 10 : 5,
                color: _selected ? selectedColor : Colors.pinkAccent,
              )
            ],
          ),
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Icon(
                  icon,
                  color: _selected ? selectedColor : Colors.black,
                  size: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _selected ? selectedColor : Colors.black,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
