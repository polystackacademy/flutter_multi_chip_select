import Flutter
import UIKit

public class SwiftFlutterMultiChipSelectPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_multi_chip_select", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMultiChipSelectPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
