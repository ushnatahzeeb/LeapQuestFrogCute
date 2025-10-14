import Foundation

class LeapQuestCatalogViewModel {
    
    weak var leapQuestCatalogDelegate: LeapQuestCatalogViewModelDelegate?
    
    private let leapQuestStorageManager: LeapQuestStorageManager
    private var leapQuestCurrentCategory: LeapQuestCatalogCategory = .platforms
    private var leapQuestCatalogItems: [LeapQuestCatalogItemModel] = []
    
    var leapQuestCatalogCurrentItems: [LeapQuestCatalogItemModel] {
        return leapQuestCatalogItems.filter { $0.leapQuestCatalogItemCategory == leapQuestCurrentCategory }
    }
    
    init() {
        leapQuestStorageManager = LeapQuestStorageManager.shared
        loadLeapQuestCatalogItems()
    }
    
    private func loadLeapQuestCatalogItems() {
        leapQuestCatalogItems.removeAll()
        
        loadLeapQuestPlatformCatalogItems()
        loadLeapQuestPuzzleCatalogItems()
        loadLeapQuestAchievementCatalogItems()
        loadLeapQuestFactCatalogItems()
    }
    
    private func loadLeapQuestPlatformCatalogItems() {
        let leapQuestPlatformTypes = LeapQuestPlatformType.allCases
        
        for platformType in leapQuestPlatformTypes {
            let leapQuestIsUnlocked = leapQuestStorageManager.leapQuestIsPlatformTypeUnlocked(platformType.rawValue)
            
            let leapQuestCatalogItem = LeapQuestCatalogItemModel(
                leapQuestCatalogItemId: "platform_\(platformType.rawValue.lowercased())",
                leapQuestCatalogItemEmoji: platformType.leapQuestPlatformEmoji,
                leapQuestCatalogItemTitle: "\(platformType.rawValue) Platform",
                leapQuestCatalogItemDescription: "A \(platformType.rawValue.lowercased()) platform for jumping across the river",
                leapQuestCatalogItemIsUnlocked: leapQuestIsUnlocked,
                leapQuestCatalogItemCategory: .platforms
            )
            
            leapQuestCatalogItems.append(leapQuestCatalogItem)
        }
    }
    
    private func loadLeapQuestPuzzleCatalogItems() {
        let leapQuestPuzzleTypes = [
            ("mirror", "🪞", "Mirror Puzzles", "Reflect light to solve these puzzles"),
            ("block", "🧱", "Block Puzzles", "Arrange blocks to create paths"),
            ("switch", "🔘", "Switch Puzzles", "Activate switches in sequence"),
            ("combination", "🔗", "Combination Puzzles", "Find the right combination"),
            ("sequence", "🎯", "Sequence Puzzles", "Complete complex sequences"),
            ("logic", "🧠", "Logic Puzzles", "Solve logic gate circuits"),
            ("master", "🎪", "Master Puzzles", "Ultimate challenge puzzles")
        ]
        
        for (leapQuestType, leapQuestEmoji, leapQuestTitle, leapQuestDescription) in leapQuestPuzzleTypes {
            let leapQuestIsUnlocked = leapQuestStorageManager.leapQuestIsPuzzleTypeUnlocked(leapQuestType)
            
            let leapQuestCatalogItem = LeapQuestCatalogItemModel(
                leapQuestCatalogItemId: "puzzle_\(leapQuestType)",
                leapQuestCatalogItemEmoji: leapQuestEmoji,
                leapQuestCatalogItemTitle: leapQuestTitle,
                leapQuestCatalogItemDescription: leapQuestDescription,
                leapQuestCatalogItemIsUnlocked: leapQuestIsUnlocked,
                leapQuestCatalogItemCategory: .puzzles
            )
            
            leapQuestCatalogItems.append(leapQuestCatalogItem)
        }
    }
    
    private func loadLeapQuestAchievementCatalogItems() {
        let leapQuestAchievementTypes = [
            ("first_jump", "🦘", "First Jump", "Make your first platform jump"),
            ("frog_master", "👑", "Frog Master", "Complete all game levels"),
            ("puzzle_solver", "🧩", "Puzzle Solver", "Solve multiple puzzles"),
            ("coin_collector", "💰", "Coin Collector", "Collect many LeapCoins"),
            ("platform_explorer", "🌿", "Platform Explorer", "Try all platform types"),
            ("speed_demon", "⚡", "Speed Demon", "Complete levels quickly"),
            ("perfectionist", "💎", "Perfectionist", "Complete puzzles without hints")
        ]
        
        for (leapQuestType, leapQuestEmoji, leapQuestTitle, leapQuestDescription) in leapQuestAchievementTypes {
            let leapQuestIsUnlocked = leapQuestStorageManager.leapQuestIsAchievementUnlocked(leapQuestType)
            
            let leapQuestCatalogItem = LeapQuestCatalogItemModel(
                leapQuestCatalogItemId: "achievement_\(leapQuestType)",
                leapQuestCatalogItemEmoji: leapQuestEmoji,
                leapQuestCatalogItemTitle: leapQuestTitle,
                leapQuestCatalogItemDescription: leapQuestDescription,
                leapQuestCatalogItemIsUnlocked: leapQuestIsUnlocked,
                leapQuestCatalogItemCategory: .achievements
            )
            
            leapQuestCatalogItems.append(leapQuestCatalogItem)
        }
    }
    
    func leapQuestCatalogChangeCategory(_ leapQuestCategoryIndex: Int) {
        if let leapQuestCategory = LeapQuestCatalogCategory(rawValue: leapQuestCategoryIndex) {
            leapQuestCurrentCategory = leapQuestCategory
            leapQuestCatalogDelegate?.leapQuestCatalogViewModelDidUpdate()
        }
    }
    
    func leapQuestCatalogSelectItem(_ leapQuestItemId: String) {
        if let leapQuestItem = leapQuestCatalogItems.first(where: { $0.leapQuestCatalogItemId == leapQuestItemId }) {
            handleLeapQuestCatalogItemSelection(leapQuestItem)
        }
    }
    
    private func handleLeapQuestCatalogItemSelection(_ leapQuestItem: LeapQuestCatalogItemModel) {
        switch leapQuestItem.leapQuestCatalogItemCategory {
        case .platforms:
            handleLeapQuestPlatformSelection(leapQuestItem)
        case .puzzles:
            handleLeapQuestPuzzleSelection(leapQuestItem)
        case .achievements:
            handleLeapQuestAchievementSelection(leapQuestItem)
        case .facts:
            handleLeapQuestFactSelection(leapQuestItem)
        }
    }
    
    private func handleLeapQuestPlatformSelection(_ leapQuestItem: LeapQuestCatalogItemModel) {
        if leapQuestItem.leapQuestCatalogItemIsUnlocked {
            showLeapQuestPlatformDetails(leapQuestItem)
        } else {
            showLeapQuestPlatformLockedMessage(leapQuestItem)
        }
    }
    
    private func handleLeapQuestPuzzleSelection(_ leapQuestItem: LeapQuestCatalogItemModel) {
        if leapQuestItem.leapQuestCatalogItemIsUnlocked {
            showLeapQuestPuzzleDetails(leapQuestItem)
        } else {
            showLeapQuestPuzzleLockedMessage(leapQuestItem)
        }
    }
    
    private func handleLeapQuestAchievementSelection(_ leapQuestItem: LeapQuestCatalogItemModel) {
        showLeapQuestAchievementDetails(leapQuestItem)
    }
    
    private func showLeapQuestPlatformDetails(_ leapQuestItem: LeapQuestCatalogItemModel) {
        print("Platform Details: \(leapQuestItem.leapQuestCatalogItemTitle)")
    }
    
    private func showLeapQuestPuzzleDetails(_ leapQuestItem: LeapQuestCatalogItemModel) {
        print("Puzzle Details: \(leapQuestItem.leapQuestCatalogItemTitle)")
    }
    
    private func showLeapQuestAchievementDetails(_ leapQuestItem: LeapQuestCatalogItemModel) {
        print("Achievement Details: \(leapQuestItem.leapQuestCatalogItemTitle)")
    }
    
    private func showLeapQuestPlatformLockedMessage(_ leapQuestItem: LeapQuestCatalogItemModel) {
        print("Platform Locked: \(leapQuestItem.leapQuestCatalogItemTitle) - Complete previous levels to unlock")
    }
    
    private func showLeapQuestPuzzleLockedMessage(_ leapQuestItem: LeapQuestCatalogItemModel) {
        print("Puzzle Locked: \(leapQuestItem.leapQuestCatalogItemTitle) - Solve previous puzzles to unlock")
    }
    
    // MARK: - Facts
    private func loadLeapQuestFactCatalogItems() {
        let leapQuestFacts = LeapQuestFactData.leapQuestFacts
        
        for fact in leapQuestFacts {
            let leapQuestCatalogItem = LeapQuestCatalogItemModel(
                leapQuestCatalogItemId: fact.id.uuidString,
                leapQuestCatalogItemEmoji: fact.leapQuestImageEmoji,
                leapQuestCatalogItemTitle: fact.leapQuestTitle,
                leapQuestCatalogItemDescription: fact.leapQuestShortDescription,
                leapQuestCatalogItemIsUnlocked: true,
                leapQuestCatalogItemCategory: .facts
            )
            
            leapQuestCatalogItems.append(leapQuestCatalogItem)
        }
    }
    
    private func handleLeapQuestFactSelection(_ leapQuestItem: LeapQuestCatalogItemModel) {
        showLeapQuestFactDetails(leapQuestItem)
    }
    
    private func showLeapQuestFactDetails(_ leapQuestItem: LeapQuestCatalogItemModel) {
        if let fact = LeapQuestFactData.leapQuestFacts.first(where: { $0.id.uuidString == leapQuestItem.leapQuestCatalogItemId }) {
            let factsVC = LeapQuestFactsViewController()
            let factDetailVC = LeapQuestFactDetailViewController(fact: fact)
            factsVC.navigationController?.pushViewController(factDetailVC, animated: true)
        }
    }
    
    func leapQuestCatalogRefreshItems() {
        loadLeapQuestCatalogItems()
        leapQuestCatalogDelegate?.leapQuestCatalogViewModelDidUpdate()
    }
}
