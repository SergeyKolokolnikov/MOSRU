
import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //SVProgressHUD configure
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(UIColor.init(white: 0, alpha: 0.9))
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setForegroundColor(UIColor.white)

        let vm = MainModuleVM()
        let vc = MainModuleVC(viewModel: vm)
        let nc = UINavigationController(rootViewController: vc)
        //nc.navigationBar.isTranslucent = false
        //nc.navigationBar.barTintColor = UIColor.white
        nc.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.label,
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)
            ]
            nc.navigationBar.largeTitleTextAttributes = attrs
        }
        //nc.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        //nc.navigationBar.shadowImage = UIImage()
        //nc.setNavigationBarHidden(true, animated: false)
        let window = UIApplication.shared.keyWindow ?? UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = nc
        window.makeKeyAndVisible()

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    func openMainVC(){
//        let vc = MainVC()
//        //vc.user = AuthService.currenUser()
//        let nc = UINavigationController(rootViewController: vc)
//        nc.navigationBar.barTintColor = Color.DarkTheme.background
//        nc.navigationBar.backgroundColor = Color.DarkTheme.background
//        nc.navigationBar.tintColor = Color.DarkTheme.textColor1
//        nc.navigationBar.isTranslucent = false
//        nc.navigationBar.shadowImage = UIImage()
//        nc.navigationBar.titleTextAttributes = [.foregroundColor: Color.DarkTheme.textColor1]
//        nc.navigationBar.backIndicatorImage = UIImage()
//        let window = UIApplication.shared.keyWindow ?? UIWindow(frame: UIScreen.main.bounds)
//        self.window = window
//        window.rootViewController = nc
//        window.makeKeyAndVisible()

    }
    
    func openWelcomeVC(){
//        let vc = WelcomeScreenVC1()
//        let nc = UINavigationController(rootViewController: vc)
//        nc.setNavigationBarHidden(true, animated: false)
//        nc.navigationBar.barTintColor = Color.DarkTheme.background.withAlphaComponent(0)
//        nc.navigationBar.backgroundColor = Color.DarkTheme.background.withAlphaComponent(0)
//        nc.navigationBar.tintColor = Color.DarkTheme.textColor1
//        nc.navigationBar.isTranslucent = false
//        nc.navigationBar.shadowImage = UIImage()
//        nc.navigationBar.titleTextAttributes = [.foregroundColor: Color.DarkTheme.textColor1]
//        nc.navigationBar.backIndicatorImage = UIImage()
//        let window = UIApplication.shared.keyWindow ?? UIWindow(frame: UIScreen.main.bounds)
//        self.window = window
//        window.rootViewController = nc
//        window.makeKeyAndVisible()
//
    }
    
}
