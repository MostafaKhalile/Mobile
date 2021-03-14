import 'package:flutter/material.dart';

class SkeletonAnimation extends StatefulWidget {
  final double height;
  final double width;
  final double padding;
  final double radius;
  final Border border;
  SkeletonAnimation(
      {Key key,
      this.height = 20,
      this.width = 200,
      this.radius = 0.0,
      this.padding = 0.0,
      this.border})
      : super(key: key);
  @override
  _SkeletonAnimationState createState() => _SkeletonAnimationState();
}

class _SkeletonAnimationState extends State<SkeletonAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation gradientPostion;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1200), vsync: this);

    gradientPostion = Tween<double>(begin: -3, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.all(widget.padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          border: widget.border,
          gradient: LinearGradient(
              begin: Alignment(gradientPostion.value, 0),
              end: Alignment(-1, 0),
              colors: [
                Colors.grey[400],
                Colors.grey[500],
                Colors.grey[400],
              ])),
    );
  }
}
