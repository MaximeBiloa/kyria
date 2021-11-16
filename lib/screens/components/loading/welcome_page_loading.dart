import 'package:flutter/material.dart';
import 'package:kyria/screens/components/loading_container_template.dart';
import 'package:kyria/utils/varialbles.dart';

class WelcomePageLoadingElement extends StatefulWidget {
  @override
  _WelcomePageLoadingElementState createState() =>
      _WelcomePageLoadingElementState();
}

class _WelcomePageLoadingElementState extends State<WelcomePageLoadingElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              //physics: BouncingScrollPhysics(),
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 5),
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LoadingContainerTemplate(
                          width: 70,
                          height: 25,
                          radiusbottomLeft: 18,
                          radiusbottomRight: 18,
                          radiustopLeft: 18,
                          radiustopRight: 18),
                      LoadingContainerTemplate(
                          width: 70,
                          height: 25,
                          radiusbottomLeft: 20,
                          radiusbottomRight: 20,
                          radiustopLeft: 20,
                          radiustopRight: 20),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: LoadingContainerTemplate(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 30,
                              radiusbottomLeft: 18,
                              radiusbottomRight: 18,
                              radiustopLeft: 18,
                              radiustopRight: 18),
                        );
                      }),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 5),
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LoadingContainerTemplate(
                          width: 70,
                          height: 25,
                          radiusbottomLeft: 18,
                          radiusbottomRight: 18,
                          radiustopLeft: 18,
                          radiustopRight: 18),
                      LoadingContainerTemplate(
                          width: 70,
                          height: 25,
                          radiusbottomLeft: 20,
                          radiusbottomRight: 20,
                          radiustopLeft: 20,
                          radiustopRight: 20),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: LoadingContainerTemplate(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 30,
                              radiusbottomLeft: 18,
                              radiusbottomRight: 18,
                              radiustopLeft: 18,
                              radiustopRight: 18),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
