import 'package:dinner_assistant_flutter/core/theme/my_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? darkColor;
  final Color? lightColor;

  final double? height;
  final double? width;

  const PrimaryButton({
    Key? key,
    required this.child,
    this.onTap,
    this.height,
    this.darkColor,
    this.width,
    this.lightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient:
              LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, stops: const [
            0.4,
            0.6
          ], colors: [
            darkColor ?? MyColors.primaryDarkColor,
            lightColor ?? MyColors.primaryDarkColor,
          ])),
      height: height ?? 45,
      width: width ?? double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), side: BorderSide.none),
          ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
            ],
          )),
    );
  }
}
