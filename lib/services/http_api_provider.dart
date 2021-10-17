// ignore_for_file: unused_local_variable
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:loom/models/network_model.dart';

class HttpApiProvider {
  HttpApiProvider();

  Future<String?> sysStatus() async {
    try {
      var url =
          Uri.parse('http://192.168.10.1/data/sys_status.htm?_=1632792633582');
      var response = await http.get(url);

      if (response.statusCode != 200) return null;
      return response.body;
    } catch (e) {
      return null;
      //print(e);
    }
  }

  Future<String?> formScanningAp() async {
    try {
      var url = Uri.parse('http://192.168.10.1/mobile/form_scanning_ap.htm');
      var response = await http.post(url,
          body: {'refresh': 'Site Survey', 'ifname': "wlan0", 'opmode': "2"});

      if (response.statusCode != 200) return null;
      return response.body;
    } catch (e) {
      return null;
      //print(e);
    }
  }

  Future<List<NetworkModel>> apList() async {
    try {
      var url =
          Uri.parse('http://192.168.10.1/data/ap_list.htm?_=1632792847486');
      var response = await http.get(url);

      List<NetworkModel> neworksList = (json.decode(response.body) as List)
          .map((i) => NetworkModel.fromJson(i))
          .toList();

      if (response.statusCode != 200) return [];
      return neworksList;
    } catch (e) {
      return [];
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

      if (response.statusCode != 200) return null;
      return response.body;
    } catch (e) {
      return null;
      //print(e);
    }
  }

  Future<String?> getGoogle() async {
    try {
      var url = Uri.parse('https://www.google.com');
      var response = await http.get(url);

      if (response.statusCode != 200) return null;

      return response.body;
    } catch (e) {
      return null;
      //print(e);
    }
  }
}
