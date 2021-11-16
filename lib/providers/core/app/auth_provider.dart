import 'package:firebase_auth/firebase_auth.dart';
import 'package:kyria/providers/core/app/user_provider.dart';
import 'package:kyria/providers/models/user_model.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future<dynamic> signUp(dynamic userInfos, String userPassword) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: userInfos['email'],
        password: userPassword,
      );
      _auth.currentUser!.updateDisplayName(userInfos['username']);

      //SAVE USER INFORMATIONS TO REALTIME DATABASE
      final UserProvider _userProvider =
          UserProvider(uid: _auth.currentUser!.uid);
      _userProvider.saveUserInfos(userInfos);

      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn(dynamic userInfos) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: userInfos['email'], password: userInfos['password']);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }

  //GET CURRENT USER UID
  String getUid() {
    return _auth.currentUser!.uid;
  }
}
