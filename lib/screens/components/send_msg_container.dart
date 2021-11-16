import 'package:flutter/material.dart';
import 'package:kyria/providers/models/message_model.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/extensions.dart';
import 'package:kyria/utils/varialbles.dart';

// ignore: must_be_immutable
class SendMsgContainer extends StatefulWidget {
  SendMsgContainer(
      {required this.msg,
      required this.themeMode,
      required this.keyMessageSelected});
  MessageModel msg;
  bool themeMode;
  dynamic keyMessageSelected;
  @override
  _SendMsgContainerState createState() => _SendMsgContainerState();
}

class _SendMsgContainerState extends State<SendMsgContainer> {
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
        child: Container(
          color: widget.keyMessageSelected.indexOf(widget.msg.key) != -1
              ? blueColor.withOpacity(0.15)
              : Colors.transparent,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                curve: Curves.decelerate,
                left: widget.keyMessageSelected.indexOf(widget.msg.key) != -1
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(alignment: WrapAlignment.end, children: [
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
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      //border: Border.all(color: Colors.grey.shade300),
                                      color: blueColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(widget.msg.msg_content,
                                      style: TextStyle(
                                          color: Colors.white,
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
      ),
    );
  }
}
