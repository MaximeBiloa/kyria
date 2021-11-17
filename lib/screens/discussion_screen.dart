import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:kyria/providers/core/api/api_provider.dart';

import 'package:kyria/providers/core/app/discussion_provider.dart';
import 'package:kyria/providers/models/discussion_model.dart';
import 'package:kyria/screens/inbox_screen.dart';
import 'package:kyria/screens/welcome_module.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/extensions.dart';
import 'package:kyria/utils/formated_date.dart';
import 'package:kyria/utils/local_datas.dart';
import 'package:kyria/utils/local_user_infos_preferences.dart';
import 'package:kyria/utils/varialbles.dart';
import 'package:shimmer/shimmer.dart';

import 'components/discussion_container.dart';
import 'components/requestwidget.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({Key? key}) : super(key: key);

  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  //API PROVIDER
  late ApiProvider apiProvider;
  late DatabaseReference kyriaClientDiscussionReference;
  late DatabaseReference userReference;
  late DiscussionProvider discussionProvider;

  late dynamic listen;
  //Current menu button
  bool welcomeButton = true;
  bool discussionButton = false;
  bool settingsButton = false;
  bool avisButton = false;

  //START ANIMATION TEST
  bool animationStart = true;

  @override
  void initState() {
    super.initState();
    apiProvider = new ApiProvider();

    //Instanciation of Discussion class
    discussionProvider = new DiscussionProvider();

    //Initialization of firebase database instance
    FirebaseDatabase database = FirebaseDatabase.instance;

    //Set database reference for discussion of kyria and client
    kyriaClientDiscussionReference = database.reference().child('discussions');

    if (localUserInfos.type == 'admin') {
      //Listen all discussions of this discussion reference, this part of code is loop
      listen = kyriaClientDiscussionReference.onChildAdded
          .listen(_discussionOnChildAdded);
    }
  }

  void _discussionOnChildAdded(Event event) {
    //Initialization of firebase database instance
    FirebaseDatabase database = FirebaseDatabase.instance;

    //Get key of discussion
    String? discussionKey = event.snapshot.key;

    //DiscussionProvider.removeDiscussion(discussionKey!);

    //Get data of this discussion
    dynamic discussionDatas = event.snapshot.value;

    //Then, get user informations and generate final discussion format
    String userKey = discussionKey!;

    userReference = database.reference().child('users').child(userKey);
    userReference.onValue.listen((event) {
      //Get user key
      String? userkey = event.snapshot.key;
      dynamic userDatas = event.snapshot.value;

      //Formated hour
      DateTime brutHour =
          DateTime.fromMillisecondsSinceEpoch(discussionDatas['formated_hour']);

      String formated_hour =
          "${formatedNumber(brutHour.hour)}:${formatedNumber(brutHour.second)}";

      // Generate final discussion datas
      dynamic finalDiscussionDatas = {
        'user_photo': userDatas['photo'],
        'user_name': userDatas['name'],
        'last_msg': discussionDatas['last_msg'],
        'formated_hour': formated_hour,
        'online_state': discussionDatas['online_state'],
        'non_lu': discussionDatas['non_lu'],
        'discussion_key': discussionKey
      };
      //DateTime.now().microsecondsSinceEpoch
      if (mounted)
        setState(() {
          listeDiscussions.insert(0, finalDiscussionDatas);
        });
    });
  }

  //DISCUSSION CONTAINER
  Widget discussionContainer(dynamic discussion) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onHover: (value) {},
        onTap: () {
          listen.cancel();
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => InboxScreen(
                  currentDiscussion: discussion,
                  discussionType: 1,
                ),
                transitionDuration: Duration.zero,
              )).then((value) {
            setState(() {
              listeDiscussions = [];
              //Listen all discussions of this discussion reference, this part of code is loop
              listen = kyriaClientDiscussionReference.onChildAdded
                  .listen(_discussionOnChildAdded);
            });
          });
        },
        hoverColor: themeMode
            ? Color(0xFF3C474D).withOpacity(0.25)
            : Colors.grey.shade100,
        child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(left: 22, right: 22),
          padding: EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Positioned(
                      child: CachedNetworkImage(
                        imageUrl: discussion.user_photo,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.transparent,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 7,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: greenColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 18,
              ),
              Expanded(
                child: Container(
                  //color: Colors.blue,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                //color: Colors.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${discussion.user_name}',
                                      style: TextStyle(
                                        fontFamily: 'myriad_bold',
                                        fontSize: 16,
                                        color: themeMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '${discussion.last_msg}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'myriad_regular',
                                        fontSize: 16,
                                        color: themeMode
                                            ? Color(0xFFB2B2B2)
                                            : Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    '${discussion.formated_hour}',
                                    style: TextStyle(
                                      fontFamily: 'myriad_semibold',
                                      fontSize: 12.5,
                                      color: themeMode
                                          ? Colors.white.withOpacity(0.5)
                                          : Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  /* if (discussion.non_lu != 0)
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: blueColor,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Text(
                                          '${discussion.non_lu}',
                                          style: TextStyle(
                                            fontFamily: 'myriad_semibold',
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                */
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        height: 1.5,
                        color: themeMode
                            ? Color(0xFFD2D2D2).withOpacity(0.2)
                            : Colors.grey.shade300,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //WELCOME ANIMATED CONTAINER
  Widget welcomeAnimatedContainer() {
    return Container(
      color: themeMode ? Colors.black : Colors.white,
      child: Center(
        child: Container(
          width: context.screenWidth,
          color: themeMode ? Color(0xFF3C474D).withOpacity(0.2) : Colors.white,
          child: Stack(
            children: [
              AnimatedPositioned(
                top: !animationStart ? -1000 : 0,
                bottom: 0,
                left: 0,
                right: 0,
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 1200),
                child: AnimatedContainer(
                  curve: Curves.decelerate,
                  duration: Duration(milliseconds: 1000),
                  width: 200,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("Je viens de sortir de l'écran");
  }

  @override
  Widget build(BuildContext context) {
    return animationStart
        ? welcomeAnimatedContainer()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: themeMode ? themeAppColor : Colors.white,
              elevation: 0,
              toolbarHeight: 70,
              iconTheme:
                  IconThemeData(color: themeMode ? Colors.white : Colors.black),
              brightness: Brightness.dark,
              //leadingWidth: 30,
              title: Container(
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
                    appTitle,
                    style: TextStyle(
                        fontFamily: 'myriad_bold',
                        fontSize: 16,
                        color: themeMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
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
                                child: GestureDetector(
                                  onTap: () {
                                    for (int i = 0;
                                        i < listeDiscussions.length;
                                        i++) {
                                      dynamic firebaseDiscussionFormat = {
                                        'last_msg': DiscussionModel.fromJson(
                                                listeDiscussions[i])
                                            .last_msg,
                                        'formated_hour': DateTime.now()
                                            .microsecondsSinceEpoch,
                                        'online_state':
                                            DiscussionModel.fromJson(
                                                    listeDiscussions[i])
                                                .online_state,
                                        'non_lu': DiscussionModel.fromJson(
                                                listeDiscussions[i])
                                            .non_lu,
                                        'user_key': 'user-test',
                                      };
                                      discussionProvider.saveDiscussion(
                                          firebaseDiscussionFormat);
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/images/notification-line.png',
                                    width: 20,
                                    height: 20,
                                  ),
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
                      ],
                    ),
                  ),
                ],
              )),
            ),
            backgroundColor: Colors.transparent,
            drawer: Drawer(
              elevation: 1,
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Container(
                    color: themeMode ? themeAppColor : Colors.white,
                    child: Column(
                      children: [
                        DrawerHeader(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: localUserInfos.photo,
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey.shade200,
                                      highlightColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.grey.shade200,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${localUserInfos.username}',
                                    style: TextStyle(
                                        fontFamily: 'myriad_bold',
                                        fontSize: 16,
                                        color: themeMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    '${localUserInfos.email}',
                                    style: TextStyle(
                                      fontFamily: 'myriad_regular',
                                      fontSize: 14,
                                      color: themeMode
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 26,
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: themeMode
                                                ? Colors.transparent
                                                : Colors.grey.shade300)),
                                    child: FlutterSwitch(
                                        value: themeMode,
                                        height: 26,
                                        width: 50,
                                        toggleColor: themeMode
                                            ? blueColor
                                            : Colors.grey.shade500,
                                        activeColor: themeMode
                                            ? Color(0xFFE2E2E2).withOpacity(0.3)
                                            : Colors.white,
                                        inactiveColor: themeMode
                                            ? Color(0xFFE2E2E2).withOpacity(0.1)
                                            : Colors.white,
                                        onToggle: (value) {
                                          setState(() {
                                            themeMode = !themeMode;
                                            themeAppColor = themeMode
                                                ? darkAppBackgroundColor
                                                : lightAppBackgroundColor;
                                          });
                                          LocalUserInfoPreferences
                                              .saveThemeMode(themeMode);
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                Positioned(
                  child: Container(
                    color: themeAppColor,
                    child: Column(
                      children: [
                        Expanded(
                          child: welcomeButton
                              ? WelcomeModule()
                              : Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      padding: EdgeInsets.only(bottom: 10),
                                      //color: Colors.pink.withOpacity(0.3),
                                      child: Center(
                                        child: Container(
                                          height: 45,
                                          padding: EdgeInsets.only(left: 25),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: themeMode
                                                      ? Colors.grey.shade800
                                                      : Colors.grey.shade300),
                                              color: themeMode
                                                  ? Color(0xFFE2E2E2)
                                                      .withOpacity(0.1)
                                                  : Colors.white),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/search-line.png',
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0),
                                                child: TextFormField(
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'myriad_regular',
                                                      fontSize: 16,
                                                      color: themeMode
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          'Rechercher . . .',
                                                      hintStyle: TextStyle(
                                                        fontFamily:
                                                            'myriad_regular',
                                                        fontSize: 17,
                                                        color: Colors
                                                            .grey.shade400,
                                                      ),
                                                    )),
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    //Discussion list content
                                    Expanded(
                                      child: Container(
                                        height: 44,
                                        padding:
                                            EdgeInsets.only(top: 0, bottom: 0),
                                        decoration: BoxDecoration(
                                            color: themeMode
                                                ? Color(0xFF3C474D)
                                                    .withOpacity(0.08)
                                                : Colors.white),
                                        child: Scrollbar(
                                          thickness: 2,
                                          child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount:
                                                  listeDiscussions.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var discussion =
                                                    DiscussionModel.fromJson(
                                                        listeDiscussions[
                                                            index]);

                                                return discussionContainer(
                                                  discussion,
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        /*Container(
                    height: 28,
                    color:
                        themeMode ? Color(0xFFE2E2E2).withOpacity(0.1) : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: MoveWindow(),
                        ),
                        WindowsButtons(themeMode: themeMode),
                      ],
                    ),
                  ),
                  */
                        if (localUserInfos.type == 'admin')
                          Container(
                            height: 70,
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            child: Column(
                              children: [
                                Divider(
                                  height: 2,
                                  color: themeMode
                                      ? Colors.grey.shade800
                                      : Colors.grey.shade400,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      new Material(
                                        child: new InkWell(
                                            onTap: () {
                                              setState(() {
                                                discussionButton = false;
                                                welcomeButton = true;
                                                settingsButton = false;
                                                avisButton = false;
                                                appTitle = 'KYRIA';
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  welcomeButton
                                                      ? 'assets/images/apps-over.png'
                                                      : 'assets/images/apps-normal.png',
                                                  width: 25,
                                                  height: 25,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'ACCUEIL',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontFamily: 'myriad_bold',
                                                      fontSize: 14,
                                                      color: welcomeButton
                                                          ? blueColor
                                                          : themeMode
                                                              ? Colors
                                                                  .grey.shade500
                                                              : Colors.grey
                                                                  .shade600,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                        color: Colors.transparent,
                                      ),
                                      new Material(
                                        child: new InkWell(
                                            onTap: () {
                                              setState(() {
                                                discussionButton = true;
                                                welcomeButton = false;
                                                settingsButton = false;
                                                avisButton = false;
                                                appTitle = 'KYRIA SUPPORT';
                                              });
                                            },
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  right: 0,
                                                  left: 30,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Image.asset(
                                                      discussionButton
                                                          ? 'assets/images/chat-over.png'
                                                          : 'assets/images/chat-normal.png',
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'DISCUSSIONS',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'myriad_bold',
                                                          fontSize: 14,
                                                          color:
                                                              discussionButton
                                                                  ? blueColor
                                                                  : themeMode
                                                                      ? Colors
                                                                          .grey
                                                                          .shade500
                                                                      : Colors
                                                                          .grey
                                                                          .shade600,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        color: Colors.transparent,
                                      ),
                                      new Material(
                                        child: new InkWell(
                                            onTap: () {
                                              setState(() {
                                                discussionButton = false;
                                                welcomeButton = false;
                                                settingsButton = false;
                                                avisButton = true;
                                                appTitle = 'AVIS KYRIA';
                                              });
                                            },
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  right: 0,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Image.asset(
                                                      avisButton
                                                          ? 'assets/images/pencil-line-over.png'
                                                          : 'assets/images/pencil-line.png',
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'AVIS',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'myriad_bold',
                                                          fontSize: 14,
                                                          color: avisButton
                                                              ? blueColor
                                                              : themeMode
                                                                  ? Colors.grey
                                                                      .shade500
                                                                  : Colors.grey
                                                                      .shade600,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        color: Colors.transparent,
                                      ),
                                      new Material(
                                        child: new InkWell(
                                            onTap: () {
                                              setState(() {
                                                discussionButton = false;
                                                welcomeButton = false;
                                                settingsButton = true;
                                                avisButton = false;
                                                appTitle = 'PARAMETRES';
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  settingsButton
                                                      ? 'assets/images/settings-over.png'
                                                      : 'assets/images/settings-normal.png',
                                                  width: 25,
                                                  height: 25,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'PARAMETRES',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontFamily: 'myriad_bold',
                                                      fontSize: 14,
                                                      color: settingsButton
                                                          ? blueColor
                                                          : themeMode
                                                              ? Colors
                                                                  .grey.shade500
                                                              : Colors.grey
                                                                  .shade600,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                        color: Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (localUserInfos.type == 'client')
                  Positioned(
                    bottom: 15,
                    right: 16,
                    child: ClipOval(
                      child: Material(
                        color: greenColor, // Button color
                        child: InkWell(
                          splashColor:
                              greenColor.withOpacity(0.2), // Splash color
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          InboxScreen(
                                    currentDiscussion: {},
                                    discussionType: 0,
                                  ),
                                  transitionDuration: Duration.zero,
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Image.asset('assets/images/icon-support.png',
                                width: 30),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            /*floatingActionButton: FloatingActionButton(
        backgroundColor: greenColor,
        child: Image.asset('assets/images/icon-support.png', width: 30),
        tooltip: 'Écrire au support de Kyria',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => InboxScreen()));
        },
      ),*/
          );
  }
}
