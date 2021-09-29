// ignore_for_file: non_constant_identifier_names

class InfoStatusModel {
  String current_model;
  String ssid_24g;
  String wan_dhcp;
  String lan_ip;
  String lan_mask;
  String lan_gateway;
  String wan_ip;
  String wan_mask;
  String wan_gateway;
  String wan_dns1;
  String encrypt0;
  String channel0;
  String pskValue0;
  String pppUserName;
  String pppPassword;
  String pppServiceName;
  String op_mode;
  String rp_enable;
  String rp_0_status;
  String client_num;
  String link_status;
  String dhcp_status;
  String safe_mode;
  String bridge_state;
  String ligths;
  String mac_addr;
  String version;
  String uptime;
  String cur_sys_time;
  String cur_sys_year;
  String cur_sys_month;
  String cur_sys_day;
  String cur_sys_hour;
  String cur_sys_min;
  String cur_sys_sec;
  String cur_time_zone;
  String buildtime;
  String first_login;
  String login_flag;

  InfoStatusModel({
    required this.current_model,
    required this.ssid_24g,
    required this.wan_dhcp,
    required this.lan_ip,
    required this.lan_mask,
    required this.lan_gateway,
    required this.wan_ip,
    required this.wan_mask,
    required this.wan_gateway,
    required this.wan_dns1,
    required this.encrypt0,
    required this.channel0,
    required this.pskValue0,
    required this.pppUserName,
    required this.pppPassword,
    required this.pppServiceName,
    required this.op_mode,
    required this.rp_enable,
    required this.rp_0_status,
    required this.client_num,
    required this.link_status,
    required this.dhcp_status,
    required this.safe_mode,
    required this.bridge_state,
    required this.ligths,
    required this.mac_addr,
    required this.version,
    required this.uptime,
    required this.cur_sys_time,
    required this.cur_sys_year,
    required this.cur_sys_month,
    required this.cur_sys_day,
    required this.cur_sys_hour,
    required this.cur_sys_min,
    required this.cur_sys_sec,
    required this.cur_time_zone,
    required this.buildtime,
    required this.first_login,
    required this.login_flag,
  });

  InfoStatusModel.fromJson(Map<String, dynamic> json)
      : current_model = json['current_model'],
        ssid_24g = json['ssid_24g'],
        wan_dhcp = json['wan_dhcp'],
        lan_ip = json['lan_ip'],
        lan_mask = json['lan_mask'],
        lan_gateway = json['lan_gateway'],
        wan_ip = json['wan_ip'],
        wan_mask = json['wan_mask'],
        wan_gateway = json['wan_gateway'],
        wan_dns1 = json['wan_dns1'],
        encrypt0 = json['encrypt0'],
        channel0 = json['channel0'],
        pskValue0 = json['pskValue0'],
        pppUserName = json['pppUserName'],
        pppPassword = json['pppPassword'],
        pppServiceName = json['pppServiceName'],
        op_mode = json['op_mode'],
        rp_enable = json['rp_enable'],
        rp_0_status = json['rp_0_status'],
        client_num = json['client_num'],
        link_status = json['link_status'],
        dhcp_status = json['dhcp_status'],
        safe_mode = json['safe_mode'],
        bridge_state = json['bridge_state'],
        ligths = json['ligths'],
        mac_addr = json['mac_addr'],
        version = json['version'],
        uptime = json['uptime'],
        cur_sys_time = json['cur_sys_time'],
        cur_sys_year = json['cur_sys_year'],
        cur_sys_month = json['cur_sys_month'],
        cur_sys_day = json['cur_sys_day'],
        cur_sys_hour = json['cur_sys_hour'],
        cur_sys_min = json['cur_sys_min'],
        cur_sys_sec = json['cur_sys_sec'],
        cur_time_zone = json['cur_time_zone'],
        buildtime = json['buildtime'],
        first_login = json['first_login'],
        login_flag = json['login_flag'];
}
