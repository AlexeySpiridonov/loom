import 'package:get_it/get_it.dart';
import 'firebase_analytics_service.dart';

final serviceLocator = GetIt.instance;

void setUp() {
  serviceLocator.registerLazySingleton(() => FirebaseAnalyticsService());
  fbLog("Application start");
}

void fbLog(String? log) {
  serviceLocator<FirebaseAnalyticsService>().log(log);
}
