import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///转场动画组件
class HeroWidget extends StatelessWidget{
  const HeroWidget({super.key, this.width, this.height, required this.tag, required this.child, this.onTap });
  final double? width;
  final double? height;
  final String tag;
  final Widget child;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: height,
      width: width,
      child: InkWell(onTap: onTap, child: Hero(tag: tag, child: child),)
    );
  }
}