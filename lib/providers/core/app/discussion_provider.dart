import 'package:firebase_database/firebase_database.dart';

class DiscussionProvider {
  //Set database reference for discussion of kyria and client
  final kyriaClientDiscussionReference =
      FirebaseDatabase.instance.reference().child('discussions');

  Future<dynamic> saveDiscussion(dynamic discussionDatas) async {
    await kyriaClientDiscussionReference.push().set(discussionDatas);
  }

  Future<dynamic> removeDiscussion(dynamic discussionRef) async {
    await kyriaClientDiscussionReference.remove();
  }

  Future<DataSnapshot> getAllDiscussions() async {
    return await kyriaClientDiscussionReference.get();
  }
}
