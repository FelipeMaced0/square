import 'package:flutter/material.dart';

class SquareSwitch extends StatefulWidget {
  ///The default colors of the switch are [white](opaque) and [black](opaque) in the active and inactive states
  SquareSwitch({
    Key key,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white,
    this.activeTrackColor = Colors.black,
    this.inactiveTrackColor = Colors.black,
    @required this.onChange,
    this.buttonHeight = 25,
    this.buttonWidth = 50,
    this.thumbWidth = 25,
  }) : super(key: key);

  ///The [activeColor] will be the color when swich is ON.
  final Color activeColor;

  ///The [inactiveColor] will be the color when switch is OFF.
  final Color inactiveColor;

  ///The [activeTrackColor] will be the track color when switch is ON.
  final Color activeTrackColor;

  ///The [inactiveTrackColor] will be the track color when switch is OFF.
  final Color inactiveTrackColor;

  ///The [onChange] is the Function provided by the developer, used to know the actual state of switch ON/OFF.
  final Function onChange;

  ///Button Height
  final double buttonHeight;
  
  ///Button Width
  final double buttonWidth;
  
  ///Thumb Width. The Thumb Height will be the same as the track height.
  final double thumbWidth;

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
    _controller = AnimationController(vsync: this);
    _animation = Tween<Alignment>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticIn,
        reverseCurve: Curves.elasticOut,
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
    final _buttonHeight = widget.buttonHeight ?? 25;
    final _buttonWidth = widget.buttonWidth ?? 50;
    final _thumbWidth = widget.thumbWidth ?? 25;
    _controller.duration = Duration(milliseconds: (15 * _thumbWidth.toInt()));
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, widGet) {
        return GestureDetector(
          onTap: () {
            _animate();
            if(widget.onChange!=null) widget.onChange();
          },
          child: Container(
            width: _buttonWidth,
            height: _buttonHeight,
            decoration: BoxDecoration(
                color: _controller.isCompleted
                    ? widget.activeTrackColor
                    : widget.inactiveTrackColor,
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
        );
      },
    );
  }

  ///This function play the animation forward or in reverse based on the state of the animation.
  ///If completed, play in reverse otherwise play forward.
  _animate() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }
}
