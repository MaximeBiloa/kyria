import 'package:kyria/providers/models/user_model.dart';

class DiscussionModel {
  DiscussionModel({
    required this.last_msg,
    required this.formated_hour,
    required this.user_name,
    required this.user_photo,
    required this.online_state,
    required this.non_lu,
    required this.discussion_key,
    //required this.user_discussion,
  });
  final String user_photo;
  final String last_msg;
  final String user_name;
  final String formated_hour;
  final bool online_state;
  final int non_lu;
  final String discussion_key;
  //final UserModel user_discussion;

  DiscussionModel.fromJson(Map<String, dynamic> json)
      : user_photo = json['user_photo'],
        last_msg = json['last_msg'],
        user_name = json['user_name'],
        formated_hour = json['formated_hour'],
        online_state = json['online_state'],
        non_lu = json['non_lu'],
        discussion_key = json['discussion_key'];
  //user_discussion = json['user_discussion'];

  Map<String, dynamic> toJson() => {
        'user_photo': user_photo,
        'last_msg': last_msg,
        'user_name': user_name,
        'formated_hour': formated_hour,
        'online_state': online_state,
        'non_lu': non_lu,
        'discussion_key': discussion_key,
        //'user_discussion': user_discussion,
      };
}

List<dynamic> listeDiscussions = [];

dynamic defaultKyriaDiscussion = {
  'user_photo': 'assets/images/user1.jpg',
  'user_name': 'KYRIA SUPPORT',
  'last_msg': 'Bien ! Je ne parviens plus à me connecter.',
  'formated_hour': '09:30',
  'online_state': true,
  'non_lu': 0,
  'discussion_key': 'key',
  //'user_discussion': 'EsWDDgYnaaPFRD074mHHmL0UvcY2'
};

/*List<Message> messages = [
  Message.fromJson(sendMsg),
];*/
