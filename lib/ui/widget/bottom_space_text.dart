
import 'package:flutter/cupertino.dart';

class BottomSpaceText extends StatelessWidget{

  BottomSpaceText(
      this.child,
      {super.key,
        this.paddingBottom = 0,
      }
      );
  double paddingBottom;
  Text child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: child,
    );
  }
}