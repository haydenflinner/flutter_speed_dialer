library flutter_speed_dialer;


import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Button tailored to using with [SpeedDialer].
class SpeedDialerButton extends StatelessWidget {
  IconData icon;
  String text;
  Color foregroundColor;
  Color backgroundColor;
  Function onPressed;

  SpeedDialerButton({this.icon, this.text, this.foregroundColor, this.backgroundColor,
    this.onPressed});

  @override
  build(BuildContext context) {
    return new FloatingActionButton(
      backgroundColor: backgroundColor,
      mini: true,
      child: new Icon(icon, color: foregroundColor),
      onPressed: onPressed,
    );
  }

}

/// A FAB Speed Dialer that pops out buttons of your choice.
///
/// Consider using [SpeedDialerButton]s for ease of use.
class SpeedDialer extends StatefulWidget {
  /// Buttons that pop out upon tapping the FAB.
  List<Widget> children;

  SpeedDialer({this.children});

  @override
  State createState() => new SpeedDialerState();
}

class SpeedDialerState extends State<SpeedDialer> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    var children = widget.children ?? [];
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: new List.generate(children.length, (int index) {
        Widget child = new Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: new ScaleTransition(
            scale: new CurvedAnimation(
              parent: _controller,
              curve: new Interval(
                  0.0,
                  1.0 - index / children.length / 2.0,
                  curve: Curves.easeOut
              ),
            ),
            child: children[index],
          ),
        );
        return child;
      }).toList()..add(
        // TODO: Support customization of this button.
        new FloatingActionButton(
          child: new AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return new Transform(
                transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.PI),
                alignment: FractionalOffset.center,
                child: new Icon(_controller.isDismissed ? Icons.menu : Icons.close),
              );
            },
          ),
          onPressed: () {
            if (_controller.isDismissed) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
        ),
      ),
    );
  }
}
