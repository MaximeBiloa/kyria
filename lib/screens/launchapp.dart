import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kyria/providers/core/app/auth_provider.dart';
import 'package:kyria/providers/core/app/user_provider.dart';
import 'package:kyria/providers/models/user_model.dart';
import 'package:kyria/screens/auth/login.dart';
import 'package:kyria/screens/discussion_screen.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/local_datas.dart';
import 'package:kyria/utils/local_user_infos_preferences.dart';
import 'package:kyria/utils/varialbles.dart';
import 'package:kyria/utils/extensions.dart';

class LaunchApp extends StatefulWidget {
  const LaunchApp({Key? key}) : super(key: key);

  @override
  _LaunchAppState createState() => _LaunchAppState();
}

class _LaunchAppState extends State<LaunchApp> {
  //Auth Provider
  late AuthProvider _authProvider;
  bool connexionSuccess = false;

  @override
  void initState() {
    super.initState();

    LocalUserInfoPreferences.getThemeMode().then((themeM) {
      setState(() {
        themeMode = themeM == null ? false : themeM;
        themeAppColor =
            themeMode ? darkAppBackgroundColor : lightAppBackgroundColor;
      });
    });

    _authProvider = new AuthProvider();
    LocalUserInfoPreferences.getUserProfile().then((infos) {
      if (infos['email'] == null) {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => Login(),
              transitionDuration: Duration.zero,
            ));
      } else {
        //LOGIN PROCESS
        _authProvider.signIn(infos).then((value) {
          setState(() {
            if (value == true) {
              //GET USER DATAS
              UserProvider userProvider =
                  new UserProvider(uid: _authProvider.getUid());

              userProvider.getUserInfos().then((userInfos) {
                setState(() {
                  String user_key = userInfos.key!;
                  dynamic user_datas = userInfos.value;

                  localUserInfos = new UserModel.fromJson({
                    'key': user_key,
                    'username': user_datas['username'],
                    'name': user_datas['name'],
                    'surname': user_datas['surname'],
                    'email': user_datas['email'],
                    'genre': user_datas['genre'],
                    'cni': user_datas['cni'],
                    'date_naissance': user_datas['date_naissance'],
                    'phone': user_datas['phone'],
                    'photo': user_datas['photo'],
                    'type': user_datas['type'],
                    'status_account': user_datas['status_account'],
                  });
                });

                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          DiscussionScreen(),
                      transitionDuration: Duration.zero,
                    ));
              });
            }
          });
        });
      }
      print("Email : ${infos['email']}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: themeMode ? Colors.black : Colors.white,
        child: Center(
          child: Container(
            width: context.screenWidth,
            color:
                themeMode ? Color(0xFF3C474D).withOpacity(0.2) : Colors.white,
            child: Stack(
              children: [
                AnimatedPositioned(
                  top: connexionSuccess ? -1000 : 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  curve: Curves.decelerate,
                  duration: Duration(milliseconds: 1200),
                  child: AnimatedContainer(
                    curve: Curves.decelerate,
                    duration: Duration(milliseconds: 1000),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 150,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AnimatedOpacity(
                  opacity: connexionSuccess ? 0 : 1,
                  duration: Duration(milliseconds: 1000),
                  child: Container(
                    margin: EdgeInsets.only(top: 250),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Connexion en cours',
                            style: TextStyle(
                              fontFamily: 'myriad_regular',
                              fontSize: 16,
                              color: themeMode ? Colors.white : Colors.black,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        SpinKitThreeBounce(
                          color: blueColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
