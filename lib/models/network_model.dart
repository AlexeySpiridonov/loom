// ignore_for_file: non_constant_identifier_names

class NetworkModel {
  final String wl_count_num;
  final String wl_ss_bssid;
  final String wl_ss_channel;
  final String wl_ss_param;
  final String wl_ss_secmo;
  final String wl_ss_sin;
  final String wl_ss_ssid;
  final String wl_wpa2_tkip_aes;
  final String wl_wpa_tkip_aes;

  NetworkModel({
    required this.wl_count_num,
    required this.wl_ss_bssid,
    required this.wl_ss_channel,
    required this.wl_ss_param,
    required this.wl_ss_secmo,
    required this.wl_ss_sin,
    required this.wl_ss_ssid,
    required this.wl_wpa2_tkip_aes,
    required this.wl_wpa_tkip_aes,
  });

  NetworkModel.fromJson(Map<String, dynamic> json)
      : wl_count_num = json['wl_count_num'],
        wl_ss_bssid = json['wl_ss_bssid'],
        wl_ss_channel = json['wl_ss_channel'],
        wl_ss_param = json['wl_ss_param'],
        wl_ss_secmo = json['wl_ss_secmo'],
        wl_ss_sin = json['wl_ss_sin'],
        wl_ss_ssid = json['wl_ss_ssid'],
        wl_wpa2_tkip_aes = json['wl_wpa2_tkip_aes'],
        wl_wpa_tkip_aes = json['wl_wpa_tkip_aes'];
}
