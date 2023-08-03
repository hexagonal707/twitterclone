import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final Color? colorSchemeSeed;
  final EdgeInsetsGeometry padding;

  const CustomElevatedButton({
    Key? key,
    required this.padding,
    this.child,
    this.onPressed,
    this.colorSchemeSeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Theme(
        data: ThemeData(
            brightness: Theme.of(context).brightness == Brightness.light
                ? Brightness.light
                : Brightness.dark,
            useMaterial3: true,
            fontFamily: 'Inter',
            colorSchemeSeed: colorSchemeSeed),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 50.0),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
