import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

enum RequisitionType { POST, GET }

class Requisitor {
  static const int TIMEOUT_SECONDS = 30;

  static Future<String> doGET(url, context) async {
    try {
      var httpClient = new HttpClient();

      var request = await httpClient
          .getUrl(Uri.parse(url))
          .timeout(Duration(seconds: TIMEOUT_SECONDS));

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
    } on Exception catch (e) {
      throw e;
    }
  }
}
