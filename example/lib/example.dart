import 'package:flutter/material.dart';
import 'package:square/square.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Default'),
                SquareSwitch(
                  onChange: () {},
                ),
              ],
            ),
            SquareSwitch(
              activeTrackColor: Colors.pink,
              inactiveTrackColor: Colors.redAccent,
              onChange: () {},
            ),
            SquareSwitch(
              activeTrackColor: Colors.lime,
              inactiveTrackColor: Colors.brown,
              onChange: () {},
            ),
            SquareSwitch(
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.cyan,
              onChange: () {},
            ),
          ],
        ),
      ),
    );
  }
}
