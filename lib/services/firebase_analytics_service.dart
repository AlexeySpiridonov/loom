import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class FirebaseAnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();
  FirebaseAnalyticsObserver appAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future log(String? log) async {
    await _analytics.logEvent(
      name: 'log',
      parameters: {
        'log': log,
      },
    );
  }
}
