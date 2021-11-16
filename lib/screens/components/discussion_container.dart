import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyria/providers/models/discussion_model.dart';
import 'package:kyria/screens/inbox_screen.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/varialbles.dart';
import 'package:shimmer/shimmer.dart';

class DiscussionContainer extends StatefulWidget {
  DiscussionContainer({required this.discussion});
  DiscussionModel discussion;

  @override
  _DiscussionContainerState createState() => _DiscussionContainerState();
}

class _DiscussionContainerState extends State<DiscussionContainer> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onHover: (value) {},
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => InboxScreen(
                  currentDiscussion: widget.discussion,
                  discussionType: 1,
                ),
                transitionDuration: Duration.zero,
              ));
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
                        imageUrl: widget.discussion.user_photo,
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
                                      '${widget.discussion.user_name}',
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
                                      '${widget.discussion.last_msg}',
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
                                    '${widget.discussion.formated_hour}',
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
                                  if (widget.discussion.non_lu != 0)
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: blueColor,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Text(
                                          '${widget.discussion.non_lu}',
                                          style: TextStyle(
                                            fontFamily: 'myriad_semibold',
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
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
}
