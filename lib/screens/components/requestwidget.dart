import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class RequestLoading extends StatefulWidget {
  RequestLoading({required this.requestTitle});
  String requestTitle;
  @override
  _RequestLoadingState createState() => _RequestLoadingState();
}

class _RequestLoadingState extends State<RequestLoading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitFadingCircle(
          color: Colors.blue.shade600,
          size: 70.0,
        ),
        SizedBox(
          height: 20,
        ),
        Text(widget.requestTitle,
            style: TextStyle(
                fontFamily: 'myriad_regular',
                fontSize: 16.5,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w800)),
      ],
    );
  }
}
