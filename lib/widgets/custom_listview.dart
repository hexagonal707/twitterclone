import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  final void Function()? onTap;
  final String text;
  final IconData icon;
  final double? iconSize;

  const CustomListView(
      {Key? key,
      this.onTap,
      required this.text,
      required this.icon,
      this.iconSize})
      : super(key: key);

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        child: Row(
          children: [
            Icon(widget.icon, size: widget.iconSize),
            const SizedBox(width: 15.0),
            Text(
              widget.text,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
