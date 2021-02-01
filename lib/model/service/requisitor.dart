import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

enum RequisitionType { POST, GET }

class Requisitor {
  static const int TIMEOUT_SECONDS = 30;

  static Future<String> doGET(url, context) async {
    try {
      var httpClient = new HttpClient();

      var request = await httpClient
          .getUrl(Uri.parse(url))
          .timeout(Duration(seconds: TIMEOUT_SECONDS))
          .catchError(
        (error) {
          throw new Exception("TIMEOUT : O servidor remoto está indisponível "
              "ou não respondeu em tempo hábil");
        },
      );

      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        return json;
      } else if (response.statusCode == HttpStatus.unauthorized) {
      } else if (response.statusCode == HttpStatus.requestTimeout) {
        throw new Exception(
            "TIMEOUT : O servidor remoto está indisponível ou não respondeu em tempo hábil");
      } else if (response.statusCode == HttpStatus.notFound) {
        throw new Exception(
            "O servidor remoto não foi encontrado. \nVerifique o endereço e tente novamente.");
      }

      /* final response = await http
          .get(
            url,
            headers: {"Content-Type": "application/json",},
          )
          .timeout(Duration(seconds: TIMEOUT_SECONDS))
          .catchError(
            (error) {
              throw new Exception(
                  "TIMEOUT : O servidor remoto está indisponível "
                  "ou não respondeu em tempo hábil");
            },
          );

      if (response.statusCode == HttpStatus.ok) {
        return await response.transform(utf8.decoder).join();
      } else if (response.statusCode == HttpStatus.unauthorized) {
      }  } else if (response.statusCode == HttpStatus.requestTimeout) {
        throw new Exception(
            "TIMEOUT : O servidor remoto está indisponível ou não respondeu em tempo hábil");
      } else if (response.statusCode == HttpStatus.notFound) {
        throw new Exception(
            "O servidor remoto não foi encontrado. \nVerifique o endereço e tente novamente.");*/
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) return false;

    return true;
  }
}
