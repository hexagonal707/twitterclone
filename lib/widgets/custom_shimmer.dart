import 'package:flutter/material.dart';

Widget showShimmer(
    {required BuildContext context,
    required double? height,
    required double? width,
    double topPadding = 0.0,
    double bottomPadding = 0.0}) {
  return Padding(
    padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
    child: SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).focusColor
              : Theme.of(context).focusColor,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    ),
  );
}
