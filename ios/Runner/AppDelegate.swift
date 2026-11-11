import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "CalmReminders")!
    let channel = FlutterMethodChannel(name: "calm_steps/reminders", binaryMessenger: registrar.messenger())
    channel.setMethodCallHandler { call, result in
      let center = UNUserNotificationCenter.current()
      if call.method == "cancel" {
        center.removePendingNotificationRequests(withIdentifiers: ["meditation"])
        center.removeDeliveredNotifications(withIdentifiers: ["meditation"])
        result(nil)
      } else if call.method == "schedule", let args = call.arguments as? [String: Any], let milliseconds = args["time"] as? NSNumber {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { allowed, error in
          if !allowed {
            DispatchQueue.main.async { result(FlutterError(code: "PERMISSION", message: "Allow notifications in Settings.", details: nil)) }
            return
          }
          let content = UNMutableNotificationContent()
          content.title = args["title"] as? String ?? "Meditation Reminder"
          content.body = "Time for your daily meditation!"
          content.sound = .default
          let delay = milliseconds.doubleValue / 1000 - Date().timeIntervalSince1970
          if delay <= 0 {
            DispatchQueue.main.async { result(FlutterError(code: "TIME", message: "Choose a future time.", details: nil)) }
            return
          }
          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, delay), repeats: false)
          center.add(UNNotificationRequest(identifier: "meditation", content: content, trigger: trigger)) { error in
            DispatchQueue.main.async {
              if let error = error { result(FlutterError(code: "SCHEDULE", message: error.localizedDescription, details: nil)) }
              else { result(nil) }
            }
          }
        }
      } else { result(FlutterMethodNotImplemented) }
    }
  }
}
