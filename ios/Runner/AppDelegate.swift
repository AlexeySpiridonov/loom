import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "loom/wifi", binaryMessenger: controller.binaryMessenger)

    batteryChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult, login: String, password String) -> Void in
      guard call.method == "tryConnectToWifi" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.receiveBatteryLevel(result: result, login: login, password: password)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveBatteryLevel(result: FlutterResult, login: String, password: String) {
    let wiFiConfig = NEHotspotConfiguration(ssid: login, passphrase: password, isWEP: false)

    NEHotspotConfigurationManager.shared.apply(wiFiConfig) { error in
      if let error = error {
        result(error.localizedDescription)
      }
      else {
        result("successful");
      }
    }
  }
}