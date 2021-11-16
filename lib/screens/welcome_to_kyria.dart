import 'package:flutter/material.dart';
import 'package:kyria/utils/colors.dart';

class WelcomeToKyria extends StatefulWidget {
  const WelcomeToKyria({Key? key}) : super(key: key);

  @override
  _WelcomeToKyriaState createState() => _WelcomeToKyriaState();
}

class _WelcomeToKyriaState extends State<WelcomeToKyria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/welcomekyria.png'),
                  SizedBox(height: 10),
                  Text("Bienvenue sur kyria",
                      style: TextStyle(
                          fontFamily: 'myriad_bold',
                          fontSize: 22,
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.w800)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Inscription réussie',
                        style: TextStyle(
                            fontFamily: 'myriad_bold',
                            fontSize: 13,
                            color: Colors.green,
                            fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                        "Bénéficiez d'un service de qualité en utilisant nos services. Tout commence maintenant. Cliquez sur le bouton démarrer pour commencer",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.4,
                            fontFamily: 'myriad_semibold',
                            fontSize: 15,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                        ),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(greenColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                      ),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: MainApp()));*/
                      },
                      child: Text('Démarrer',
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
          ],
        ),
      ),
    ));
  }
}
