import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:loom/models/network_model.dart';
import 'dart:async';
import 'logger.dart';

class HttpApiProvider {
  HttpApiProvider();
  var logger = Logger(
    printer: MyPrinter(),
    output: LoomConsoleOutput(),
  );

  Future<String?> sendEmail(String email) async {
    try {
      var url = Uri.parse('https://eastvalleyrobotics.com/api/app-email');
      var response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'api_key': "z778vGh0a95h",
        }),
      );

      if (response.statusCode != 200) {
        logger.w(response.statusCode);
        return null;
      }

      logger.i(response.body);
      return response.body;
    } catch (e) {
      logger.w(e.toString());
      return null;
    }
  }

  Future<String?> formScanningAp() async {
    try {
      var url = Uri.parse('http://192.168.10.1/mobile/form_scanning_ap.htm');
      var response = await http.post(url,
          body: {'refresh': 'Site Survey', 'ifname': "wlan0", 'opmode': "2"});

      if (response.statusCode != 200) {
        logger.w(response.statusCode);
        return null;
      }

      logger.i(response.body);
      return response.body;
    } catch (e) {
      logger.w(e.toString());
      return null;
    }
  }

  Future<List<NetworkModel>?> apList() async {
    try {
      var url =
          Uri.parse('http://192.168.10.1/data/ap_list.htm?_=1632792847486');
      var response = await http.get(url);

      List<NetworkModel> neworksList = (json.decode(response.body) as List)
          .map((i) => NetworkModel.fromJson(i))
          .toList();

      if (response.statusCode != 200) {
        logger.w(response.statusCode);
        return null;
      }

      logger.i(response.body);
      return neworksList;
    } catch (e) {
      logger.w(e.toString());
      return null;
    }
  }

  Future<String?> formSetRepeater({
    required String ssid,
    required String channel,
    required String networkName,
    required String password,
  }) async {
    try {
      var url = Uri.parse('http://192.168.10.1/mobile/form_set_repeater.htm');
      var response = await http.post(url, body: {
        "pocket_wpa_tkip_aes": "",
        "pocket_wpa2_tkip_aes": "aes",
        "wpa2ciphersuite0": "aes",
        "ciphersuite0": "",
        "pocket_channel": channel,
        "pocketAP_ssid": ssid,
        "pocket_encrypt": "wpa2-psk",
        "select": "sel0",
        "opmode": "2",
        "ssid0": networkName,
        "authType0": "open",
        "method0": "6",
        "pskValue0": password,
        "wlanif": "wlan0",
        "wlan_idx": "0",
        "band0": channel,
        "mode0": "3",
        "wps_clear_configure_by_reg0": "0",
        "wpaAuth0": "psk",
        "pskFormat0": "0",
        "eapType0": "0",
        "eapInsideType0": "0",
        "eapUserId0": "",
        "radiusUserName0": "",
        "radiusUserPass0": "",
        "radiusUserCertPass0": "",
        "wapiPskFormat0": "0",
        "wapiPskValue0": "",
        "wapiASIP0": "0.0.0.0",
        "connect": "connect",
      });

      if (response.statusCode != 200) {
        logger.w(response.statusCode);
        return null;
      }

      logger.i(response.body);
      return response.body;
    } catch (e) {
      logger.w(e.toString());
      return null;
    }
  }

  Future<String?> getGoogle() async {
    try {
      var url = Uri.parse('https://www.google.com');
      var response = await http.get(url);

      if (response.statusCode != 200) {
        logger.w(response.statusCode);
        return null;
      }

      logger.i(response.body);
      return response.body;
    } catch (e) {
      logger.w(e.toString());
      return null;
    }
  }

  Future<String?> sendEmailAndStars(String email, int stars) async {
    try {
      var url = Uri.parse('https://eastvalleyrobotics.com/api/app-stars');
      var response = await http.post(url,
          body: json.encode(
              {'email': email, 'stars': stars, 'api_key': "z778vGh0a95h"}));

      if (response.statusCode != 200) {
        logger.w(response.statusCode);
        return null;
      }

      logger.i(response.body);
      return response.body;
    } catch (e) {
      logger.w(e.toString());
      return null;
    }
  }
}
