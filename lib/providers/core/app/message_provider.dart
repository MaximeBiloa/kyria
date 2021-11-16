import 'package:firebase_database/firebase_database.dart';
import 'package:kyria/providers/models/message_model.dart';
import 'package:kyria/utils/local_datas.dart';

class MessageProvider {
  final databaseRef = FirebaseDatabase.instance.reference();

  String generateMessageKey() {
    String msgKey = databaseRef
        .child('discussions')
        .child(localUserInfos.key)
        .child('messages')
        .push()
        .key;
    return msgKey;
  }

  Future<dynamic> saveMessageToKyria(
      dynamic messageDatas, String userKey) async {
    //FIRST, SAVE MESSAGE OF DISCUSSION
    databaseRef
        .child('discussions')
        .child(userKey)
        .child('messages')
        .push()
        .set(messageDatas);

    //SECOND, UPDATE DISCUSSION INFORMATIONS
    databaseRef.child('discussions').child(localUserInfos.key).update({
      'last_msg': messageDatas['msg_content'],
      'formated_hour': DateTime.now().microsecondsSinceEpoch,
      'online_state': true,
      'non_lu': 2,
    });
  }

  Future<dynamic> saveMessageToUser(dynamic messageDatas) async {
    databaseRef
        .child('users')
        .child(localUserInfos.key)
        .child('kyria-support-messages')
        .push()
        .set(messageDatas);
  }

  Future<dynamic> deleteMessage(
      String msgKey, bool deletedByAdmin, String userKey) async {
    if (deletedByAdmin) {
      databaseRef
          .child('discussions')
          .child(userKey)
          .child('messages')
          .child(msgKey)
          .remove();
    } else {
      databaseRef
          .child('users')
          .child(localUserInfos.key)
          .child('kyria-support-messages')
          .child(msgKey)
          .remove();
    }
    return true;
  }
}
