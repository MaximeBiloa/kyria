import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/varialbles.dart';
import 'package:page_transition/page_transition.dart';

import 'imageLoagindAnimaation.dart';

// ignore: must_be_immutable
class Agences extends StatefulWidget {
  Agences({required this.listAgences});
  List<dynamic> listAgences;

  @override
  _AgencesState createState() => _AgencesState();
}

class _AgencesState extends State<Agences> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 5),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Agences',
                  style: TextStyle(
                      fontFamily: 'myriad_bold',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: themeMode
                          ? Colors.grey.shade300
                          : Colors.grey.shade800)),
              TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      Size(15, 0),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all((Colors.blue.shade100)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.transparent)))),
                child: Text(
                  'Tous',
                  style: TextStyle(
                      fontFamily: 'myriad_regular',
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.listAgences.length,
              itemBuilder: (BuildContext context, int index) {
                String nomAgence = widget.listAgences[index]['nom'];
                String descriptionAgence =
                    widget.listAgences[index]['description'];
                String imageAgence =
                    "https://kyria.cm/${widget.listAgences[index]['image']}";
                Map<String, dynamic> agence = {
                  'nom': nomAgence,
                  'description': descriptionAgence,
                  'image': imageAgence
                };

                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: themeMode
                          ? Color(0xFFE2E2E2).withOpacity(0.1)
                          : Colors.white,
                      boxShadow: themeMode
                          ? []
                          : [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 20)
                            ],
                    ),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: imageAgence,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                ImageLoadingAnimation(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nomAgence,
                                  style: TextStyle(
                                      fontFamily: 'myriad_bold',
                                      fontSize: 20,
                                      color: themeMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w800)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(descriptionAgence,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      height: 1.4,
                                      fontFamily: 'myriad_regular',
                                      fontSize: 15,
                                      color: themeMode
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade700,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
