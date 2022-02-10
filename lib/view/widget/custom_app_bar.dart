import 'package:dinner_assistant_flutter/core/theme/my_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 50.0;
  final bool hasBack;

  const CustomAppBar({Key? key, required this.hasBack, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Row(
        mainAxisAlignment: hasBack ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          hasBack
              ? const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: BackButton(
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              MyColors.primaryDarkColor,
              MyColors.primaryDarkColor.withOpacity(0.8),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
