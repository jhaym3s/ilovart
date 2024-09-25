import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({super.key});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =  AnimationController(vsync: this, duration: const Duration(milliseconds:900))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..repeat();
    _animation = Tween(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.ease),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        transform: Matrix4.identity()..rotateY((0 - _animation.value) * pi),
        alignment: FractionalOffset.center,
        child: Image.asset("assets/images/icon.png", height: 100, width: 75,)
      ),
    );
  }}

  void showOverlayLoader(BuildContext context){
    context.loaderOverlay.show(showOverlay: true);
  }

  void hideOverlayLoader(BuildContext context){
    context.loaderOverlay.hide();
  }
