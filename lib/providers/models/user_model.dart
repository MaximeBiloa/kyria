class UserModel {
  UserModel({
    required this.key,
    required this.username,
    required this.name,
    required this.surname,
    required this.email,
    required this.genre,
    required this.cni,
    required this.date_naissance,
    required this.phone,
    required this.photo,
    required this.type,
    required this.status_account,
  });

  final String key;
  final String username;
  final String name;
  final String surname;
  final String email;
  final String genre;
  final String type;
  final String date_naissance;
  final int phone;
  final int cni;
  final String status_account;
  final String photo;

  UserModel.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        username = json['username'],
        name = json['name'],
        surname = json['surname'],
        email = json['email'],
        genre = json['genre'],
        type = json['type'],
        date_naissance = json['date_naissance'],
        phone = json['phone'],
        cni = json['cni'],
        status_account = json['status_account'],
        photo = json['photo'];

  Map<String, dynamic> toJson() => {
        'key': key,
        'username': username,
        'surname': surname,
        'name': name,
        'email': email,
        'genre': genre,
        'type': type,
        'date_naissance': date_naissance,
        'phone': phone,
        'cni': cni,
        'status_account': status_account,
      };
}
