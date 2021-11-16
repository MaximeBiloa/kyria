class MessageModel {
  MessageModel(
      {required this.key,
      required this.msg_content,
      required this.formated_date,
      required this.send_by,
      required this.user_photo,
      required this.reply});
  final String key;
  final String user_photo;
  final String msg_content;
  final String formated_date;
  final int send_by;
  //REPLY CAN BE NULL
  final dynamic reply;

  MessageModel.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        user_photo = json['user_photo'],
        msg_content = json['msg_content'],
        formated_date = json['formated_date'],
        send_by = json['send_by'],
        reply = json['reply'];

  Map<String, dynamic> toJson() => {
        'key': key,
        'user_photo': user_photo,
        'msg_content': msg_content,
        'formated_date': formated_date,
        'send_by': send_by,
        'reply': reply,
      };
}

List<dynamic> listeMessages = [
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Bonsoir équipe Kyria',
    'formated_date': 'Ven, 30 Oct 2021 À 12:20',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Salut Maxime, comment allez-vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:21',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content': 'Je vais bien merci et vous ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 1,
  },
  {
    'user_photo': 'assets/images/logo.png',
    'msg_content': 'Comment pouvons nous vous aider  ?',
    'formated_date': 'Ven, 30 Oct 2021 À 12:23',
    'send_by': 0,
  },
  {
    'user_photo':
        'https://firebasestorage.googleapis.com/v0/b/kyria-51a4a.appspot.com/o/default-files%2Fimages%2Fdefault_photo_url_female.png?alt=media&token=fe672730-c4b0-4818-8b36-272f951bade9',
    'msg_content':
        "Bien ! je ne parviens plus à  effectuer de réservations depuis la dernière mise à jour, j'ai essayé de me reconnecter mais toujours pas de solutions. J'utilise orange comme FAI et la bande passante est assez élevées, soit 3,2 Mo/s",
    'formated_date': 'Ven, 30 Oct 2021 À 12:24',
    'send_by': 1,
  },
];

/*List<MessageModel> MessageModels = [
  MessageModel.fromJson(sendMsg),
];*/
