import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart' as http;

class ApiProvider {
  //Recuperation de la liste des agences et des villes
  // ignore: non_constant_identifier_names
  Future<dynamic> get_welcome() async {
    final ioClient = HttpClient();
    ioClient.connectionTimeout = const Duration(seconds: 15);
    final client = http.IOClient(ioClient);

    try {
      var urlServer = Uri.parse("https://kyria.cm/welcome");
      var response = await client.get(urlServer);

      if (response.statusCode == 200) {
        try {
          var httpResponse = convert.jsonDecode(response.body);
          return httpResponse;
        } catch (e) {
          print("L'erreur est $e");
          return false;
        }
      } else {
        print("Erreur interne du serveur");
        return false;
      }
    } catch (e) {
      if (e is SocketException) {
        print("Problemme de connexion internet");
      } else if (e is TimeoutException) {
        print("Echec de la requete : temps trop long");
      }

      return false;
    }
  }

  //Recherche
  Future<dynamic> search(String search) async {
    final ioClient = HttpClient();
    ioClient.connectionTimeout = const Duration(seconds: 15);
    final client = http.IOClient(ioClient);

    try {
      var urlServer =
          Uri.parse("https://kyria.cm/recherche-mobile?search=" + search);
      var response = await client.get(
        urlServer,
      );

      if (response.statusCode == 200) {
        try {
          var httpResponse = convert.jsonDecode(response.body);
          return httpResponse;
        } catch (e) {
          print("L'erreur est $e");
          return false;
        }
      } else {
        print("Erreur interne du serveur");
        return false;
      }
    } catch (e) {
      if (e is SocketException) {
        print("Problemme de connexion internet");
      } else if (e is TimeoutException) {
        print("Echec de la requete : temps trop long");
      }

      return false;
    }
  }

  //Recuperation de la liste des agences d'une villes
  Future<dynamic> getAgencesVille(int idVille) async {
    final ioClient = HttpClient();
    ioClient.connectionTimeout = const Duration(seconds: 15);
    final client = http.IOClient(ioClient);

    try {
      var urlServer = Uri.parse(
          "https://kyria.cm/agence-ville?ville=" + idVille.toString());
      var response = await client.get(
        urlServer,
      );

      if (response.statusCode == 200) {
        try {
          var httpResponse = convert.jsonDecode(response.body);
          return httpResponse;
        } catch (e) {
          print("L'erreur est $e");
          return false;
        }
      } else {
        print("Erreur interne du serveur");
        return false;
      }
    } catch (e) {
      if (e is SocketException) {
        print("Problemme de connexion internet");
      } else if (e is TimeoutException) {
        print("Echec de la requete : temps trop long");
      }

      return false;
    }
  }

  //Inscription d'un utilisateur
  Future<dynamic> register(String nom, String prenom, int telephone, int cni,
      String sexe, String email, DateTime? dateNaiss, String password) async {
    final ioClient = HttpClient();
    ioClient.connectionTimeout = const Duration(seconds: 15);
    final client = http.IOClient(ioClient);

    try {
      var urlServer = Uri.parse("https://kyria.cm/register-mobile");
      var response = await client.post(urlServer,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json'
          },
          body: jsonEncode({
            'nom': nom,
            'prenom': prenom,
            'telephone': telephone,
            'cni': cni,
            'sexe': sexe,
            'email': email,
            'dateNaiss': dateNaiss.toString(),
            'password': password
          }));

      if (response.statusCode == 200) {
        try {
          var httpResponse = convert.jsonDecode(response.body);
          return httpResponse;
        } catch (e) {
          print("L'erreur est $e");
          return false;
        }
      } else {
        print("Resultat : ${response.body}");
        return false;
      }
    } catch (e) {
      if (e is SocketException) {
        print("Problemme de connexion internet");
      } else if (e is TimeoutException) {
        print("Echec de la requete : temps trop long");
      }

      print("Erreur $e");

      return false;
    }
  }

  //Connexion d'un utilisateur
  Future<dynamic> login(String email, String password) async {
    final ioClient = HttpClient();
    ioClient.connectionTimeout = const Duration(seconds: 15);
    final client = http.IOClient(ioClient);

    try {
      var urlServer = Uri.parse("https://kyria.cm/login-mobile");
      var response = await client.post(urlServer,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json'
          },
          body: jsonEncode({
            'email': email,
            'password': password,
          }));

      if (response.statusCode == 200) {
        try {
          var httpResponse = convert.jsonDecode(response.body);
          return httpResponse;
        } catch (e) {
          print("L'erreur est $e");
          return false;
        }
      } else {
        print("Resultat : ${response.body}");
        return false;
      }
    } catch (e) {
      if (e is SocketException) {
        print("Problemme de connexion internet");
      } else if (e is TimeoutException) {
        print("Echec de la requete : temps trop long");
      }

      print("Erreur $e");

      return false;
    }
  }
}
