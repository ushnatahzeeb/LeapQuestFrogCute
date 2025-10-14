import Foundation

// MARK: - Shop Upgrade Types
enum LeapQuestUpgradeType: String, CaseIterable, Codable {
    case lilyPad = "lily_pad"
    case waterLily = "water_lily"
    case lotus = "lotus"
    case goldenFrog = "golden_frog"
    case diamondFrog = "diamond_frog"
    case emeraldFrog = "emerald_frog"
    case rainbowFrog = "rainbow_frog"
    case cosmicFrog = "cosmic_frog"
    
    var leapQuestDisplayName: String {
        switch self {
        case .lilyPad: return "Lily Pad"
        case .waterLily: return "Water Lily"
        case .lotus: return "Lotus"
        case .goldenFrog: return "Golden Frog"
        case .diamondFrog: return "Diamond Frog"
        case .emeraldFrog: return "Emerald Frog"
        case .rainbowFrog: return "Rainbow Frog"
        case .cosmicFrog: return "Cosmic Frog"
        }
    }
    
    var leapQuestEmoji: String {
        switch self {
        case .lilyPad: return "🪷"
        case .waterLily: return "🌸"
        case .lotus: return "🪷"
        case .goldenFrog: return "🐸"
        case .diamondFrog: return "💎"
        case .emeraldFrog: return "💚"
        case .rainbowFrog: return "🌈"
        case .cosmicFrog: return "🌌"
        }
    }
    
    var leapQuestDescription: String {
        switch self {
        case .lilyPad: return "A peaceful lily pad that generates coins slowly"
        case .waterLily: return "A beautiful water lily with moderate income"
        case .lotus: return "An ancient lotus with good passive income"
        case .goldenFrog: return "A golden frog that brings wealth"
        case .diamondFrog: return "A precious diamond frog with high income"
        case .emeraldFrog: return "An emerald frog with great passive earnings"
        case .rainbowFrog: return "A magical rainbow frog with excellent income"
        case .cosmicFrog: return "A cosmic frog with incredible passive wealth"
        }
    }
    
    var leapQuestBaseCost: Int {
        switch self {
        case .lilyPad: return 100
        case .waterLily: return 500
        case .lotus: return 2500
        case .goldenFrog: return 10000
        case .diamondFrog: return 50000
        case .emeraldFrog: return 250000
        case .rainbowFrog: return 1000000
        case .cosmicFrog: return 5000000
        }
    }
    
    var leapQuestBaseIncome: Int {
        switch self {
        case .lilyPad: return 1
        case .waterLily: return 5
        case .lotus: return 25
        case .goldenFrog: return 100
        case .diamondFrog: return 500
        case .emeraldFrog: return 2500
        case .rainbowFrog: return 10000
        case .cosmicFrog: return 50000
        }
    }
    
    var leapQuestCostMultiplier: Double {
        switch self {
        case .lilyPad: return 1.15
        case .waterLily: return 1.18
        case .lotus: return 1.20
        case .goldenFrog: return 1.25
        case .diamondFrog: return 1.30
        case .emeraldFrog: return 1.35
        case .rainbowFrog: return 1.40
        case .cosmicFrog: return 1.50
        }
    }
}

// MARK: - Shop Upgrade Model
struct LeapQuestShopUpgrade: Codable {
    let leapQuestUpgradeType: LeapQuestUpgradeType
    var leapQuestOwned: Int
    var leapQuestLastIncomeTime: Date
    
    var leapQuestCurrentCost: Int {
        if leapQuestOwned == 0 {
            return leapQuestUpgradeType.leapQuestBaseCost
        }
        let leapQuestCostMultiplier = leapQuestUpgradeType.leapQuestCostMultiplier
        return Int(Double(leapQuestUpgradeType.leapQuestBaseCost) * pow(leapQuestCostMultiplier, Double(leapQuestOwned)))
    }
    
    var leapQuestTotalIncome: Int {
        return leapQuestOwned * leapQuestUpgradeType.leapQuestBaseIncome
    }
    
    var leapQuestIncomePerMinute: Int {
        return leapQuestOwned * leapQuestUpgradeType.leapQuestBaseIncome * 60
    }
    
    func leapQuestCalculateIncomeSince(_ lastTime: Date) -> Int {
        let leapQuestTimeElapsed = Date().timeIntervalSince(lastTime)
        let leapQuestMinutesElapsed = leapQuestTimeElapsed / 60.0
        return Int(Double(leapQuestTotalIncome) * leapQuestMinutesElapsed)
    }
}

// MARK: - Shop Data Model
struct LeapQuestShopData: Codable {
    var leapQuestUpgrades: [LeapQuestUpgradeType: LeapQuestShopUpgrade]
    var leapQuestLastSaveTime: Date
    var leapQuestTotalPassiveIncome: Int
    
    init() {
        self.leapQuestUpgrades = [:]
        self.leapQuestLastSaveTime = Date()
        self.leapQuestTotalPassiveIncome = 0
        
        for upgradeType in LeapQuestUpgradeType.allCases {
            leapQuestUpgrades[upgradeType] = LeapQuestShopUpgrade(
                leapQuestUpgradeType: upgradeType,
                leapQuestOwned: 0,
                leapQuestLastIncomeTime: Date()
            )
        }
    }
    
    mutating func leapQuestUpdatePassiveIncome() {
        var leapQuestTotalIncome = 0
        let leapQuestCurrentTime = Date()
        
        for (upgradeType, upgrade) in leapQuestUpgrades {
            if upgrade.leapQuestOwned > 0 {
                let leapQuestIncome = upgrade.leapQuestCalculateIncomeSince(upgrade.leapQuestLastIncomeTime)
                leapQuestTotalIncome += leapQuestIncome
                
                var leapQuestUpdatedUpgrade = upgrade
                leapQuestUpdatedUpgrade.leapQuestLastIncomeTime = leapQuestCurrentTime
                leapQuestUpgrades[upgradeType] = leapQuestUpdatedUpgrade
            }
        }
        
        leapQuestTotalPassiveIncome += leapQuestTotalIncome
        leapQuestLastSaveTime = leapQuestCurrentTime
    }
    
    func leapQuestGetTotalIncomePerMinute() -> Int {
        return leapQuestUpgrades.values.reduce(0) { $0 + $1.leapQuestIncomePerMinute }
    }
    
    func leapQuestGetTotalIncomePerHour() -> Int {
        return leapQuestGetTotalIncomePerMinute() * 60
    }
}

// MARK: - Shop Purchase Result
struct LeapQuestPurchaseResult {
    let leapQuestSuccess: Bool
    let leapQuestMessage: String
    let leapQuestNewCost: Int?
    let leapQuestNewIncome: Int?
}

