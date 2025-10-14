import Foundation

class LeapQuestFrogViewModel {
    
    weak var leapQuestFrogDelegate: LeapQuestFrogViewModelDelegate?
    
    private let leapQuestStorageManager: LeapQuestStorageManager
    private var leapQuestGameProgress: LeapQuestGameProgressModel
    private var leapQuestCurrentLevelModel: LeapQuestLevelModel
    private var leapQuestCurrentPlatformsList: [LeapQuestPlatformModel] = []
    
    var leapQuestCurrentLevel: Int {
        return leapQuestGameProgress.leapQuestCurrentLevel
    }
    
    var leapQuestLeapCoins: Int {
        return leapQuestGameProgress.leapQuestLeapCoins
    }
    
    var leapQuestCurrentPlatforms: [LeapQuestPlatformModel] {
        return leapQuestCurrentPlatformsList
    }
    
    init() {
        leapQuestStorageManager = LeapQuestStorageManager.shared
        leapQuestGameProgress = leapQuestStorageManager.leapQuestLoadGameProgress()
        leapQuestCurrentLevelModel = leapQuestStorageManager.leapQuestLoadLevel(leapQuestGameProgress.leapQuestCurrentLevel)
        updateLeapQuestCurrentPlatforms()
    }
    
    func leapQuestStartLevel() {
        if leapQuestCurrentLevelModel.leapQuestLevelIsAvailable {
            generateLeapQuestRandomPlatforms()
            leapQuestFrogDelegate?.leapQuestFrogViewModelDidUpdate()
        }
    }
    
    func leapQuestCompleteLevel() {
        let leapQuestRewardCoins = leapQuestCurrentLevelModel.leapQuestLevelRewardCoins
        let leapQuestNewCoins = leapQuestGameProgress.leapQuestLeapCoins + leapQuestRewardCoins
        let leapQuestNewLevel = leapQuestGameProgress.leapQuestCurrentLevel + 1
        
        leapQuestGameProgress = LeapQuestGameProgressModel(
            leapQuestCurrentLevel: leapQuestNewLevel,
            leapQuestLeapCoins: leapQuestNewCoins,
            leapQuestSolvedPuzzles: leapQuestGameProgress.leapQuestSolvedPuzzles,
            leapQuestUnlockedAchievements: leapQuestGameProgress.leapQuestUnlockedAchievements,
            leapQuestLeapBotMode: leapQuestGameProgress.leapQuestLeapBotMode,
            leapQuestSoundEnabled: leapQuestGameProgress.leapQuestSoundEnabled,
            leapQuestNotificationsEnabled: leapQuestGameProgress.leapQuestNotificationsEnabled
        )
        
        leapQuestStorageManager.leapQuestSaveGameProgress(leapQuestGameProgress)
        
        leapQuestCurrentLevelModel = leapQuestStorageManager.leapQuestLoadLevel(leapQuestNewLevel)
        updateLeapQuestCurrentPlatforms()
        leapQuestFrogDelegate?.leapQuestFrogViewModelDidUpdate()
    }
    
    func leapQuestEarnLeapCoins(_ leapQuestAmount: Int) {
        let leapQuestNewCoins = leapQuestGameProgress.leapQuestLeapCoins + leapQuestAmount
        leapQuestGameProgress = LeapQuestGameProgressModel(
            leapQuestCurrentLevel: leapQuestGameProgress.leapQuestCurrentLevel,
            leapQuestLeapCoins: leapQuestNewCoins,
            leapQuestSolvedPuzzles: leapQuestGameProgress.leapQuestSolvedPuzzles,
            leapQuestUnlockedAchievements: leapQuestGameProgress.leapQuestUnlockedAchievements,
            leapQuestLeapBotMode: leapQuestGameProgress.leapQuestLeapBotMode,
            leapQuestSoundEnabled: leapQuestGameProgress.leapQuestSoundEnabled,
            leapQuestNotificationsEnabled: leapQuestGameProgress.leapQuestNotificationsEnabled
        )
        
        leapQuestStorageManager.leapQuestSaveGameProgress(leapQuestGameProgress)
        leapQuestFrogDelegate?.leapQuestFrogViewModelDidUpdate()
    }
    
    private func updateLeapQuestCurrentPlatforms() {
        leapQuestCurrentPlatformsList = leapQuestCurrentLevelModel.leapQuestLevelPlatforms.filter { $0.leapQuestPlatformIsUnlocked }
    }
    
    private func generateLeapQuestRandomPlatforms() {
        let leapQuestAvailablePlatformTypes = LeapQuestPlatformType.allCases
        leapQuestCurrentPlatformsList.removeAll()
        
        for i in 0..<5 {
            let leapQuestRandomType = leapQuestAvailablePlatformTypes.randomElement() ?? .stable
            let leapQuestPlatform = LeapQuestPlatformModel(
                leapQuestPlatformId: "platform_\(i)",
                leapQuestPlatformType: leapQuestRandomType,
                leapQuestPlatformEmoji: leapQuestRandomType.leapQuestPlatformEmoji,
                leapQuestPlatformTitle: "\(leapQuestRandomType.rawValue) Platform",
                leapQuestPlatformDescription: "A \(leapQuestRandomType.rawValue.lowercased()) platform for jumping",
                leapQuestPlatformIsUnlocked: true,
                leapQuestPlatformMovementSpeed: Double.random(in: 0.5...2.0),
                leapQuestPlatformStability: Double.random(in: 0.3...1.0)
            )
            leapQuestCurrentPlatformsList.append(leapQuestPlatform)
        }
    }
}
