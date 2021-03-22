import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotateWidget extends StatefulWidget {
  final Widget child;
  final double height;
  final double width;
  const RotateWidget({this.child, this.height = 100, this.width = 100});
  _RotateWidgetState createState() => _RotateWidgetState();
}

class _RotateWidgetState extends State<RotateWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  _RotateWidgetState();
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animation.addListener(() {
      setState(() {
        print(animation.value.toString());
      });
    });
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     //   animationController.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     //   animationController.forward();
    //   }
    // });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedLogo(
      child: widget.child,
      animation: animation,
      height: widget.height,
      width: widget.width,
    ));
  }
}

class AnimatedLogo extends AnimatedWidget {
  final Widget child;
  final double width;
  final double height;
  final GlobalKey _scaffoldKey = new GlobalKey();
  final Tween<double> _sizeAnimation = Tween<double>(begin: 0.0, end: 200.0);
  AnimatedLogo({this.width, this.height, this.child, Animation animation})
      : super(listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Transform.rotate(
      key: _scaffoldKey,
      // scale: _sizeAnimation.evaluate(animation),
      angle: animation.value * 2 * math.pi,
      child: Container(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
          child: child,
        ),
      ),
    );
  }
}
