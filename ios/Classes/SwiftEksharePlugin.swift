import Flutter
import UIKit

public class SwiftEksharePlugin: NSObject, FlutterPlugin {
  private var result: FlutterResult?
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ekshare", binaryMessenger: registrar.messenger())
    let instance = SwiftEksharePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // result("iOS " + UIDevice.current.systemVersion)
    // shareOptions
     if ("shareOptions" == call.method) {
        self.result = result
        result(shareFile(call: call))
    } 
    if("copyToClipboard" == call.method) {
      self.result = result
      result(copyToClipboard(call: call))
    }
    
    else {
        result(FlutterMethodNotImplemented)
    }
  }

  public func copyToClipboard(call: FlutterMethodCall) -> Bool {
    let args = call.arguments as? [String: Any?]
    let content = args!["content"] as? String

    let pasteboard = UIPasteboard.general
    pasteboard.string = content

    return true
  }

  public func shareFile(call: FlutterMethodCall) -> Bool {
    let args = call.arguments as? [String: Any?]

    let title = args!["title"] as? String
    let text = args!["content"] as? String
    let filePath = args!["image"] as? String

    if(text == nil || text!.isEmpty  ) {
      return false
    }
    var sharedItems : Array<NSObject> = Array()

    if (text != nil && text != ""){
      sharedItems.append((text as NSObject?)!)
    }
    if(filePath != nil && filePath != ""){
      let filePath = URL(fileURLWithPath: filePath!)
      sharedItems.append(filePath as NSObject)
    }

    let activityViewController = UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)

    if UIDevice.current.userInterfaceIdiom == .pad {
          activityViewController.popoverPresentationController?.sourceView = UIApplication.topViewController()?.view
          if let view = UIApplication.topViewController()?.view {
              activityViewController.popoverPresentationController?.permittedArrowDirections = []
              activityViewController.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
          }
        }

    DispatchQueue.main.async {
      UIApplication.topViewController()!.present(activityViewController, animated: true, completion: nil)
    }
  return true
  }
    

      private func presentActivityView(activityViewController: UIActivityViewController) {
            // using this fake view controller to prevent this iOS 13+ dismissing the top view when sharing with "Save Image" option
            let fakeViewController = TransparentViewController()
            fakeViewController.modalPresentationStyle = .overFullScreen

            activityViewController.completionWithItemsHandler = { [weak fakeViewController] _, _, _, _ in
                if let presentingViewController = fakeViewController?.presentingViewController {
                    presentingViewController.dismiss(animated: false, completion: nil)
                } else {
                    fakeViewController?.dismiss(animated: false, completion: nil)
                }
            }

            UIApplication.topViewController()?.present(fakeViewController, animated: true) { [weak fakeViewController] in
                fakeViewController?.present(activityViewController, animated: true, completion: nil)
            }
        }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

class TransparentViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
    }
}
