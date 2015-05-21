import UIKit
import CoreData
import Wall

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)

        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = UIColor(red:1.000, green:0.976, blue:0.741, alpha: 1)
        appearance.titleTextAttributes = [NSFontAttributeName : UIFont(name: "AvenirNext-DemiBold", size: 20)!,
            NSForegroundColorAttributeName : UIColor(red:0.725, green:0.400, blue:0.106, alpha: 1)]

        navigationController = UINavigationController(rootViewController: ViewController(coder: nil))

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
