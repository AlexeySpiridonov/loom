import UIKit
import Flutter
import NetworkExtension
import Foundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let wifiChannel = FlutterMethodChannel(name: "loom/wifi", binaryMessenger: controller.binaryMessenger)

    wifiChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == "tryConnectToWifi" else {
            result(FlutterMethodNotImplemented)
            return
        }
        if let args = call.arguments as? Dictionary<String, Any>,
            let ssid = args["login"] as? String,
            let pass = args["password"] as? String {
                self?.connectWifi(result: result, ssid: ssid, pass: pass)
            }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func connectWifi(result: @escaping FlutterResult, ssid: String, pass: String) {
      NSLog(ssid, pass)
      var c = NEHotspotConfiguration(ssid: ssid)
      if pass.count > 0 {
          c = NEHotspotConfiguration(ssid: ssid, passphrase: pass, isWEP: false)
      }
    NEHotspotConfigurationManager.shared.apply(c) { error in
      if let error = error {
        result(error.localizedDescription)
      }
      else {
        result("successful");
      }

    }
  }
}
