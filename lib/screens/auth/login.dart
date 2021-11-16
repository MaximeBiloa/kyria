import 'package:flutter/material.dart';
import 'package:kyria/loaders/auth_process_loading.dart';
import 'package:kyria/providers/core/app/auth_provider.dart';
import 'package:kyria/providers/core/app/user_provider.dart';
import 'package:kyria/providers/models/user_model.dart';
import 'package:kyria/screens/auth/register.dart';
import 'package:kyria/screens/discussion_screen.dart';
import 'package:kyria/screens/inbox_screen.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/local_datas.dart';
import 'package:kyria/utils/varialbles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Auth Provider
  late AuthProvider _authProvider;
  bool screenThemeColor = false;
  bool rememberIscheck = false;
  bool showPassword = false;
  bool validEmail = false;
  bool loginSuccessFul = false;
  bool loginProcessing = false;
  bool loginFailed = false;

  String emailMsgError = '';
  String passwordMsgError = '';
  String loginFailedMsgError = '';

  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _authProvider = new AuthProvider();
    loginMedthod();
  }

  bool validateForm() {
    return true;
    setState(() {
      emailMsgError = '';
      passwordMsgError = '';
      loginFailedMsgError = '';
    });

    _formKey.currentState!.validate();

    if ((emailMsgError.length == 0) && (passwordMsgError.length == 0)) {
      return true;
    }
    return true;
  }

  void loginMedthod() {
    if (validateForm()) {
      setState(() {
        loginProcessing = true;
        loginFailed = false;
      });
      String email = 'MaximeBiloa@gmail.com'; // controllerEmail.text;
      String password = 'Dessin.7'; // controllerPassword.text;

      final user = {'email': email, 'password': password};

      //REGISTER PROCESS
      _authProvider.signIn(user).then((value) {
        setState(() {
          if (value == true) {
            //GET USER DATAS
            UserProvider userProvider =
                new UserProvider(uid: _authProvider.getUid());

            loginProcessing = false;

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
          } else {
            if (value ==
                'There is no user record corresponding to this identifier. The user may have been deleted.') {
              loginFailedMsgError = 'Adresse email invalide.';
            } else if (value ==
                'The password is invalid or the user does not have a password.') {
              loginFailedMsgError = 'Mot de passe incorrect.';
              //loginProcessing = false;
            }
          }
          loginProcessing = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //themeMode = false;
    return Scaffold(
      body: loginProcessing
          ? AuthProcessLoading(
              requestTitle: 'Connexion en cours',
              requestSubtitle:
                  "La connexion à votre compte Kyria peut prendre quelques minutes.",
            )
          : Container(
              //color: themeAppColor,
              child: Center(
                child: Container(
                  color: themeMode
                      ? Color(0xFF3C474D).withOpacity(0.1)
                      : Colors.white,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 30, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/logo.png',
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Se connecter à Kyria',
                                            style: TextStyle(
                                                fontFamily: 'myriad_bold',
                                                fontSize: 20,
                                                height: 1.4,
                                                color: greenColor,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Veuillez vous authentifier pour continuer',
                                            style: TextStyle(
                                                fontFamily: 'myriad_regular',
                                                fontSize: 15,
                                                height: 1.4,
                                                color: themeMode
                                                    ? Colors.grey.shade500
                                                    : Colors.grey.shade900,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(loginFailedMsgError,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'myriad_regular',
                                                  fontSize: 14,
                                                  height: 1.4,
                                                  color: Colors.redAccent,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: themeMode
                                                    ? Colors.grey.shade800
                                                    : Colors.grey.shade300),
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.email,
                                              color: themeMode
                                                  ? Colors.grey.shade500
                                                  : Colors.grey.shade700,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                                child: TextFormField(
                                              onChanged: (value) {
                                                setState(() {
                                                  validEmail = RegExp(
                                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(value);
                                                });
                                              },
                                              validator: (value) {
                                                setState(() {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    emailMsgError =
                                                        'Veuillez entrer une adresse email';
                                                  } else if (!validEmail) {
                                                    emailMsgError =
                                                        "Adresse email invaide";
                                                  }
                                                });
                                              },
                                              controller: controllerEmail,
                                              style: TextStyle(
                                                  fontFamily: 'myriad_regular',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.5,
                                                  color: themeMode
                                                      ? Colors.white
                                                      : Colors.grey.shade700),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Email',
                                                  hintStyle: TextStyle(
                                                      fontFamily:
                                                          'myriad_regular',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15.5,
                                                      color: themeMode
                                                          ? Colors.grey.shade500
                                                          : Colors
                                                              .grey.shade400)),
                                            )),
                                            if (validEmail)
                                              Icon(Icons.check_circle,
                                                  size: 20,
                                                  color: Colors.green.shade400)
                                          ],
                                        ),
                                      ),
                                      Text(emailMsgError,
                                          style: TextStyle(
                                              fontFamily: 'myriad_regular',
                                              fontSize: 12.5,
                                              height: 1.4,
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: themeMode
                                                    ? Colors.grey.shade800
                                                    : Colors.grey.shade300),
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.lock,
                                              color: themeMode
                                                  ? Colors.grey.shade500
                                                  : Colors.grey.shade700,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                                child: TextFormField(
                                              validator: (value) {
                                                setState(() {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    passwordMsgError =
                                                        'Le mot de passe est manquant';
                                                  } else if (value.length < 8) {
                                                    passwordMsgError =
                                                        'Le mot de passe doit avoir au moins 8 caractères';
                                                  }
                                                });
                                              },
                                              controller: controllerPassword,
                                              obscureText: !showPassword,
                                              style: TextStyle(
                                                  fontFamily: 'myriad_regular',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.5,
                                                  color: themeMode
                                                      ? Colors.white
                                                      : Colors.grey.shade700),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Mot de passe',
                                                  hintStyle: TextStyle(
                                                      fontFamily:
                                                          'myriad_regular',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15.5,
                                                      color: themeMode
                                                          ? Colors.grey.shade500
                                                          : Colors
                                                              .grey.shade400)),
                                            )),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = !showPassword;
                                                });
                                              },
                                              style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        EdgeInsets.all(2)),
                                                shape: MaterialStateProperty
                                                    .all(RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)))),
                                                overlayColor:
                                                    MaterialStateProperty.all(
                                                  Colors.grey.shade200,
                                                ),
                                              ),
                                              child: Icon(
                                                !showPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: themeMode
                                                    ? Colors.grey.shade500
                                                    : Colors.grey.shade700,
                                                size: 18,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(passwordMsgError,
                                          style: TextStyle(
                                              fontFamily: 'myriad_regular',
                                              fontSize: 12.5,
                                              height: 1.4,
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  //Champ pour l'adresse email
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10, top: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: TextButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 12.5),
                                          ),
                                          overlayColor:
                                              MaterialStateProperty.all<Color>(
                                                  blueColor.withOpacity(0.3)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  blueColor),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              25)))),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          loginMedthod();
                                        },
                                        child: Text('Connexion',
                                            style: TextStyle(
                                                fontFamily: 'myriad_bold',
                                                color: Colors.white,
                                                fontSize: 18)),
                                      ))
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                greenColor,
                                              ),
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation1,
                                                          animation2) =>
                                                      Register(),
                                                  transitionDuration:
                                                      Duration.zero,
                                                ));
                                          },
                                          child: Text(
                                            'Pas encore de compte ?',
                                            style: TextStyle(
                                                fontSize: 14.5,
                                                color: blueColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'myriad_regular'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
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
