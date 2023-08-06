import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitterclone/data/post_data.dart';

class CustomCardHeader extends StatelessWidget {
  final String? primaryHeading;
  final String? secondaryHeading;
  final String? tertiaryHeading;
  final double? primaryHeadingFontSize;
  final double? secondaryHeadingFontSize;
  final double? tertiaryHeadingFontSize;
  final FontWeight? primaryHeadingFontWeight;
  final FontWeight? secondaryHeadingFontWeight;
  final FontWeight? tertiaryHeadingFontWeight;
  final Color? primaryHeadingColor;
  final Color? secondaryHeadingColor;
  final Color? tertiaryHeadingColor;
  final bool arrow;
  final TextOverflow? overflow;
  final void Function()? onTap;
  final int? maxLines;
  final bool? softWrap;
  final String? imageUrl;
  final Widget child;

  const CustomCardHeader({
    Key? key,
    this.primaryHeading,
    required this.arrow,
    this.onTap,
    this.secondaryHeading,
    this.primaryHeadingColor,
    this.secondaryHeadingColor,
    this.primaryHeadingFontSize,
    this.primaryHeadingFontWeight,
    this.secondaryHeadingFontSize,
    this.secondaryHeadingFontWeight,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.tertiaryHeading,
    this.tertiaryHeadingFontSize,
    this.tertiaryHeadingFontWeight,
    this.tertiaryHeadingColor,
    this.imageUrl,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<PostDataProvider>(
        builder: (context, provider, child) => InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '$primaryHeading',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: primaryHeadingColor,
                            fontSize: primaryHeadingFontSize,
                            fontWeight: primaryHeadingFontWeight),
                      ),
                      Text(
                        '$secondaryHeading',
                        style: TextStyle(
                            color: secondaryHeadingColor,
                            fontSize: secondaryHeadingFontSize,
                            fontWeight: secondaryHeadingFontWeight),
                      ),
                      Text(
                        '$tertiaryHeading',
                        style: TextStyle(
                            color: tertiaryHeadingColor,
                            fontSize: tertiaryHeadingFontSize,
                            fontWeight: tertiaryHeadingFontWeight),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: arrow
                    ? <Widget>[
                        this.child,
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child:
                              Icon(Icons.arrow_forward_ios_rounded, size: 20.0),
                        ),
                      ]
                    : [],
              ),
            ],
          ),
        ),
      );
}
