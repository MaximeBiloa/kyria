import 'package:flutter/material.dart';
import 'package:kyria/loaders/auth_process_loading.dart';
import 'package:kyria/providers/core/app/auth_provider.dart';
import 'package:kyria/screens/inbox_screen.dart';
import 'package:kyria/screens/welcome_to_kyria.dart';
import 'package:kyria/utils/colors.dart';
import 'package:kyria/utils/formatage_date.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Auth Provider
  late AuthProvider _authProvider;
  bool screenThemeColor = false;
  bool showPassword = false;
  bool registerProcessing = false;
  bool requestFailed = false;
  bool registerSuccessful = false;

  bool validEmail = false;
  bool passwordVerified = false;

  String emailMsgError = '';
  String passwordMsgError = '';
  String nomMsgError = '';
  String prenomMsgError = '';
  String usernameMsgError = '';
  String sexeMsgError = '';
  String telephoneMsgError = '';
  String cniMsgError = '';
  String dateNaissMsgError = '';
  String passwordConfMsgError = '';
  String registerMsgError = '';

  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerConfPassword = new TextEditingController();
  TextEditingController controllerNom = new TextEditingController();
  TextEditingController controllerPrenom = new TextEditingController();
  TextEditingController controllerUsername = new TextEditingController();
  var sexe;
  TextEditingController controllerTelephone = new TextEditingController();
  TextEditingController controllerCni = new TextEditingController();

  var dateNaiss;
  bool rememberIscheck = false;
  bool registerSuccessFul = false;
  bool registerFailed = false;

  String registerFailedMsgError = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _authProvider = new AuthProvider();
    print(_authProvider.user);
  }

  bool validateForm() {
    setState(() {
      emailMsgError = '';
      passwordMsgError = '';
      nomMsgError = '';
      prenomMsgError = '';
      usernameMsgError = '';
      sexeMsgError = '';
      telephoneMsgError = '';
      cniMsgError = '';
      dateNaissMsgError = '';
      passwordConfMsgError = '';
      registerMsgError = '';
    });

    if (sexe == null) {
      setState(() {
        sexeMsgError = "Veuillez choisir le sexe";
      });
    }

    if (dateNaiss == null) {
      setState(() {
        dateNaissMsgError = "Veuillez choisir une date";
      });
    }

    //Validation du formulaire pour détecter les erreurs
    _formKey.currentState!.validate();

    if ((emailMsgError.length == 0) &&
        (passwordMsgError.length == 0) &&
        (nomMsgError.length == 0) &&
        (prenomMsgError.length == 0) &&
        (usernameMsgError.length == 0) &&
        (sexeMsgError.length == 0) &&
        (telephoneMsgError.length == 0) &&
        (cniMsgError.length == 0) &&
        (dateNaissMsgError.length == 0) &&
        ((passwordConfMsgError.length == 0) &&
            (controllerPassword.text == controllerConfPassword.text))) {
      //Dans le cas où toutes les informations sont correctes
      return true;
    }
    return false;
  }

  void registerMethod() {
    if (validateForm()) {
      setState(() {
        registerProcessing = true;
      });
      String nom = controllerNom.text,
          prenom = controllerPrenom.text,
          sexeUser = sexe,
          email = controllerEmail.text,
          password = controllerPassword.text;
      int telephone = int.parse(controllerTelephone.text),
          cni = int.parse(controllerCni.text);
      dateNaiss = dateNaiss;

      final user = {
        'name': nom,
        'surname': prenom,
        'username': prenom,
        'email': email,
        'genre': sexe,
        'type': 'client',
        'date_naissance': dateNaiss.toString(),
        'phone': telephone,
        'cni': cni,
        'photo': sexe == 'Masculin'
            ? 'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_male.png?alt=media&token=bc29534e-953a-438a-b4f9-98af12599061'
            : 'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=ee66591b-6899-4be2-bf15-83fd01aedd0e',
        'status_account': 'enabled',
      };

      //REGISTER PROCESS
      _authProvider.signUp(user, password).then((value) {
        setState(() {
          registerProcessing = false;

          if (value == true) {
            //REGISTER SUCCESS
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => WelcomeToKyria()));
          } else {
            if (value ==
                'The email address is already in use by another account.') {
              registerMsgError = 'Cette adresse email existe déjà.';
            }
          }
        });
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    int currentYear = DateTime.now().year;
    final DateTime? date = await showDatePicker(
        context: context,
        locale: const Locale("fr", "FR"),
        initialDate: DateTime(2000),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1901),
        lastDate: DateTime(currentYear - 1));

    setState(() {
      if (date != null) {
        dateNaiss = date;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //registerProcessing = false;
    return Scaffold(
      body: registerProcessing
          ? AuthProcessLoading(
              requestTitle: 'Inscription en cours',
              requestSubtitle:
                  "La création du compte peut prendre un moment suivant la qualité de votre connexion. Veuillez patienter",
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/logo.png',
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'S\'inscrire à Kyria',
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
                                      'Incrivez vous et profitez de tous les services de kyria',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'myriad_regular',
                                          fontSize: 15,
                                          height: 1.4,
                                          color: Colors.grey.shade900,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(registerMsgError,
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
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/user-3-line (1).png',
                                                    width: 20,
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
                                                          nomMsgError =
                                                              'Veuillez entrer un nom valide';
                                                        }
                                                      });
                                                    },
                                                    controller: controllerNom,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'myriad_regular',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.5,
                                                        color: Colors
                                                            .grey.shade700),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: 'Nom',
                                                        hintStyle: TextStyle(
                                                            fontFamily:
                                                                'myriad_regular',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.5,
                                                            color: Colors.grey
                                                                .shade400)),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Text(nomMsgError,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 12.5,
                                                    height: 1.4,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/user-3-line (1).png',
                                                    width: 20,
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
                                                          prenomMsgError =
                                                              'Veuillez entrer un prénom valide';
                                                        }
                                                      });
                                                    },
                                                    controller:
                                                        controllerPrenom,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'myriad_regular',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.5,
                                                        color: Colors
                                                            .grey.shade700),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: 'Prénom',
                                                        hintStyle: TextStyle(
                                                            fontFamily:
                                                                'myriad_regular',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.5,
                                                            color: Colors.grey
                                                                .shade400)),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Text(prenomMsgError,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 12.5,
                                                    height: 1.4,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/user-3-line (1).png',
                                                    width: 20,
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
                                                          usernameMsgError =
                                                              'Veuillez entrer un nom utilisateur valide';
                                                        }
                                                      });
                                                    },
                                                    controller:
                                                        controllerUsername,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'myriad_regular',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.5,
                                                        color: Colors
                                                            .grey.shade700),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Nom utilisateur',
                                                        hintStyle: TextStyle(
                                                            fontFamily:
                                                                'myriad_regular',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.5,
                                                            color: Colors.grey
                                                                .shade400)),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Text(usernameMsgError,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 12.5,
                                                    height: 1.4,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    color: Colors.grey.shade700,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                      child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      setState(() {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          telephoneMsgError =
                                                              'Veuillez entrer un numéro valide';
                                                        } else if ((value
                                                                        .toString()[
                                                                    0] !=
                                                                6.toString()) ||
                                                            (value
                                                                    .toString()
                                                                    .length !=
                                                                9)) {
                                                          telephoneMsgError =
                                                              'Veuillez entrer un numéro valide (6 xx xx xx xx)';
                                                        }
                                                      });
                                                    },
                                                    controller:
                                                        controllerTelephone,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'myriad_regular',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.5,
                                                        color: Colors
                                                            .grey.shade700),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: 'Téléphone',
                                                        hintStyle: TextStyle(
                                                            fontFamily:
                                                                'myriad_regular',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.5,
                                                            color: Colors.grey
                                                                .shade400)),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Text(telephoneMsgError,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 12.5,
                                                    height: 1.4,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.perm_identity_rounded,
                                                    color: Colors.grey.shade700,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                      child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      setState(() {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          cniMsgError =
                                                              'Veuillez entrer un numéro de CNI valide';
                                                        } else if (value
                                                                .length !=
                                                            9) {
                                                          cniMsgError =
                                                              'Le numéro de CNI doit avoir 9 chiffres';
                                                        }
                                                      });
                                                    },
                                                    controller: controllerCni,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'myriad_regular',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.5,
                                                        color: Colors
                                                            .grey.shade700),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Numéro de CNI',
                                                        hintStyle: TextStyle(
                                                            fontFamily:
                                                                'myriad_regular',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.5,
                                                            color: Colors.grey
                                                                .shade400)),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Text(cniMsgError,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 12.5,
                                                    height: 1.4,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: DropdownButton<String>(
                                                value: sexe,
                                                isExpanded: true,
                                                underline: Container(),
                                                hint: Text(
                                                  "Sexe",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15.5,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                                items: <String>[
                                                  'Masculin',
                                                  'Feminin',
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'myriad_regular',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15.5,
                                                          color: Colors
                                                              .grey.shade700),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    sexe = value.toString();
                                                  });
                                                },
                                              ),
                                            ),
                                            Text(sexeMsgError,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 12.5,
                                                    height: 1.4,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.date_range,
                                                    color: Colors.grey.shade700,
                                                    size: 18,
                                                  ),
                                                  TextButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 18),
                                                        ),
                                                        overlayColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                          Colors.grey.shade200,
                                                        ),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Colors
                                                                    .transparent),
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)))),
                                                      ),
                                                      onPressed: () {
                                                        selectDate(context);
                                                      },
                                                      child: Text(
                                                          dateNaiss == null
                                                              ? 'Date de naissance'
                                                              : customdate(
                                                                  dateNaiss),
                                                          style: dateNaiss ==
                                                                  null
                                                              ? TextStyle(
                                                                  fontFamily:
                                                                      'myriad_regular',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      15.5,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400)
                                                              : TextStyle(
                                                                  fontFamily:
                                                                      'myriad_regular',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      15.5,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                ))),
                                                ],
                                              ),
                                            ),
                                            Text(dateNaissMsgError,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 12.5,
                                                    height: 1.4,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.email,
                                                    color: Colors.grey.shade700,
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
                                                        fontFamily:
                                                            'myriad_regular',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.5,
                                                        color: Colors
                                                            .grey.shade700),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: 'Email',
                                                        hintStyle: TextStyle(
                                                            fontFamily:
                                                                'myriad_regular',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.5,
                                                            color: Colors.grey
                                                                .shade400)),
                                                  )),
                                                  if (validEmail)
                                                    Icon(Icons.check_circle,
                                                        size: 20,
                                                        color: Colors
                                                            .green.shade400)
                                                ],
                                              ),
                                            ),
                                            Text(emailMsgError,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 12.5,
                                                    height: 1.4,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.lock,
                                                    color: Colors.grey.shade700,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                      child: TextFormField(
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (value ==
                                                            controllerConfPassword
                                                                .text) {
                                                          passwordVerified =
                                                              true;
                                                        } else {
                                                          passwordVerified =
                                                              false;
                                                        }
                                                      });
                                                    },
                                                    validator: (value) {
                                                      setState(() {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          passwordMsgError =
                                                              'Le mot de passe est manquant';
                                                        } else if (value
                                                                .length <
                                                            8) {
                                                          passwordMsgError =
                                                              'Le mot de passe doit avoir au moins 8 caractères';
                                                        }
                                                      });
                                                    },
                                                    controller:
                                                        controllerPassword,
                                                    obscureText: !showPassword,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'myriad_regular',
                                                        color: Colors
                                                            .grey.shade800,
                                                        fontSize: 15.5),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Mot de passe',
                                                        hintStyle: TextStyle(
                                                            fontFamily:
                                                                'myriad_regular',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.5,
                                                            color: Colors.grey
                                                                .shade400)),
                                                  )),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        showPassword =
                                                            !showPassword;
                                                      });
                                                    },
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .all(2)),
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)))),
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all(
                                                        Colors.grey.shade200,
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      showPassword
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                      color:
                                                          Colors.grey.shade700,
                                                      size: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(passwordMsgError,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 12.5,
                                                    height: 1.4,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                        //Champ pour l'adresse email
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.lock,
                                                    color: Colors.grey.shade700,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                      child: TextFormField(
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (controllerPassword
                                                                .text ==
                                                            value) {
                                                          passwordVerified =
                                                              true;
                                                        } else {
                                                          passwordVerified =
                                                              false;
                                                        }
                                                      });
                                                    },
                                                    validator: (value) {
                                                      setState(() {
                                                        if ((value == null ||
                                                                value
                                                                    .isEmpty) ||
                                                            (value.length <
                                                                8)) {
                                                          passwordConfMsgError =
                                                              'Les deux mots de passe ne correspondent pas';
                                                        }
                                                      });
                                                    },
                                                    controller:
                                                        controllerConfPassword,
                                                    obscureText: true,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'poppins_medium',
                                                        color: Colors
                                                            .grey.shade800,
                                                        fontSize: 15),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Confirmation du mot de passe',
                                                        hintStyle: TextStyle(
                                                            fontFamily:
                                                                'myriad_regular',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15.5,
                                                            color: Colors.grey
                                                                .shade400)),
                                                  )),
                                                  if (passwordVerified)
                                                    Icon(Icons.check_circle,
                                                        size: 20,
                                                        color: Colors
                                                            .green.shade400)
                                                ],
                                              ),
                                            ),
                                            Text(passwordConfMsgError,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'myriad_regular',
                                                    fontSize: 12.5,
                                                    height: 1.4,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                        //Champ pour l'adresse email
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
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
                                            blueColor.withOpacity(0.2)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            blueColor),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)))),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    registerMethod();
                                  },
                                  child: Text('Inscription',
                                      style: TextStyle(
                                          fontFamily: 'myriad_bold',
                                          color: Colors.white,
                                          fontSize: 18)),
                                )),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 0, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                          greenColor,
                                        ),
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Déjà un compte ?',
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
    );
  }
}
