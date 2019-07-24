import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    
    var window: UIWindow?

    // MARK: Functions
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Settings.initialize()

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = NavigationController(rootViewController: ScaleViewController())
        window!.makeKeyAndVisible()
        
        return true
    }
}
