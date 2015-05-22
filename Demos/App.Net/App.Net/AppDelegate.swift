import UIKit
import Wall

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var window: UIWindow? = {
    return UIWindow(frame: UIScreen.mainScreen().bounds)
    }()
  lazy var navigationController = {
    return UINavigationController(rootViewController: ViewController())
    }()

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    window!.rootViewController = navigationController
    window!.backgroundColor = UIColor.whiteColor()
    window!.makeKeyAndVisible()

    return true
  }
}
