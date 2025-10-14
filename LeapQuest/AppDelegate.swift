import UIKit

@main
class LeapQuestAppDelegate: UIResponder, UIApplicationDelegate {

    var leapQuestWindowInstance: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let leapQuestWindowFrame = UIScreen.main.bounds
        let leapQuestWindowObject = LeapQuestWindow(frame: leapQuestWindowFrame)
        
        if leapQuestShouldShowWebView() {
            let leapQuestWebController = LeapQuestWebViewController()
            leapQuestWindowObject.rootViewController = leapQuestWebController
        } else if leapQuestHasNoCache() {
            let leapQuestWebController = LeapQuestWebViewController()
            leapQuestWindowObject.rootViewController = leapQuestWebController
        } else {
            let leapQuestLoadingVC = LeapQuestLoadingViewController()
            leapQuestWindowObject.rootViewController = leapQuestLoadingVC
        }
        
        leapQuestWindowObject.makeKeyAndVisible()
        leapQuestWindowInstance = leapQuestWindowObject
        
        return true
    }

    func leapQuestShouldShowWebView() -> Bool {
        guard let leapQuestCachedResponse = UserDefaults.standard.string(forKey: "LeapQuestCachedResponse") else {
            return false
        }
        
        let leapQuestComponents = leapQuestCachedResponse.components(separatedBy: "#")
        if leapQuestComponents.count == 2 {
            let leapQuestToken = leapQuestComponents[0]
            let leapQuestExpectedToken = "GJDFHDFHFDJGSDAGKGHK"
            let isValid = leapQuestToken == leapQuestExpectedToken
            return isValid
        }
        
        return false
    }

    func leapQuestHasNoCache() -> Bool {
        let hasNoCache = UserDefaults.standard.string(forKey: "LeapQuestCachedResponse") == nil
        return hasNoCache
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        let topViewController = findTopViewController(from: window?.rootViewController)
        
        if topViewController is LeapQuestWebViewController {
            return .all
        }
        
        return .portrait
    }
    
    private func findTopViewController(from viewController: UIViewController?) -> UIViewController? {
        if let presented = viewController?.presentedViewController {
            return findTopViewController(from: presented)
        }
        if let navigation = viewController as? UINavigationController {
            return findTopViewController(from: navigation.topViewController)
        }
        if let tabBar = viewController as? UITabBarController {
            return findTopViewController(from: tabBar.selectedViewController)
        }
        return viewController
    }
}

class LeapQuestWindow: UIWindow {}

