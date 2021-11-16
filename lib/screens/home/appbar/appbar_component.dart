import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/extensions.dart';

class AppBarComponent extends StatefulWidget {
  AppBarComponent({required this.themeMode});
  bool themeMode;

  @override
  _AppBarComponentState createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      //color: Colors.indigo,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Logo container
          Container(
            //color: Colors.red.withOpacity(0.3),
            width: context.screenWidth / 3.88,
            child: Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      //Logo image
                      Image.asset(
                        'assets/images/logo.png',
                        width: 41,
                        height: 41,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                //Title of App
                Text(
                  'KYRIA SUPPORT',
                  style: TextStyle(
                      fontFamily: 'myriad_bold',
                      fontSize: 15,
                      color: widget.themeMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            height: 40,
            padding: EdgeInsets.only(left: 18),
            //color: Colors.blue.withOpacity(0.3),
            child: Row(
              children: [
                Container(
                  //color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ACCUEIL',
                        style: TextStyle(
                            fontFamily: 'myriad_regular',
                            fontSize: 14,
                            color:
                                widget.themeMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 28,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      //color: Colors.green.withOpacity(0.2),
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'DISCUSSIONS',
                        style: TextStyle(
                            fontFamily: 'myriad_bold',
                            fontSize: 14,
                            color: blueColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 28,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      //color: Colors.green.withOpacity(0.2),
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PARAMETRES',
                        style: TextStyle(
                            fontFamily: 'myriad_regular',
                            fontSize: 14,
                            color:
                                widget.themeMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 28,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      //color: Colors.green.withOpacity(0.2),
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CONDITIONS D'UTILISATION",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'myriad_regular',
                            fontSize: 14,
                            color:
                                widget.themeMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 28,
                ),
                Expanded(
                  child: Container(
                    width: 30,
                    height: 40,
                    //color: Colors.indigo,
                    child: Stack(
                      children: [
                        //Logo image
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          //right: 0,
                          child: Image.asset(
                            'assets/images/notification-line.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Positioned(
                          left: 12,
                          top: 8,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
