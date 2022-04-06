import UIKit
import Flutter

let channel: String = "cross-platform channel"
let methodSystemVersion: String = "METHOD_SYSTEM_VERSION"

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        FlutterMethodChannel(name: channel, binaryMessenger: controller.binaryMessenger).setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
                switch(call.method) {
                case methodSystemVersion:
                    let version: String = self.getSystemVersion()
                    result(version)
                    break
                    
                default:
                    result(FlutterError(code: "01", message: "method name not found -> \(call.method)", details: nil))
                    break
                }
            }
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func getSystemVersion() -> String {
        let device: UIDevice = UIDevice.current
        return "\(device.systemName) \(device.systemVersion)"
    }

}
