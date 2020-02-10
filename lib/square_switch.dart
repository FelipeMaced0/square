library square_switch;

import 'package:flutter/material.dart';

const double widthButton = 50;
const double heightButton = widthButton / 2;
const double phi = 1.61803398875;

enum Side {
  longest,
  smolest,
}

//pass a length side and a mode, the function will return a value
//for the longest one or for the smolest
int getGoldenSide(double b, Side side) {
  return side == Side.smolest ? (b * phi).floor() : (b / phi).floor();
}

class SquareSwitch extends StatefulWidget {
  /// the [activeColor] will be the color when the switch is on
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTrackColor;
  final Color inactiveTackColor;
  final Function onChange;

  SquareSwitch({
    Key key,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white,
    this.activeTrackColor = Colors.black,
    this.inactiveTackColor = Colors.black,
    this.onChange,
  }) : super(key: key);

  @override
  _SquareSwitchState createState() => _SquareSwitchState();
}

class _SquareSwitchState extends State<SquareSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<Alignment>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
        reverseCurve: Curves.elasticIn,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, widGet) {
        return GestureDetector(
          onTap: () {
            _animate();
            if (widget.onChange != null) {
              widget.onChange();
            }
          },
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Container(
              height: heightButton,
              width: widthButton,
              decoration: BoxDecoration(
                  color: _controller.isCompleted
                      ? widget.activeTrackColor
                      : widget.inactiveTackColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Align(
                alignment: _animation.value,
                child: Container(
                  width: heightButton,
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: _controller.isCompleted
                        ? widget.activeColor
                        : widget.inactiveColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _animate() {
    setState(() {
      if (_controller.isCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }
}
