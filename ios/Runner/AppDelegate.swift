import UIKit
import Flutter
import GoogleMaps
import IQKeyboardManagerSwift

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      IQKeyboardManager.shared.isEnabled = true

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
