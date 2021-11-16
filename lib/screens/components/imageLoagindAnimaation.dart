import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageLoadingAnimation extends StatefulWidget {
  const ImageLoadingAnimation({Key? key}) : super(key: key);

  @override
  _ImageLoadingAnimationState createState() => _ImageLoadingAnimationState();
}

class _ImageLoadingAnimationState extends State<ImageLoadingAnimation> {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: Colors.blue.shade600,
      size: 50.0,
    );
  }
}
