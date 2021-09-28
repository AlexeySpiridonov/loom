import 'screens/connect_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/info_screen.dart';
import 'screens/main_screen.dart';
import 'screens/networks_screen.dart';
import 'screens/settings_network_screen.dart';
import 'screens/wait_screen.dart';

const screens = [
  InfoScreen(text: "Расположите Loom около основного роутера."),
  InfoScreen(
      text:
          "Убедитесь что между loom и основным роутером нет стен и бытовой техники."),
  InfoScreen(text: "Дождитесь что загорится лампочка."),
  MainScreen(),
  NetworksScreen(),
  SettingsNetworkScreen(),
  WaitScreen(),
  InfoScreen(text: """
Ура! Все настроено!

Ваша домашняя сеть: myHomeNet

Сеть Loom: myHomeNet-R


Теперь можно унести Loom туда, где вам нужно улучшить Wi-Fi и включить в розетку.
"""),
  ConnectScreen(),
  FAQScreen(),
  InfoScreen(text: """Необходимо сбросить настройки Loom

Нажмите кнопку, держите 10 сек.   Подождите 20сек,пока лампочка wi-fi не загорится.

"""),
];
