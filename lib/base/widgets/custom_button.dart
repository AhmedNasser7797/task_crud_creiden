import 'package:flutter/material.dart';

import '../../core/theme/theme_data.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? titleColor;
  final double? fontSize;
  final double? width;
  final double height;
  final double radius;

  final double? iconWidth;
  final double? iconHeight;

  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.color,
      this.width,
      this.height = 60,
      this.radius = 35,
      this.fontSize,
      this.iconHeight = 8,
      this.iconWidth = 5,
      this.titleColor,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff030091),
              Color(0xff254DDE),
              Color(0x66254DDE),
              Color(0xff00FFFF),
            ],
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(title,
            style: buttonStyle(context)?.copyWith(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: titleColor,
            )),
      ),
    );
  }
}
