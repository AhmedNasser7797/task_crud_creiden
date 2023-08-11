import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final String iconPath;
  final Color? color;
  const AppLogo({
    Key? key,
    this.width,
    this.height,
    this.iconPath = "assets/svg/balto.svg",
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      fit: BoxFit.cover,
      width: width,
      height: height,
      color: color,
    );
  }
}
