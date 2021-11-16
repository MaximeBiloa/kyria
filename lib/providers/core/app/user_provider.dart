import 'package:firebase_database/firebase_database.dart';
import 'package:kyria/providers/models/message_model.dart';
import 'package:kyria/providers/models/user_model.dart';

class UserProvider {
  UserProvider({required this.uid});
  final String uid;
  final userRef = FirebaseDatabase.instance.reference().child('users');

  Future saveUserInfos(dynamic userInfos) async {
    //Save user informations
    await userRef.child(this.uid).set(userInfos);
    //Return result of saving
    //return saveResult;
  }

  Future<DataSnapshot> getUserInfos() async {
    //get user informations
    final userInfos = await userRef.child(this.uid).get();
    return userInfos;
  }
}
