import UIKit

class LeapQuestTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestTabBar()
    }
    
        private func setupLeapQuestTabBar() {
            let leapQuestFrogVC = LeapQuestFrogViewController()
            let leapQuestAchievementsVC = LeapQuestAchievementsViewController()
            let leapQuestPuzzlesVC = LeapQuestPuzzlesViewController()
            let leapQuestCatalogVC = LeapQuestCatalogViewController()
            let leapQuestSettingsVC = LeapQuestSettingsViewController()
        
        leapQuestFrogVC.tabBarItem = UITabBarItem(
            title: "🐸",
            image: UIImage(systemName: "leaf.fill"),
            selectedImage: UIImage(systemName: "leaf.fill")
        )
        
        leapQuestAchievementsVC.tabBarItem = UITabBarItem(
            title: "🏅",
            image: UIImage(systemName: "trophy.fill"),
            selectedImage: UIImage(systemName: "trophy.fill")
        )
        
        leapQuestPuzzlesVC.tabBarItem = UITabBarItem(
            title: "🧩",
            image: UIImage(systemName: "puzzlepiece.fill"),
            selectedImage: UIImage(systemName: "puzzlepiece.fill")
        )
        
        leapQuestCatalogVC.tabBarItem = UITabBarItem(
            title: "📖",
            image: UIImage(systemName: "book.fill"),
            selectedImage: UIImage(systemName: "book.fill")
        )
        
            leapQuestSettingsVC.tabBarItem = UITabBarItem(
                title: "⚙️",
                image: UIImage(systemName: "gearshape.fill"),
                selectedImage: UIImage(systemName: "gearshape.fill")
            )
        
            let leapQuestViewControllers = [
                leapQuestFrogVC,
                leapQuestAchievementsVC,
                leapQuestPuzzlesVC,
                leapQuestCatalogVC,
                leapQuestSettingsVC
            ]
        
        viewControllers = leapQuestViewControllers.map { LeapQuestNavigationController(rootViewController: $0) }
        
        setupLeapQuestModernTabBar()
    }
    
    private func setupLeapQuestModernTabBar() {
        let leapQuestTabBarAppearance = UITabBarAppearance()
        leapQuestTabBarAppearance.configureWithTransparentBackground()
        
        let leapQuestBlurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let leapQuestBlurView = UIVisualEffectView(effect: leapQuestBlurEffect)
        leapQuestBlurView.frame = tabBar.bounds
        leapQuestBlurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(leapQuestBlurView, at: 0)
        
        leapQuestTabBarAppearance.backgroundColor = UIColor.clear
        
        tabBar.tintColor = LeapQuestColorTheme.Text.primary
        tabBar.unselectedItemTintColor = LeapQuestColorTheme.Text.secondary
        tabBar.standardAppearance = leapQuestTabBarAppearance
        tabBar.scrollEdgeAppearance = leapQuestTabBarAppearance
        
        tabBar.layer.shadowColor = LeapQuestColorTheme.Shadow.primary.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 8
        tabBar.layer.shadowOpacity = 0.1
        
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 10
    }
}
