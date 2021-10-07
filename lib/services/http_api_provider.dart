// ignore_for_file: unused_local_variable
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:loom/models/error_answer_model.dart';
import 'package:loom/models/info_status_model.dart';
import 'package:loom/models/network_model.dart';

class HttpApiProvider {
  HttpApiProvider();

  Future<InfoStatusModel> sysStatus() async {
    // var url =
    //     Uri.parse('http://192.168.10.1/data/sys_status.htm?_=1632792633582');
    // var response = await http.get(url);

    Map<String, dynamic> body = jsonDecode(answers[0]); // response.body
    return InfoStatusModel.fromJson(body);
  }

  Future<String?> formScanningAp() async {
    try {
      var url = Uri.parse('http://192.168.10.1/mobile/form_scanning_ap.htm');
      var response = await http.post(url,
          body: {'refresh': 'Site Survey', 'ifname': "wlan0", 'opmode': "2"});
      // var response = await http.post(url, body: '{errCode: 0,errMsg: ""}');

      return response.body;
    } catch (e) {
      print(e);
    }
  }

  Future<List<NetworkModel>> apList() async {
    var url = Uri.parse('http://192.168.10.1/data/ap_list.htm?_=1632792847486');
    var response = await http.get(url);

    List<NetworkModel> neworksList = (json.decode(response.body) as List)
        .map((i) => NetworkModel.fromJson(i))
        .toList();

    return neworksList;
  }

  Future<ErrorAnswerModel> formSetRepeater({
    required String ssid,
    required String channal,
    required String networkName,
    required String password,
  }) async {
    var url = Uri.parse('http://192.168.10.1/mobile/form_set_repeater.htm');
    var response = await http.post(url, body: {
      "pocket_wpa_tkip_aes": "",
      "pocket_wpa2_tkip_aes": "aes",
      "wpa2ciphersuite0": "aes",
      "ciphersuite0": "",
      "pocket_channel": channal,
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
      "band0": channal,
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

    await Future.delayed(const Duration(seconds: 30), () {});

    Map<String, dynamic> body = jsonDecode(answers[1]); // response.body
    return ErrorAnswerModel.fromJson(body);
  }
}

List<String> answers = [
  '''{
    "current_model":'',
    "ssid_24g":'spallNet-loom',
    "wan_dhcp":'1',
    "lan_ip":'192.168.10.1',
    "lan_mask":'255.255.255.0',
    "lan_gateway":'192.168.10.1',
    "wan_ip":'192.168.0.108',
    "wan_mask":'255.255.255.0',
    "wan_gateway":'192.168.0.1',
    "wan_dns1":'0.0.0.0',
    "encrypt0":'6',
    "channel0":'0',
    "pskValue0":'novosibirsk',
    "pppUserName":'',
    "pppPassword":'',
    "pppServiceName":'',
    "op_mode":'2',
    "rp_enable":'1',
    "rp_0_status":'Connected',
    "client_num":'1',
    "link_status":'LinkDown',
    "dhcp_status":'2',
    "safe_mode":'0',
    "bridge_state":'',
    "ligths":'0',
    
    "mac_addr":'40:a5:ef:3d:30:f0',
    "version":'N300-V1.2',
    "uptime":'758577',
    "cur_sys_time":'1632792623',
    "cur_sys_year":'2021',
    "cur_sys_month":'9',
    "cur_sys_day":'28',
    "cur_sys_hour":'9',
    "cur_sys_min":'30',
    "cur_sys_sec":'23',
    "cur_time_zone":'-8 1',
    "buildtime":'Thu, 03 Jun 2021 16:29:40 +0800',
    "first_login":'1',

    "login_flag":'',
  }
  ''',
  '{"errCode": "0", "errMsg": ""}',
  '''
    [{"wl_ss_ssid":"spallNet","wl_ss_bssid":"98:de:d0:33:19:49",  					"wl_ss_channel":"11","wl_ss_secmo":"WPA2-PSK",					"wl_ss_sin":"66","wl_ss_param":"",													"wl_wpa_tkip_aes":"","wl_wpa2_tkip_aes":"aes",										"wl_count_num":"0"	},{"wl_ss_ssid":"Sosedi","wl_ss_bssid":"84:c9:b2:6d:e4:a7",  					"wl_ss_channel":"2","wl_ss_secmo":"WPA-PSK/WPA2-PSK",											"wl_ss_sin":"46","wl_ss_param":"",													"wl_wpa_tkip_aes":"aes/tkip","wl_wpa2_tkip_aes":"aes/tkip",										"wl_count_num":"1"	},{"wl_ss_ssid":"NetGate","wl_ss_bssid":"98:de:d0:33:04:01",  					"wl_ss_channel":"4","wl_ss_secmo":"WPA2-PSK",											"wl_ss_sin":"38","wl_ss_param":"",													"wl_wpa_tkip_aes":"","wl_wpa2_tkip_aes":"aes",										"wl_count_num":"2"	},{"wl_ss_ssid":"Novotelecom 8 168","wl_ss_bssid":"f0:7d:68:47:f5:f8",  					"wl_ss_channel":"1","wl_ss_secmo":"WPA-PSK/WPA2-PSK",											"wl_ss_sin":"34","wl_ss_param":"",													"wl_wpa_tkip_aes":"aes","wl_wpa2_tkip_aes":"aes",										"wl_count_num":"3"	},{"wl_ss_ssid":"Keenetic-0047","wl_ss_bssid":"1c:74:0d:8d:13:40",  					"wl_ss_channel":"6","wl_ss_secmo":"WPA2-PSK",											"wl_ss_sin":"26","wl_ss_param":"",													"wl_wpa_tkip_aes":"","wl_wpa2_tkip_aes":"aes",										"wl_count_num":"4"	},{"wl_ss_ssid":"Zyzik","wl_ss_bssid":"d8:47:32:31:f9:2a",  					"wl_ss_channel":"4","wl_ss_secmo":"WPA2-PSK",											"wl_ss_sin":"22","wl_ss_param":"",													"wl_wpa_tkip_aes":"","wl_wpa2_tkip_aes":"aes",										"wl_count_num":"5"	},{"wl_ss_ssid":"DaNet-RT","wl_ss_bssid":"20:10:7a:a2:95:6f",  					"wl_ss_channel":"1","wl_ss_secmo":"WPA2-PSK",											"wl_ss_sin":"18","wl_ss_param":"",													"wl_wpa_tkip_aes":"","wl_wpa2_tkip_aes":"aes",										"wl_count_num":"6"	},{"wl_ss_ssid":"DIR-615","wl_ss_bssid":"78:32:1b:6a:14:67",  					"wl_ss_channel":"5","wl_ss_secmo":"WPA2-PSK",											"wl_ss_sin":"16","wl_ss_param":"",													"wl_wpa_tkip_aes":"","wl_wpa2_tkip_aes":"aes",										"wl_count_num":"7"	}]
  ''',
];
