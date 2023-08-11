import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final double width;
  final double height;
  final double? iconSize;
  const CustomBackButton({
    Key? key,
    required this.height,
    required this.width,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffE3E3E3),
      ),
      child: Icon(
        Icons.arrow_back_ios_outlined,
        color: const Color(0xff707070).withOpacity(0.7),
        size: iconSize ?? height * 0.6,
      ),
    );
  }
}

class CustomForwardButton extends StatelessWidget {
  final double width;
  final double height;
  final double? iconSize;

  const CustomForwardButton({
    Key? key,
    required this.height,
    required this.width,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffE3E3E3),
      ),
      child: Icon(
        Icons.arrow_forward_ios_outlined,
        color: const Color(0xff707070).withOpacity(0.7),
        size: iconSize ?? height * 0.6,
      ),
    );
  }
}
