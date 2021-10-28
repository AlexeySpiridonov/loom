import UIKit
import Flutter
import NetworkExtension
import Foundation
//import os

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
            //NSLog("wifiChannel","FlutterMethodNotImplemented")
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
      //NSLog("35: %@, %@",ssid, pass)
      var c = NEHotspotConfiguration(ssid: ssid)
      if pass.count > 0 {
          c = NEHotspotConfiguration(ssid: ssid, passphrase: pass, isWEP: false)
      }
    NEHotspotConfigurationManager.shared.apply(c) { error in
      if let error = error as NSError?{
        //N§SLog("42: %@, %i, %@", error.localizedDescription, error.code)
        result(error.localizedDescription)
      }
      else {
        //NSLog("46: %s", error?.localizedDescription)
        //NSLog("47: successful")
        result("successful");
      }

    }
  }
}
