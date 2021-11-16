import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/varialbles.dart';

// ignore: must_be_immutable
class AuthProcessLoading extends StatefulWidget {
  AuthProcessLoading(
      {required this.requestTitle, required this.requestSubtitle});
  String requestTitle;
  String requestSubtitle;

  @override
  _AuthProcessLoadingState createState() => _AuthProcessLoadingState();
}

class _AuthProcessLoadingState extends State<AuthProcessLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeAppColor,
      child: Center(
        child: Container(
          color: themeMode ? Color(0xFF3C474D).withOpacity(0.25) : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCube(
                color: greenColor,
                size: 80,
              ),
              SizedBox(height: 50),
              Text(widget.requestTitle,
                  style: TextStyle(
                      fontFamily: 'myriad_semibold',
                      fontSize: 17,
                      color: themeMode
                          ? Colors.grey.shade400
                          : Colors.grey.shade900,
                      fontWeight: FontWeight.w800)),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.requestSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'myriad_light',
                      fontSize: 15,
                      height: 1.4,
                      color: themeMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade700,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
