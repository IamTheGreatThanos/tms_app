import UIKit
import Flutter
import YandexMapsMobile
// import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//     YMKMapKit.setApiKey("159fde91-5c8c-4bd7-932b-6117e3987a13")
    YMKMapKit.setApiKey("b51c2cab-1212-4f56-a22d-77d0a2632811")
    GeneratedPluginRegistrant.register(with: self)
//     FirebaseApp.configure()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
