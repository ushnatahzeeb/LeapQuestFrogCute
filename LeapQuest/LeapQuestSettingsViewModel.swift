import Foundation

class LeapQuestSettingsViewModel {
    
    weak var leapQuestSettingsDelegate: LeapQuestSettingsViewModelDelegate?
    
    private let leapQuestStorageManager: LeapQuestStorageManager
    private var leapQuestSettingsSectionsList: [LeapQuestSettingsSectionModel] = []
    
    var leapQuestSettingsSections: [LeapQuestSettingsSectionModel] {
        return leapQuestSettingsSectionsList
    }
    
    init() {
        leapQuestStorageManager = LeapQuestStorageManager.shared
        loadLeapQuestSettingsSections()
    }
    
    private func loadLeapQuestSettingsSections() {
        let leapQuestGameProgress = leapQuestStorageManager.leapQuestLoadGameProgress()
        
        leapQuestSettingsSectionsList = [
            LeapQuestSettingsSectionModel(
                leapQuestSettingsSectionTitle: "LeapBot Mode",
                leapQuestSettingsSectionItems: [
                    LeapQuestSettingsItemModel(
                        leapQuestSettingsItemId: "leapbot_mode",
                        leapQuestSettingsItemEmoji: "🤖",
                        leapQuestSettingsItemTitle: "LeapBot Assistant",
                        leapQuestSettingsItemType: .switch,
                        leapQuestSettingsItemAction: nil,
                        leapQuestSettingsItemBoolValue: leapQuestGameProgress.leapQuestLeapBotMode == .support
                    )
                ]
            ),
            LeapQuestSettingsSectionModel(
                leapQuestSettingsSectionTitle: "Audio & Notifications",
                leapQuestSettingsSectionItems: [
                    LeapQuestSettingsItemModel(
                        leapQuestSettingsItemId: "sound_enabled",
                        leapQuestSettingsItemEmoji: "🔊",
                        leapQuestSettingsItemTitle: "Sound Effects",
                        leapQuestSettingsItemType: .switch,
                        leapQuestSettingsItemAction: nil,
                        leapQuestSettingsItemBoolValue: leapQuestGameProgress.leapQuestSoundEnabled
                    ),
                    LeapQuestSettingsItemModel(
                        leapQuestSettingsItemId: "notifications_enabled",
                        leapQuestSettingsItemEmoji: "🔔",
                        leapQuestSettingsItemTitle: "Notifications",
                        leapQuestSettingsItemType: .switch,
                        leapQuestSettingsItemAction: nil,
                        leapQuestSettingsItemBoolValue: leapQuestGameProgress.leapQuestNotificationsEnabled
                    )
                ]
            ),
            LeapQuestSettingsSectionModel(
                leapQuestSettingsSectionTitle: "Game Data",
                leapQuestSettingsSectionItems: [
                    LeapQuestSettingsItemModel(
                        leapQuestSettingsItemId: "reset_data",
                        leapQuestSettingsItemEmoji: "🗑️",
                        leapQuestSettingsItemTitle: "Reset Game Data",
                        leapQuestSettingsItemType: .action,
                        leapQuestSettingsItemAction: .resetData,
                        leapQuestSettingsItemBoolValue: false
                    )
                ]
            ),
            LeapQuestSettingsSectionModel(
                leapQuestSettingsSectionTitle: "Legal",
                leapQuestSettingsSectionItems: [
                    LeapQuestSettingsItemModel(
                        leapQuestSettingsItemId: "privacy_policy",
                        leapQuestSettingsItemEmoji: "🔒",
                        leapQuestSettingsItemTitle: "Privacy Policy",
                        leapQuestSettingsItemType: .action,
                        leapQuestSettingsItemAction: .privacyPolicy,
                        leapQuestSettingsItemBoolValue: false
                    ),
                    LeapQuestSettingsItemModel(
                        leapQuestSettingsItemId: "terms_of_use",
                        leapQuestSettingsItemEmoji: "📋",
                        leapQuestSettingsItemTitle: "Terms of Use",
                        leapQuestSettingsItemType: .action,
                        leapQuestSettingsItemAction: .termsOfUse,
                        leapQuestSettingsItemBoolValue: false
                    )
                ]
            ),
            LeapQuestSettingsSectionModel(
                leapQuestSettingsSectionTitle: "Statistics",
                leapQuestSettingsSectionItems: [
                    LeapQuestSettingsItemModel(
                        leapQuestSettingsItemId: "solved_puzzles",
                        leapQuestSettingsItemEmoji: "🧩",
                        leapQuestSettingsItemTitle: "Solved Puzzles: \(leapQuestGameProgress.leapQuestSolvedPuzzles)",
                        leapQuestSettingsItemType: .info,
                        leapQuestSettingsItemAction: nil,
                        leapQuestSettingsItemBoolValue: false
                    ),
                    LeapQuestSettingsItemModel(
                        leapQuestSettingsItemId: "completed_levels",
                        leapQuestSettingsItemEmoji: "🏆",
                        leapQuestSettingsItemTitle: "Completed Levels: \(leapQuestGameProgress.leapQuestCurrentLevel - 1)",
                        leapQuestSettingsItemType: .info,
                        leapQuestSettingsItemAction: nil,
                        leapQuestSettingsItemBoolValue: false
                    ),
                    LeapQuestSettingsItemModel(
                        leapQuestSettingsItemId: "leap_coins",
                        leapQuestSettingsItemEmoji: "💰",
                        leapQuestSettingsItemTitle: "LeapCoins: \(leapQuestGameProgress.leapQuestLeapCoins)",
                        leapQuestSettingsItemType: .info,
                        leapQuestSettingsItemAction: nil,
                        leapQuestSettingsItemBoolValue: false
                    ),
                    LeapQuestSettingsItemModel(
                        leapQuestSettingsItemId: "unlocked_achievements",
                        leapQuestSettingsItemEmoji: "🎖️",
                        leapQuestSettingsItemTitle: "Unlocked Achievements: \(leapQuestGameProgress.leapQuestUnlockedAchievements)",
                        leapQuestSettingsItemType: .info,
                        leapQuestSettingsItemAction: nil,
                        leapQuestSettingsItemBoolValue: false
                    )
                ]
            )
        ]
    }
    
    func leapQuestSettingsSelectItem(_ leapQuestItem: LeapQuestSettingsItemModel) {
        if leapQuestItem.leapQuestSettingsItemType == .action {
            handleLeapQuestSettingsAction(leapQuestItem.leapQuestSettingsItemAction!)
        }
    }
    
    func leapQuestSettingsToggleSwitch(_ leapQuestItem: LeapQuestSettingsItemModel, isOn: Bool) {
        switch leapQuestItem.leapQuestSettingsItemId {
        case "leapbot_mode":
            toggleLeapQuestLeapBotMode(isOn)
        case "sound_enabled":
            toggleLeapQuestSoundEnabled(isOn)
        case "notifications_enabled":
            toggleLeapQuestNotificationsEnabled(isOn)
        default:
            break
        }
    }
    
    private func toggleLeapQuestLeapBotMode(_ leapQuestIsSupportMode: Bool) {
        var leapQuestGameProgress = leapQuestStorageManager.leapQuestLoadGameProgress()
        leapQuestGameProgress = LeapQuestGameProgressModel(
            leapQuestCurrentLevel: leapQuestGameProgress.leapQuestCurrentLevel,
            leapQuestLeapCoins: leapQuestGameProgress.leapQuestLeapCoins,
            leapQuestSolvedPuzzles: leapQuestGameProgress.leapQuestSolvedPuzzles,
            leapQuestUnlockedAchievements: leapQuestGameProgress.leapQuestUnlockedAchievements,
            leapQuestLeapBotMode: leapQuestIsSupportMode ? .support : .neutral,
            leapQuestSoundEnabled: leapQuestGameProgress.leapQuestSoundEnabled,
            leapQuestNotificationsEnabled: leapQuestGameProgress.leapQuestNotificationsEnabled
        )
        
        leapQuestStorageManager.leapQuestSaveGameProgress(leapQuestGameProgress)
        reloadLeapQuestSettingsSections()
    }
    
    private func toggleLeapQuestSoundEnabled(_ leapQuestIsEnabled: Bool) {
        var leapQuestGameProgress = leapQuestStorageManager.leapQuestLoadGameProgress()
        leapQuestGameProgress = LeapQuestGameProgressModel(
            leapQuestCurrentLevel: leapQuestGameProgress.leapQuestCurrentLevel,
            leapQuestLeapCoins: leapQuestGameProgress.leapQuestLeapCoins,
            leapQuestSolvedPuzzles: leapQuestGameProgress.leapQuestSolvedPuzzles,
            leapQuestUnlockedAchievements: leapQuestGameProgress.leapQuestUnlockedAchievements,
            leapQuestLeapBotMode: leapQuestGameProgress.leapQuestLeapBotMode,
            leapQuestSoundEnabled: leapQuestIsEnabled,
            leapQuestNotificationsEnabled: leapQuestGameProgress.leapQuestNotificationsEnabled
        )
        
        leapQuestStorageManager.leapQuestSaveGameProgress(leapQuestGameProgress)
        reloadLeapQuestSettingsSections()
    }
    
    private func toggleLeapQuestNotificationsEnabled(_ leapQuestIsEnabled: Bool) {
        var leapQuestGameProgress = leapQuestStorageManager.leapQuestLoadGameProgress()
        leapQuestGameProgress = LeapQuestGameProgressModel(
            leapQuestCurrentLevel: leapQuestGameProgress.leapQuestCurrentLevel,
            leapQuestLeapCoins: leapQuestGameProgress.leapQuestLeapCoins,
            leapQuestSolvedPuzzles: leapQuestGameProgress.leapQuestSolvedPuzzles,
            leapQuestUnlockedAchievements: leapQuestGameProgress.leapQuestUnlockedAchievements,
            leapQuestLeapBotMode: leapQuestGameProgress.leapQuestLeapBotMode,
            leapQuestSoundEnabled: leapQuestGameProgress.leapQuestSoundEnabled,
            leapQuestNotificationsEnabled: leapQuestIsEnabled
        )
        
        leapQuestStorageManager.leapQuestSaveGameProgress(leapQuestGameProgress)
        reloadLeapQuestSettingsSections()
    }
    
    private func handleLeapQuestSettingsAction(_ leapQuestAction: LeapQuestSettingsAction) {
        switch leapQuestAction {
        case .resetData:
            leapQuestSettingsResetData()
        case .privacyPolicy:
            print("Privacy Policy selected")
        case .termsOfUse:
            print("Terms of Use selected")
        }
    }
    
    func leapQuestSettingsResetData() {
        leapQuestStorageManager.leapQuestResetAllData()
        loadLeapQuestSettingsSections()
        leapQuestSettingsDelegate?.leapQuestSettingsViewModelDidUpdate()
    }
    
    private func reloadLeapQuestSettingsSections() {
        loadLeapQuestSettingsSections()
        leapQuestSettingsDelegate?.leapQuestSettingsViewModelDidUpdate()
    }
}
