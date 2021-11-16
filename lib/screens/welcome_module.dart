import 'package:flutter/material.dart';
import 'package:kyria/providers/core/api/api_provider.dart';
import 'package:kyria/screens/components/loading/welcome_page_loading.dart';
import 'package:kyria/utils/varialbles.dart';
import 'package:page_transition/page_transition.dart';

import 'components/agences.dart';
import 'components/requestwidget.dart';
import 'components/villes.dart';

class WelcomeModule extends StatefulWidget {
  const WelcomeModule({Key? key}) : super(key: key);

  @override
  _WelcomeModuleState createState() => _WelcomeModuleState();
}

class _WelcomeModuleState extends State<WelcomeModule> {
  //API PROVIDER
  late ApiProvider apiProvider;

  var listVilles = [];
  var listAgences = [];

  //Initialisation et récupération des informations
  bool requestLoading = true;
  bool responseSuccess = false;
  bool requestFailed = false;

  @override
  void initState() {
    super.initState();
    apiProvider = new ApiProvider();
    getPrincipalContent();
  }

  void getPrincipalContent() {
    setState(() {
      requestFailed = false;
      requestLoading = true;
    });

    apiProvider.get_welcome().then((value) {
      setState(() {
        if (value != false) {
          listVilles = value['villes'];
          listAgences = value['agences'];
          requestLoading = false;
          requestFailed = false;
          print(listAgences);
        } else {
          requestLoading = false;
          requestFailed = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (!requestLoading && !requestFailed)
        ? Column(
            children: [
              Divider(
                height: 2,
                color: themeMode ? Colors.grey.shade800 : Colors.grey.shade400,
              ),
              Expanded(
                child: ListView(
                  //physics: BouncingScrollPhysics(),
                  children: [
                    Villes(listVilles: listVilles),
                    Agences(
                      listAgences: listAgences,
                    ),
                  ],
                ),
              ),
            ],
          )
        : requestFailed
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Problème de connexion internet",
                          style: TextStyle(
                              fontFamily: 'myriad_bold',
                              fontSize: 18.5,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w800)),
                      SizedBox(height: 20),
                      Text(
                          "Vérifiez votre connexion internet et reéssayer. Ce problème peut être du au réseau",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'myriad_regular',
                              fontSize: 16,
                              height: 1.4,
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 30),
                      Container(
                        child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 12),
                            ),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.redAccent.shade200),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.redAccent.shade400),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)))),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          onPressed: () {
                            getPrincipalContent();
                          },
                          child: Text('Reéssayer',
                              style: TextStyle(
                                  fontFamily: 'myriad_bold',
                                  color: Colors.white,
                                  fontSize: 18)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            : WelcomePageLoadingElement();
  }
}
//Recuperer toutes les donnees au lancement de l'application
