library square_switch;

import 'package:flutter/material.dart';

const double _buttonWidth = 50;
const double _buttonHeight = 31;
const double _thumbWidth = 31;
const double phi = 1.61803398875;

enum Side {
  longest,
  smolest,
}

///This Function is for those who want display divine widgets.
///Give the length of which one side and choose the mode longest or smolest.
///Use the [Side] enum to informe the mode.
///If you give the smallest one then the Function returns the length of the longest side according to the golden ratio
///and vice versa.
///phi = a/b = 1.61803398875
double getGoldenSide(double b, Side side) {
  return side == Side.smolest ? (b * phi).floorToDouble() : (b / phi).floorToDouble();
}

class SquareSwitch extends StatefulWidget {

  SquareSwitch({
    Key key,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white,
    this.activeTrackColor = Colors.black,
    this.inactiveTackColor = Colors.black,
    this.onChange,
  }) : super(key: key);

  ///The [activeColor] will be the color when swich is ON.
  final Color activeColor;
  ///The [inactiveColor] will be the color when switch is OFF.
  final Color inactiveColor;
  ///The [activeTrackColor] will be the track color when switch is ON.
  final Color activeTrackColor;
  ///The [inactiveTrackColor] will be the track color when switch is OFF.
  final Color inactiveTackColor;
  ///The [onChange] is the Function provided by the programmer, used to know the actual state of switch ON/OFF.
  final Function onChange;

  

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
            widget.onChange ?? widget.onChange();
          },
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Container(
              width: _buttonWidth,
              height: _buttonHeight,
              decoration: BoxDecoration(
                  color: _controller.isCompleted
                      ? widget.activeTrackColor
                      : widget.inactiveTackColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Align(
                alignment: _animation.value,
                child: Container(
                  width: _thumbWidth,
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
  ///This function play the animation forward or in reverse based on the state of the animation.
  ///If completed, play in reverse otherwise play forward. 
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
