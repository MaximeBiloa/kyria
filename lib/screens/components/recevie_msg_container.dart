import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyria/providers/models/message_model.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/extensions.dart';
import 'package:kyria/utils/varialbles.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ReceiveMsgContainer extends StatefulWidget {
  ReceiveMsgContainer(
      {required this.msg,
      required this.themeMode,
      required this.keyMessageSelected});
  MessageModel msg;
  bool themeMode;
  dynamic keyMessageSelected;
  @override
  _ReceiveMsgContainerState createState() => _ReceiveMsgContainerState();
}

class _ReceiveMsgContainerState extends State<ReceiveMsgContainer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: new InkWell(
        onHover: (value) {},
        onLongPress: () {
          //CHECK IF MESSAGE SELECTED IS LIST OF SELECTED MESSAGE
          int index = widget.keyMessageSelected.indexOf(widget.msg.key);
          setState(() {
            if (index == -1) {
              widget.keyMessageSelected.insert(0, widget.msg.key);
            } else {
              widget.keyMessageSelected.removeAt(index);
            }
          });
          print(widget.keyMessageSelected);
        },
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () {
          setState(() {
            //CHECK IF MESSAGE SELECTED IN LIST OF SELECTED MESSAGES
            int index = widget.keyMessageSelected.indexOf(widget.msg.key);
            setState(() {
              if (index != -1) {
                widget.keyMessageSelected.removeAt(index);
              } else {
                //CHECK IF LIST OF SELECTED MESSAGES IS NOT EMPTY TO ADD KEY
                if (widget.keyMessageSelected.length != 0)
                  widget.keyMessageSelected.insert(0, widget.msg.key);
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
              right: widget.keyMessageSelected.indexOf(widget.msg.key) != -1
                  ? 26
                  : -26,
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
              color: widget.keyMessageSelected.indexOf(widget.msg.key) != -1
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
                          child: widget.msg.user_photo != 'kyria-logo'
                              ? CachedNetworkImage(
                                  imageUrl: widget.msg.user_photo,
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
                        if (widget.msg.user_photo != 'kyria-logo')
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
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    //border: Border.all(color: Colors.grey.shade300),
                                    boxShadow: widget.themeMode
                                        ? []
                                        : [
                                            BoxShadow(
                                                color: Colors.grey.shade100,
                                                offset: Offset(0, 1),
                                                blurRadius: 5,
                                                spreadRadius: 2)
                                          ],
                                    color: widget.themeMode
                                        ? Color(0xFFE2E2E2).withOpacity(0.1)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(widget.msg.msg_content,
                                    style: TextStyle(
                                        color: widget.themeMode
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                        fontSize: 17,
                                        fontFamily: 'myriad_regular',
                                        fontWeight: FontWeight.w500))),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              child: Text(widget.msg.formated_date,
                                  style: TextStyle(
                                    color: widget.themeMode
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
}
