import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kyria/providers/core/app/message_provider.dart';
import 'package:kyria/providers/models/discussion_model.dart';
import 'package:kyria/providers/models/message_model.dart';
import 'package:kyria/providers/models/user_model.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/local_datas.dart';
import 'package:kyria/utils/varialbles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kyria/utils/extensions.dart';
import 'components/recevie_msg_container.dart';
import 'components/send_msg_container.dart';

class InboxScreen extends StatefulWidget {
  InboxScreen({required this.currentDiscussion, required this.discussionType});
  //This discussion can be a discussion model, in case where kyria discussion with current user
  // or default discussion, in case where user discuss with kyria
  dynamic currentDiscussion;
  //Check type of discussion (kyria to user = 1 or user to kyria = 0)
  int discussionType;

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  //Database reference
  late DatabaseReference messageOfDiscussionRef;
  //Message Provider
  late MessageProvider messageProvider;
  late TextEditingController messageInputController;
  late ScrollController scrollController;
  double scrollPosition = 0;
  String typingMsg = '';

  //WHEN USER PRESS TO LONG ON MESSAGE
  bool moreOptions = false;
  List keyMessageSelected = [];

  //CHECK IS MESSAGE IS REPLYING
  bool reply = false;
  //REPLY MESSAGE
  dynamic replyMsg = {};
  //CHECK IF MESSAGE SELECTED HAS BEEN SENDING BY CURRENT USER
  bool msgSelectedHasSendByMe = false;

  //DEFINE FOCUS
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    setState(() {
      listeMessages = [];
    });
    messageInputController = new TextEditingController();
    scrollController = new ScrollController();

    messageProvider = new MessageProvider();

    //Initialization of firebase database instance
    FirebaseDatabase database = FirebaseDatabase.instance;

    //Set database reference for messages of discussion
    messageOfDiscussionRef = widget.discussionType == 0
        ? database
            .reference()
            .child('users')
            .child(localUserInfos.key)
            .child('kyria-support-messages')
        : database
            .reference()
            .child('discussions')
            .child(widget.currentDiscussion.discussion_key)
            .child('messages');

    //Listen all discussions of this discussion reference, this part of code is loop
    messageOfDiscussionRef.onChildAdded.listen((event) {
      //Get key of message
      String? messageKey = event.snapshot.key;

      //DiscussionProvider.removeDiscussion(discussionKey!);

      //Get data of this message
      dynamic messageDatas = event.snapshot.value;

      //Final message
      dynamic finalMessage = {
        'key': messageKey,
        'user_photo': widget.discussionType == 1
            ? widget.currentDiscussion.user_photo
            : 'kyria-logo',
        'msg_content': messageDatas['msg_content'],
        'formated_date': messageDatas['formated_date'],
        'send_by': messageDatas['send_by'],
        'reply': messageDatas['reply'],
      };

      print(finalMessage);

      if (mounted) {
        setState(() {
          listeMessages.insert(0, finalMessage);
          scrollController.jumpTo(0);
        });
      }

      print("Le message est : ${messageDatas['reply']}");
    });
  }

  //TEMPLATE OF MESSAGE HAS BEEN SEND
  Widget sendMessageContainer(MessageModel msg) {
    return Material(
      color: Colors.transparent,
      child: new InkWell(
        onHover: (value) {},
        onLongPress: () {
          //CHECK IF MESSAGE SELECTED IS LIST OF SELECTED MESSAGE
          int index = keyMessageSelected.indexOf(msg.key);
          setState(() {
            if (index == -1) {
              keyMessageSelected.insert(0, msg.key);
              msgSelectedHasSendByMe = true;
            } else {
              keyMessageSelected.removeAt(index);
              msgSelectedHasSendByMe = checkAllMsgSelectedHasSendByMe();
            }
          });
          print(keyMessageSelected);
        },
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () {
          setState(() {
            //CHECK IF MESSAGE SELECTED IN LIST OF SELECTED MESSAGES
            int index = keyMessageSelected.indexOf(msg.key);
            setState(() {
              if (index != -1) {
                keyMessageSelected.removeAt(index);
                msgSelectedHasSendByMe = checkAllMsgSelectedHasSendByMe();
              } else {
                //CHECK IF LIST OF SELECTED MESSAGES IS NOT EMPTY TO ADD KEY
                if (keyMessageSelected.length != 0)
                  keyMessageSelected.insert(0, msg.key);
                msgSelectedHasSendByMe = true;
              }
            });
          });
        },
        splashColor: Colors.transparent,
        child: Container(
          color: keyMessageSelected.indexOf(msg.key) != -1
              ? blueColor.withOpacity(0.15)
              : Colors.transparent,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                curve: Curves.decelerate,
                left: keyMessageSelected.indexOf(msg.key) != -1 ? 26 : -26,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 11,
                    backgroundImage: AssetImage(
                      'assets/images/check.png',
                    ),
                    backgroundColor: blueColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child:
                                Wrap(alignment: WrapAlignment.end, children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 0,
                                    bottom: 10,
                                    left: context.screenWidth * 0.1,
                                    right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            //border: Border.all(color: Colors.grey.shade300),
                                            color: blueColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (msg.reply != null)
                                              Stack(
                                                children: [
                                                  Positioned(
                                                      child: Container(
                                                    height: 32,
                                                    color: Colors.blue.shade300,
                                                    width: 2,
                                                  )),
                                                  Container(
                                                    //color: themeMode ? Colors.black : Colors.white,
                                                    margin: EdgeInsets.only(
                                                        bottom: 5),
                                                    //width: context.screenWidth,

                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    color: Colors.transparent,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            // ignore: unrelated_type_equality_checks
                                                            msg.reply['send_by'] ==
                                                                    0
                                                                ? 'Vous'
                                                                : widget.discussionType !=
                                                                        1
                                                                    ? 'Kyria Support'
                                                                    : widget
                                                                        .currentDiscussion
                                                                        .user_name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'myriad_semibold',
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .blue
                                                                    .shade300,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        Text(
                                                            msg.reply[
                                                                'msg_content'],
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'myriad_regular',
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            Text(msg.msg_content,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      child: Text(msg.formated_date,
                                          style: TextStyle(
                                            color: themeMode
                                                ? Colors.grey.shade300
                                                : Colors.grey.shade600,
                                            fontSize: 11,
                                            fontFamily: 'myriad_regular',
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(
                              'assets/images/msg-send-light.png',
                              width: 18,
                              height: 18,
                            ),
                          )
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
    );
  }

  //TEMPLATE OF MESSAGE HAS RECEIVE
  Widget receiveMessageContainer(MessageModel msg) {
    return Material(
      color: Colors.transparent,
      child: new InkWell(
        onHover: (value) {},
        onLongPress: () {
          //CHECK IF MESSAGE SELECTED IS LIST OF SELECTED MESSAGE
          int index = keyMessageSelected.indexOf(msg.key);
          setState(() {
            if (index == -1) {
              keyMessageSelected.insert(0, msg.key);
              msgSelectedHasSendByMe = false;
            } else {
              keyMessageSelected.removeAt(index);
              msgSelectedHasSendByMe = checkAllMsgSelectedHasSendByMe();
            }
          });
          print(keyMessageSelected);
        },
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () {
          setState(() {
            //CHECK IF MESSAGE SELECTED IN LIST OF SELECTED MESSAGES
            int index = keyMessageSelected.indexOf(msg.key);
            setState(() {
              if (index != -1) {
                keyMessageSelected.removeAt(index);
                msgSelectedHasSendByMe = checkAllMsgSelectedHasSendByMe();
              } else {
                //CHECK IF LIST OF SELECTED MESSAGES IS NOT EMPTY TO ADD KEY
                if (keyMessageSelected.length != 0)
                  keyMessageSelected.insert(0, msg.key);
                msgSelectedHasSendByMe = false;
              }
            });
          });
        },
        splashColor: Colors.transparent,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.decelerate,
              right: keyMessageSelected.indexOf(msg.key) != -1 ? 26 : -26,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 11,
                  backgroundImage: AssetImage(
                    'assets/images/check.png',
                  ),
                  backgroundColor: blueColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: keyMessageSelected.indexOf(msg.key) != -1
                  ? blueColor.withOpacity(0.15)
                  : Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 40,
                    ),
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Positioned(
                          child: msg.user_photo != 'kyria-logo'
                              ? CachedNetworkImage(
                                  imageUrl: msg.user_photo,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey.shade200,
                                    highlightColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey.shade200,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                    'assets/images/logo.png',
                                  ),
                                ),
                        ),
                        if (msg.user_photo != 'kyria-logo')
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
                    width: 10,
                  ),
                  Expanded(
                    child: Wrap(alignment: WrapAlignment.start, children: [
                      Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(
                            top: 0,
                            bottom: 10,
                            left: 0,
                            right: context.screenWidth * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    /*border: Border.all(color: Colors.grey.shade300),
                                    boxShadow: themeMode
                                        ? []
                                        : [
                                            BoxShadow(
                                                color: Colors.grey.shade100,
                                                offset: Offset(0, 0),
                                                blurRadius: 0,
                                                spreadRadius: 0)
                                          ],*/
                                    color: themeMode
                                        ? Color(0xFFE2E2E2).withOpacity(0.1)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: themeMode
                                            ? Colors.transparent
                                            : Colors.grey.shade200)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (msg.reply != null)
                                      Stack(
                                        children: [
                                          Positioned(
                                              child: Container(
                                            height: 32,
                                            color: Colors.blue.shade300,
                                            width: 2,
                                          )),
                                          Container(
                                            //color: themeMode ? Colors.black : Colors.white,
                                            margin: EdgeInsets.only(bottom: 5),
                                            //width: context.screenWidth,

                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            color: Colors.transparent,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    // ignore: unrelated_type_equality_checks
                                                    msg.reply['send_by'] == 0
                                                        ? 'Vous'
                                                        : widget.discussionType !=
                                                                1
                                                            ? 'Kyria Support'
                                                            : widget
                                                                .currentDiscussion
                                                                .user_name,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'myriad_semibold',
                                                        fontSize: 15,
                                                        color: Colors
                                                            .blue.shade300,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                Text(msg.reply['msg_content'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'myriad_regular',
                                                        fontSize: 14,
                                                        color: themeMode
                                                            ? Colors
                                                                .grey.shade300
                                                            : Colors
                                                                .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    Text(msg.msg_content,
                                        style: TextStyle(
                                            color: themeMode
                                                ? Colors.grey.shade400
                                                : Colors.grey.shade600,
                                            fontSize: 17,
                                            fontFamily: 'myriad_regular',
                                            fontWeight: FontWeight.w500)),
                                  ],
                                )),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              child: Text(msg.formated_date,
                                  style: TextStyle(
                                    color: themeMode
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade600,
                                    fontSize: 11,
                                    fontFamily: 'myriad_regular',
                                  )),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic getMessageByKey(String key) {
    for (int i = 0; i < listeMessages.length; i++) {
      int indexMsg = i;
      if (listeMessages[indexMsg]['key'] == key) {
        return listeMessages[indexMsg];
      }
    }
  }

  bool checkAllMsgSelectedHasSendByMe() {
    for (int i = 0; i < keyMessageSelected.length; i++) {
      String msgKey = keyMessageSelected[i];
      if (getMessageByKey(msgKey)['send_by'] != 0) {
        return false;
      }
    }
    return true;
  }

  void deleteMsgAlert() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              titlePadding: EdgeInsets.all(0),
              title: Container(
                color: themeMode ? Colors.black : Colors.transparent,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(24),
                    color: themeMode
                        ? Color(0xFF3C474D).withOpacity(0.6)
                        : Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Supprimer le message',
                            style: TextStyle(
                                fontFamily: 'myriad_bold',
                                fontSize: 18,
                                color: Colors.red.shade400,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Voulez-vous vraiment supprimer ce message ?',
                            style: TextStyle(
                                fontFamily: 'myriad_regular',
                                fontSize: 16,
                                height: 1.4,
                                color: themeMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(15, 0),
                                  ),
                                  overlayColor: MaterialStateProperty.all(
                                      (Colors.transparent)),
                                  backgroundColor: MaterialStateProperty.all(
                                      (Colors.transparent)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                              child: Text(
                                'NON',
                                style: TextStyle(
                                    fontFamily: 'myriad_regular',
                                    fontSize: 15,
                                    color: themeMode
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade600,
                                    fontWeight: FontWeight.w500),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(15, 0),
                                  ),
                                  overlayColor: MaterialStateProperty.all(
                                      (Colors.transparent)),
                                  backgroundColor: MaterialStateProperty.all(
                                      (Colors.transparent)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                              child: Text(
                                'OUI',
                                style: TextStyle(
                                    fontFamily: 'myriad_regular',
                                    fontSize: 15,
                                    color: Colors.red.shade600,
                                    fontWeight: FontWeight.w700),
                              ),
                              onPressed: () {
                                for (int i = 0;
                                    i < keyMessageSelected.length;
                                    i++) {
                                  String msgKey = keyMessageSelected[i];
                                  if (widget.discussionType == 0) {
                                    messageProvider.deleteMessage(
                                        msgKey, false, 'null');
                                  } else {
                                    messageProvider.deleteMessage(
                                        msgKey,
                                        true,
                                        widget
                                            .currentDiscussion.discussion_key);
                                  }
                                  deleteMsgInMessageList(msgKey);
                                }
                                BotToast.showText(
                                    align: Alignment.center,
                                    textStyle: TextStyle(
                                        fontFamily: 'myriad_regular',
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    text: keyMessageSelected.length > 1
                                        ? 'Messages supprimés.'
                                        : 'Message supprimé.');

                                setState(() {
                                  keyMessageSelected = [];
                                });

                                Navigator.pop(context);

                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  bool deleteMsgInMessageList(msgKey) {
    for (int i = 0; i < listeMessages.length; i++) {
      int indexMsg = i;
      if (listeMessages[indexMsg]['key'] == msgKey) {
        listeMessages.removeAt(indexMsg);
        return true;
      }
    }
    return true;
  }

  void copyToClipBoard() {
    String textToClipBoard = '';
    for (int i = 0; i < keyMessageSelected.length; i++) {
      String msgKey = keyMessageSelected[i];
      textToClipBoard += "${getMessageByKey(msgKey)['msg_content']}\n";
    }
    Clipboard.setData(ClipboardData(text: textToClipBoard.trim()));
    BotToast.showText(
        align: Alignment.center,
        textStyle: TextStyle(
            fontFamily: 'myriad_regular',
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500),
        text: 'Copié dans le presse papier');
    setState(() {
      keyMessageSelected = [];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (keyMessageSelected.length != 0) {
          setState(() {
            keyMessageSelected = [];
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: themeMode ? themeAppColor : blueColor,
            elevation: 1.5,
            toolbarHeight: 70,
            brightness: Brightness.dark,
            iconTheme:
                IconThemeData(color: themeMode ? Colors.white : Colors.white),
            //leadingWidth: 10,
            title: Stack(
              children: [
                AnimatedPositioned(
                    top: keyMessageSelected.length == 0 ? -40 : 8,
                    left: -2,
                    duration: Duration(milliseconds: 500),
                    child: Text('${keyMessageSelected.length}',
                        style: TextStyle(
                            fontFamily: 'myriad_bold',
                            fontSize: 25,
                            color: themeMode ? Colors.white : Colors.white,
                            fontWeight: FontWeight.bold))),
                AnimatedPositioned(
                    top: 5,
                    bottom: 0,
                    right: keyMessageSelected.length == 0 ? -120 : 5,
                    curve: Curves.decelerate,
                    duration: Duration(milliseconds: 700),
                    child: Row(
                      children: [
                        AnimatedOpacity(
                          opacity: keyMessageSelected.length == 1 ? 1 : 0,
                          duration: Duration(milliseconds: 100),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  reply = true;
                                  replyMsg = MessageModel.fromJson(
                                      getMessageByKey(keyMessageSelected[0]));
                                  keyMessageSelected = [];
                                });
                                _focusNode.requestFocus(_focusNode);
                              },
                              child: Image.asset(
                                'assets/images/reply-dark.png',
                                width: 22,
                                height: 22,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              copyToClipBoard();
                            },
                            child: Image.asset(
                              'assets/images/copy-dark.png',
                              width: 22,
                              height: 22,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        if (msgSelectedHasSendByMe)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                deleteMsgAlert();
                              },
                              child: Image.asset(
                                'assets/images/delete-dark.png',
                                width: 22,
                                height: 22,
                              ),
                            ),
                          ),
                      ],
                    )),
                AnimatedOpacity(
                  opacity: keyMessageSelected.length != 0 ? 0 : 1,
                  duration: Duration(milliseconds: 100),
                  child: Container(
                      child: widget.discussionType == 1
                          ? Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      //user Image
                                      CachedNetworkImage(
                                        imageUrl:
                                            widget.currentDiscussion.user_photo,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: imageProvider,
                                        ),
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey.shade200,
                                          highlightColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                Colors.grey.shade200,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.grey.shade200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                //Title of App
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.currentDiscussion.user_name,
                                        style: TextStyle(
                                            fontFamily: 'myriad_bold',
                                            fontSize: 16,
                                            color: themeMode
                                                ? Colors.white
                                                : Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      //typing and online/offline section
                                      /*Container(
                            child: Row(
                              children: [
                                Text(
                                  'écrit',
                                  style: TextStyle(
                                      fontFamily: 'myriad_regular',
                                      fontSize: 14,
                                      color: greenColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SpinKitThreeBounce(
                                  color: greenColor,
                                  size: 12.0,
                                ),
                              ],
                            ),
                          ),
                          */
                                      Text(
                                        'en ligne',
                                        style: TextStyle(
                                            fontFamily: 'myriad_regular',
                                            fontSize: 12,
                                            color: themeMode
                                                ? Colors.white
                                                : Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      //Logo image
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                            'assets/images/logo.png'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                //Title of App
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'KYRIA SUPPORT',
                                        style: TextStyle(
                                            fontFamily: 'myriad_bold',
                                            fontSize: 16,
                                            color: themeMode
                                                ? Colors.white
                                                : Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      //typing and online/offline section
                                      /*Container(
                            child: Row(
                              children: [
                                Text(
                                  'écrit',
                                  style: TextStyle(
                                      fontFamily: 'myriad_regular',
                                      fontSize: 14,
                                      color: greenColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SpinKitThreeBounce(
                                  color: greenColor,
                                  size: 12.0,
                                ),
                              ],
                            ),
                          ),
                          */
                                      Text(
                                        'disponible',
                                        style: TextStyle(
                                            fontFamily: 'myriad_regular',
                                            fontSize: 12,
                                            color: themeMode
                                                ? Colors.white
                                                : Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                ),
              ],
            )),
        backgroundColor: themeMode ? Colors.black : blueColor,
        body: Stack(
          children: [
            Container(
              color: themeMode ? Colors.black : themeAppColor,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: themeAppColor.withOpacity(0.15),
                      child: Stack(
                        children: [
                          Scrollbar(
                            thickness: 2,
                            child: new NotificationListener(
                              onNotification: (t) {
                                if (t is ScrollUpdateNotification) {
                                  setState(() {
                                    scrollPosition =
                                        scrollController.position.pixels;
                                  });
                                  print(scrollPosition);
                                }
                                return true;
                              },
                              child: ListView.builder(
                                  controller: scrollController,
                                  //physics: BouncingScrollPhysics(),
                                  reverse: true,
                                  itemCount: listeMessages.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var msg = MessageModel.fromJson(
                                        listeMessages[index]);

                                    return msg.send_by == 0
                                        ? sendMessageContainer(msg)
                                        : receiveMessageContainer(msg);
                                  }),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            bottom: scrollPosition > 20 ? 10 : -50,
                            right: 20,
                            child: GestureDetector(
                              onTap: () {
                                scrollController.jumpTo(0);
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: greenColor,
                                child: Icon(Icons.expand_more,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (reply)
                    Container(
                      //duration: Duration(milliseconds: 500),
                      //color: themeMode ? Colors.black : Colors.white,
                      //margin: EdgeInsets.only(top: 8, bottom: 10),
                      width: context.screenWidth,
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: themeMode ? themeAppColor : Colors.grey.shade100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/reply-light.png',
                            width: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      // ignore: unrelated_type_equality_checks
                                      replyMsg.send_by == 0
                                          ? 'Vous'
                                          : widget.discussionType != 1
                                              ? 'Kyria Support'
                                              : widget
                                                  .currentDiscussion.user_name,
                                      style: TextStyle(
                                          fontFamily: 'myriad_bold',
                                          fontSize: 16,
                                          color: blueColor,
                                          fontWeight: FontWeight.w500)),
                                  Text(replyMsg.msg_content,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: 'myriad_regular',
                                          fontSize: 16,
                                          color: themeMode
                                              ? Colors.grey.shade600
                                              : Colors.black,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  reply = false;
                                });
                              },
                              child: Icon(
                                Icons.close,
                                size: 22,
                                color: themeMode
                                    ? Colors.grey.shade300
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    //duration: Duration(milliseconds: 500),
                    //height: reply ? 139 : 70,
                    decoration: BoxDecoration(
                      color: themeMode
                          ? themeAppColor.withOpacity(0.15)
                          : Colors.white,
                    ),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Divider(
                            height: 1.5,
                            color: themeMode
                                ? Colors.grey.shade900
                                : Colors.grey.shade300,
                          ),
                          Container(
                            //color: themeMode ? Colors.black : Colors.white,
                            margin: EdgeInsets.only(top: 8, bottom: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 50),
                                    decoration: BoxDecoration(
                                        color: themeAppColor,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: themeMode
                                                ? Colors.grey.shade900
                                                : Colors.grey.shade300)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxHeight: 100.0,
                                            ),
                                            child: TextFormField(
                                              focusNode: _focusNode,
                                              autofocus: true,
                                              controller:
                                                  messageInputController,
                                              onChanged: (msg) {
                                                setState(() {
                                                  typingMsg = msg;
                                                });
                                              },
                                              maxLines: null,
                                              style: TextStyle(
                                                  fontFamily: 'myriad_regular',
                                                  fontSize: 17,
                                                  color: themeMode
                                                      ? Colors.white
                                                      : Colors.black),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Écrire à Kyria...',
                                                hintStyle: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 17,
                                                    color: subtitleTextColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: typingMsg.trim().length == 0
                                      ? null
                                      : () {
                                          setState(() {
                                            listeDiscussions = [];
                                          });

                                          //GET MESSAGE KEY GENERATED
                                          String msgKey = messageProvider
                                              .generateMessageKey();

                                          //FIRST TIME, SAVE MESSAGE TO KYRIA DISCUSSION COLLECTION
                                          messageProvider.saveMessageToKyria(
                                              {
                                                'msg_content': typingMsg,
                                                'formated_date':
                                                    DateTime.now().toString(),
                                                'send_by':
                                                    widget.discussionType == 1
                                                        ? 0
                                                        : 1,
                                                'reply': reply
                                                    ? {
                                                        'msg_key': replyMsg.key,
                                                        'msg_content': replyMsg
                                                            .msg_content,
                                                        'formated_date':
                                                            replyMsg
                                                                .formated_date,
                                                        'send_by':
                                                            replyMsg.send_by
                                                      }
                                                    : null
                                              },
                                              widget.discussionType == 0
                                                  ? localUserInfos.key
                                                  : widget.currentDiscussion
                                                      .discussion_key);
                                          //SECOND TIME, SAVE MESSAGE USER PROBLEME COLLECTOON
                                          messageProvider.saveMessageToUser({
                                            'msg_content': typingMsg,
                                            'formated_date':
                                                DateTime.now().toString(),
                                            'send_by':
                                                widget.discussionType == 1
                                                    ? 1
                                                    : 0,
                                            'reply': reply
                                                ? {
                                                    'msg_key': replyMsg.key,
                                                    'msg_content':
                                                        replyMsg.msg_content,
                                                    'formated_date':
                                                        replyMsg.formated_date,
                                                    'send_by': replyMsg.send_by
                                                  }
                                                : null
                                          });

                                          messageInputController.clear();
                                          /*setState(() {
                                            listeMessages.insert(
                                                0, messageTemplate);
                                            messageInputController.clear();
                                            scrollController.jumpTo(0);
                                          });*/
                                          setState(() {
                                            reply = false;
                                            typingMsg = '';
                                          });
                                        },
                                  child: Container(
                                      width: 45,
                                      height: 45,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: typingMsg.trim().length == 0
                                            ? !themeMode
                                                ? Colors.grey.shade500
                                                : Colors.grey.shade800
                                            : blueColor,
                                      ),
                                      child: Image.asset(
                                        'assets/images/icon-send.png',
                                        width: 20,
                                        height: 20,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
              right: typingMsg.trim().length != 0 ? 85 : 125,
              bottom: 25,
              child: Image.asset(
                'assets/images/icon-image.png',
                width: 23,
                height: 23,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
              right: 85,
              bottom: 25,
              child: AnimatedOpacity(
                opacity: typingMsg.trim().length != 0 ? 0 : 1,
                duration: Duration(milliseconds: 400),
                curve: Curves.decelerate,
                child: Image.asset(
                  'assets/images/icon-camera.png',
                  width: 23,
                  height: 23,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
