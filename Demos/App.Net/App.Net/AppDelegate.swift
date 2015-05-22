import UIKit
import Wall

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

    let vc = ViewController()
    let nav = UINavigationController(rootViewController: vc)

    self.window!.rootViewController = nav
    self.window!.backgroundColor = UIColor.whiteColor()
    self.window!.makeKeyAndVisible()
    return true
  }
}
