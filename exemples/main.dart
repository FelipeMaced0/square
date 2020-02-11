import 'package:flutter/material.dart';
import 'package:square_switch/square.dart';

void main() => runApp(Exemple());


class Exemple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SquareSwitch(),
        ],
      ),
    );
  }
}