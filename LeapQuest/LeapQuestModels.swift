import Foundation

enum LeapQuestPlatformType: String, CaseIterable {
    case stable = "Stable"
    case swinging = "Swinging"
    case falling = "Falling"
    case moving = "Moving"
    
    var leapQuestPlatformEmoji: String {
        switch self {
        case .stable: return "🪨"
        case .swinging: return "🌿"
        case .falling: return "🍃"
        case .moving: return "🌊"
        }
    }
}

enum LeapQuestPuzzleDifficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case expert = "Expert"
}

enum LeapQuestLeapBotMode: String, CaseIterable, Codable {
    case support = "Support"
    case neutral = "Neutral"
    case silent = "Silent"
}

enum LeapQuestSettingsItemType {
    case action
    case `switch`
    case info
}

enum LeapQuestSettingsAction {
    case resetData
    case privacyPolicy
    case termsOfUse
}

enum LeapQuestCatalogCategory: Int, CaseIterable {
    case platforms = 0
    case puzzles = 1
    case achievements = 2
    case facts = 3
}

struct LeapQuestPlatformModel {
    let leapQuestPlatformId: String
    let leapQuestPlatformType: LeapQuestPlatformType
    let leapQuestPlatformEmoji: String
    let leapQuestPlatformTitle: String
    let leapQuestPlatformDescription: String
    let leapQuestPlatformIsUnlocked: Bool
    let leapQuestPlatformMovementSpeed: Double
    let leapQuestPlatformStability: Double
}

struct LeapQuestPuzzleModel {
    let leapQuestPuzzleId: String
    let leapQuestPuzzleEmoji: String
    let leapQuestPuzzleTitle: String
    let leapQuestPuzzleDescription: String
    let leapQuestPuzzleDifficulty: LeapQuestPuzzleDifficulty
    let leapQuestPuzzleIsSolved: Bool
    let leapQuestPuzzleIsAvailable: Bool
    let leapQuestPuzzleRewardCoins: Int
}

struct LeapQuestAchievementModel {
    let leapQuestAchievementId: String
    let leapQuestAchievementEmoji: String
    let leapQuestAchievementTitle: String
    let leapQuestAchievementDescription: String
    let leapQuestAchievementIsUnlocked: Bool
    let leapQuestAchievementRewardCoins: Int
    let leapQuestAchievementProgress: Int
    let leapQuestAchievementMaxProgress: Int
}

struct LeapQuestCatalogItemModel {
    let leapQuestCatalogItemId: String
    let leapQuestCatalogItemEmoji: String
    let leapQuestCatalogItemTitle: String
    let leapQuestCatalogItemDescription: String
    let leapQuestCatalogItemIsUnlocked: Bool
    let leapQuestCatalogItemCategory: LeapQuestCatalogCategory
}

struct LeapQuestSettingsItemModel {
    let leapQuestSettingsItemId: String
    let leapQuestSettingsItemEmoji: String
    let leapQuestSettingsItemTitle: String
    let leapQuestSettingsItemType: LeapQuestSettingsItemType
    let leapQuestSettingsItemAction: LeapQuestSettingsAction?
    let leapQuestSettingsItemBoolValue: Bool
}

struct LeapQuestSettingsSectionModel {
    let leapQuestSettingsSectionTitle: String
    let leapQuestSettingsSectionItems: [LeapQuestSettingsItemModel]
}

struct LeapQuestGameProgressModel: Codable {
    let leapQuestCurrentLevel: Int
    let leapQuestLeapCoins: Int
    let leapQuestSolvedPuzzles: Int
    let leapQuestUnlockedAchievements: Int
    let leapQuestLeapBotMode: LeapQuestLeapBotMode
    let leapQuestSoundEnabled: Bool
    let leapQuestNotificationsEnabled: Bool
}

struct LeapQuestLevelModel {
    let leapQuestLevelId: String
    let leapQuestLevelNumber: Int
    let leapQuestLevelTitle: String
    let leapQuestLevelDescription: String
    let leapQuestLevelPlatforms: [LeapQuestPlatformModel]
    let leapQuestLevelPuzzles: [LeapQuestPuzzleModel]
    let leapQuestLevelIsCompleted: Bool
    let leapQuestLevelIsAvailable: Bool
    let leapQuestLevelRewardCoins: Int
}
