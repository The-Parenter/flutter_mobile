import UIKit
import Flutter
import Firebase
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
        GMSServices.provideAPIKey("AIzaSyBswzNSlJ1rqDncjYmvkOqQTho6NzivfTQ")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
