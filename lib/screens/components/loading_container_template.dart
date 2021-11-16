import 'package:flutter/material.dart';
import 'package:kyria/utils/varialbles.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class LoadingContainerTemplate extends StatefulWidget {
  LoadingContainerTemplate(
      {required this.width,
      required this.height,
      required this.radiusbottomLeft,
      required this.radiusbottomRight,
      required this.radiustopLeft,
      required this.radiustopRight});
  double width;
  double height;
  double radiustopLeft;
  double radiustopRight;
  double radiusbottomLeft;
  double radiusbottomRight;

  @override
  _LoadingContainerTemplateState createState() =>
      _LoadingContainerTemplateState();
}

class _LoadingContainerTemplateState extends State<LoadingContainerTemplate> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
          themeMode ? Color(0xFFE2E2E2).withOpacity(0.1) : Colors.grey.shade300,
      highlightColor:
          themeMode ? Color(0xFFE2E2E2).withOpacity(0.2) : Colors.grey.shade200,
      period: Duration(milliseconds: 1200),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: themeMode ? Colors.red.shade900 : Colors.grey.shade400,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.radiustopLeft),
                topRight: Radius.circular(widget.radiustopRight),
                bottomLeft: Radius.circular(widget.radiusbottomLeft),
                bottomRight: Radius.circular(widget.radiusbottomRight))),
      ),
    );
  }
}
