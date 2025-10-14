import Foundation

class LeapQuestStorageManager {
    
    static let shared = LeapQuestStorageManager()
    
    private init() {}
    
    private let leapQuestUserDefaults = UserDefaults.standard
    
    private enum LeapQuestStorageKeys {
        static let leapQuestGameProgress = "LeapQuestGameProgress"
        static let leapQuestShopData = "LeapQuestShopData"
        static let leapQuestAchievementData = "LeapQuestAchievementData"
        static let leapQuestPuzzlesData = "LeapQuestPuzzlesData"
        static let leapQuestPuzzlesSolved = "LeapQuestPuzzlesSolved"
        static let leapQuestAchievementsUnlocked = "LeapQuestAchievementsUnlocked"
        static let leapQuestAchievementProgress = "LeapQuestAchievementProgress"
        static let leapQuestPlatformTypesUnlocked = "LeapQuestPlatformTypesUnlocked"
        static let leapQuestPuzzleTypesUnlocked = "LeapQuestPuzzleTypesUnlocked"
        static let leapQuestReadFacts = "LeapQuestReadFacts"
        static let leapQuestHasLaunchedBefore = "LeapQuestHasLaunchedBefore"
    }
    
    func leapQuestSaveGameProgress(_ leapQuestGameProgress: LeapQuestGameProgressModel) {
        let leapQuestEncodedData = try? JSONEncoder().encode(leapQuestGameProgress)
        leapQuestUserDefaults.set(leapQuestEncodedData, forKey: LeapQuestStorageKeys.leapQuestGameProgress)
    }
    
    func leapQuestLoadGameProgress() -> LeapQuestGameProgressModel {
        if let leapQuestData = leapQuestUserDefaults.data(forKey: LeapQuestStorageKeys.leapQuestGameProgress),
           let leapQuestGameProgress = try? JSONDecoder().decode(LeapQuestGameProgressModel.self, from: leapQuestData) {
            return leapQuestGameProgress
        }
        
        return LeapQuestGameProgressModel(
            leapQuestCurrentLevel: 1,
            leapQuestLeapCoins: 0,
            leapQuestSolvedPuzzles: 0,
            leapQuestUnlockedAchievements: 0,
            leapQuestLeapBotMode: .neutral,
            leapQuestSoundEnabled: true,
            leapQuestNotificationsEnabled: true
        )
    }
    
    func leapQuestSavePuzzleSolved(_ leapQuestPuzzleId: String) {
        var leapQuestSolvedPuzzles = leapQuestUserDefaults.stringArray(forKey: LeapQuestStorageKeys.leapQuestPuzzlesSolved) ?? []
        if !leapQuestSolvedPuzzles.contains(leapQuestPuzzleId) {
            leapQuestSolvedPuzzles.append(leapQuestPuzzleId)
            leapQuestUserDefaults.set(leapQuestSolvedPuzzles, forKey: LeapQuestStorageKeys.leapQuestPuzzlesSolved)
            
            let leapQuestGameProgress = leapQuestLoadGameProgress()
            let leapQuestNewGameProgress = LeapQuestGameProgressModel(
                leapQuestCurrentLevel: leapQuestGameProgress.leapQuestCurrentLevel,
                leapQuestLeapCoins: leapQuestGameProgress.leapQuestLeapCoins,
                leapQuestSolvedPuzzles: leapQuestSolvedPuzzles.count,
                leapQuestUnlockedAchievements: leapQuestGameProgress.leapQuestUnlockedAchievements,
                leapQuestLeapBotMode: leapQuestGameProgress.leapQuestLeapBotMode,
                leapQuestSoundEnabled: leapQuestGameProgress.leapQuestSoundEnabled,
                leapQuestNotificationsEnabled: leapQuestGameProgress.leapQuestNotificationsEnabled
            )
            leapQuestSaveGameProgress(leapQuestNewGameProgress)
        }
    }
    
    func leapQuestIsPuzzleSolved(_ leapQuestPuzzleId: String) -> Bool {
        let leapQuestSolvedPuzzles = leapQuestUserDefaults.stringArray(forKey: LeapQuestStorageKeys.leapQuestPuzzlesSolved) ?? []
        return leapQuestSolvedPuzzles.contains(leapQuestPuzzleId)
    }
    
    func leapQuestUnlockAchievement(_ leapQuestAchievementId: String) {
        var leapQuestUnlockedAchievements = leapQuestUserDefaults.stringArray(forKey: LeapQuestStorageKeys.leapQuestAchievementsUnlocked) ?? []
        if !leapQuestUnlockedAchievements.contains(leapQuestAchievementId) {
            leapQuestUnlockedAchievements.append(leapQuestAchievementId)
            leapQuestUserDefaults.set(leapQuestUnlockedAchievements, forKey: LeapQuestStorageKeys.leapQuestAchievementsUnlocked)
            
            let leapQuestGameProgress = leapQuestLoadGameProgress()
            let leapQuestNewGameProgress = LeapQuestGameProgressModel(
                leapQuestCurrentLevel: leapQuestGameProgress.leapQuestCurrentLevel,
                leapQuestLeapCoins: leapQuestGameProgress.leapQuestLeapCoins,
                leapQuestSolvedPuzzles: leapQuestGameProgress.leapQuestSolvedPuzzles,
                leapQuestUnlockedAchievements: leapQuestUnlockedAchievements.count,
                leapQuestLeapBotMode: leapQuestGameProgress.leapQuestLeapBotMode,
                leapQuestSoundEnabled: leapQuestGameProgress.leapQuestSoundEnabled,
                leapQuestNotificationsEnabled: leapQuestGameProgress.leapQuestNotificationsEnabled
            )
            leapQuestSaveGameProgress(leapQuestNewGameProgress)
        }
    }
    
    func leapQuestIsAchievementUnlocked(_ leapQuestAchievementId: String) -> Bool {
        let leapQuestUnlockedAchievements = leapQuestUserDefaults.stringArray(forKey: LeapQuestStorageKeys.leapQuestAchievementsUnlocked) ?? []
        return leapQuestUnlockedAchievements.contains(leapQuestAchievementId)
    }
    
    func leapQuestSaveAchievementProgress(_ leapQuestAchievementId: String, progress: Int) {
        var leapQuestAchievementProgress = leapQuestUserDefaults.dictionary(forKey: LeapQuestStorageKeys.leapQuestAchievementProgress) as? [String: Int] ?? [:]
        leapQuestAchievementProgress[leapQuestAchievementId] = progress
        leapQuestUserDefaults.set(leapQuestAchievementProgress, forKey: LeapQuestStorageKeys.leapQuestAchievementProgress)
    }
    
    func leapQuestGetAchievementProgress(_ leapQuestAchievementId: String) -> Int {
        let leapQuestAchievementProgress = leapQuestUserDefaults.dictionary(forKey: LeapQuestStorageKeys.leapQuestAchievementProgress) as? [String: Int] ?? [:]
        return leapQuestAchievementProgress[leapQuestAchievementId] ?? 0
    }
    
    func leapQuestUnlockPlatformType(_ leapQuestPlatformType: String) {
        var leapQuestUnlockedPlatformTypes = leapQuestUserDefaults.stringArray(forKey: LeapQuestStorageKeys.leapQuestPlatformTypesUnlocked) ?? []
        if !leapQuestUnlockedPlatformTypes.contains(leapQuestPlatformType) {
            leapQuestUnlockedPlatformTypes.append(leapQuestPlatformType)
            leapQuestUserDefaults.set(leapQuestUnlockedPlatformTypes, forKey: LeapQuestStorageKeys.leapQuestPlatformTypesUnlocked)
        }
    }
    
    func leapQuestIsPlatformTypeUnlocked(_ leapQuestPlatformType: String) -> Bool {
        let leapQuestUnlockedPlatformTypes = leapQuestUserDefaults.stringArray(forKey: LeapQuestStorageKeys.leapQuestPlatformTypesUnlocked) ?? []
        return leapQuestUnlockedPlatformTypes.contains(leapQuestPlatformType) || leapQuestPlatformType == "Stable"
    }
    
    func leapQuestUnlockPuzzleType(_ leapQuestPuzzleType: String) {
        var leapQuestUnlockedPuzzleTypes = leapQuestUserDefaults.stringArray(forKey: LeapQuestStorageKeys.leapQuestPuzzleTypesUnlocked) ?? []
        if !leapQuestUnlockedPuzzleTypes.contains(leapQuestPuzzleType) {
            leapQuestUnlockedPuzzleTypes.append(leapQuestPuzzleType)
            leapQuestUserDefaults.set(leapQuestUnlockedPuzzleTypes, forKey: LeapQuestStorageKeys.leapQuestPuzzleTypesUnlocked)
        }
    }
    
    func leapQuestIsPuzzleTypeUnlocked(_ leapQuestPuzzleType: String) -> Bool {
        let leapQuestUnlockedPuzzleTypes = leapQuestUserDefaults.stringArray(forKey: LeapQuestStorageKeys.leapQuestPuzzleTypesUnlocked) ?? []
        return leapQuestUnlockedPuzzleTypes.contains(leapQuestPuzzleType) || leapQuestPuzzleType == "mirror" || leapQuestPuzzleType == "block"
    }
    
    func leapQuestLoadLevel(_ leapQuestLevelNumber: Int) -> LeapQuestLevelModel {
        let leapQuestAvailablePlatforms = generateLeapQuestLevelPlatforms(leapQuestLevelNumber)
        let leapQuestAvailablePuzzles = generateLeapQuestLevelPuzzles(leapQuestLevelNumber)
        
        return LeapQuestLevelModel(
            leapQuestLevelId: "level_\(leapQuestLevelNumber)",
            leapQuestLevelNumber: leapQuestLevelNumber,
            leapQuestLevelTitle: "Level \(leapQuestLevelNumber)",
            leapQuestLevelDescription: "Navigate through the river using platforms and solve puzzles",
            leapQuestLevelPlatforms: leapQuestAvailablePlatforms,
            leapQuestLevelPuzzles: leapQuestAvailablePuzzles,
            leapQuestLevelIsCompleted: leapQuestLevelNumber < leapQuestLoadGameProgress().leapQuestCurrentLevel,
            leapQuestLevelIsAvailable: leapQuestLevelNumber <= leapQuestLoadGameProgress().leapQuestCurrentLevel,
            leapQuestLevelRewardCoins: leapQuestLevelNumber * 10
        )
    }
    
    private func generateLeapQuestLevelPlatforms(_ leapQuestLevelNumber: Int) -> [LeapQuestPlatformModel] {
        var leapQuestPlatforms: [LeapQuestPlatformModel] = []
        let leapQuestAvailableTypes = LeapQuestPlatformType.allCases
        
        for i in 0..<5 {
            let leapQuestPlatformType = leapQuestAvailableTypes[i % leapQuestAvailableTypes.count]
            let leapQuestIsUnlocked = leapQuestLevelNumber <= leapQuestLoadGameProgress().leapQuestCurrentLevel
            
            let leapQuestPlatform = LeapQuestPlatformModel(
                leapQuestPlatformId: "level_\(leapQuestLevelNumber)_platform_\(i)",
                leapQuestPlatformType: leapQuestPlatformType,
                leapQuestPlatformEmoji: leapQuestPlatformType.leapQuestPlatformEmoji,
                leapQuestPlatformTitle: "\(leapQuestPlatformType.rawValue) Platform",
                leapQuestPlatformDescription: "A \(leapQuestPlatformType.rawValue.lowercased()) platform",
                leapQuestPlatformIsUnlocked: leapQuestIsUnlocked,
                leapQuestPlatformMovementSpeed: Double.random(in: 0.5...2.0),
                leapQuestPlatformStability: Double.random(in: 0.3...1.0)
            )
            leapQuestPlatforms.append(leapQuestPlatform)
        }
        
        return leapQuestPlatforms
    }
    
    private func generateLeapQuestLevelPuzzles(_ leapQuestLevelNumber: Int) -> [LeapQuestPuzzleModel] {
        var leapQuestPuzzles: [LeapQuestPuzzleModel] = []
        let leapQuestPuzzleTypes = ["mirror", "block", "switch", "combination", "sequence", "logic", "master"]
        
        for i in 0..<3 {
            let leapQuestPuzzleType = leapQuestPuzzleTypes[i % leapQuestPuzzleTypes.count]
            let leapQuestPuzzleId = "level_\(leapQuestLevelNumber)_\(leapQuestPuzzleType)_\(i)"
            
            let leapQuestPuzzle = LeapQuestPuzzleModel(
                leapQuestPuzzleId: leapQuestPuzzleId,
                leapQuestPuzzleEmoji: "🧩",
                leapQuestPuzzleTitle: "\(leapQuestPuzzleType.capitalized) Puzzle",
                leapQuestPuzzleDescription: "Solve this \(leapQuestPuzzleType) puzzle to progress",
                leapQuestPuzzleDifficulty: .easy,
                leapQuestPuzzleIsSolved: leapQuestIsPuzzleSolved(leapQuestPuzzleId),
                leapQuestPuzzleIsAvailable: true,
                leapQuestPuzzleRewardCoins: 20
            )
            leapQuestPuzzles.append(leapQuestPuzzle)
        }
        
        return leapQuestPuzzles
    }
    
    func leapQuestResetAllData() {
        leapQuestUserDefaults.removeObject(forKey: LeapQuestStorageKeys.leapQuestGameProgress)
        leapQuestUserDefaults.removeObject(forKey: LeapQuestStorageKeys.leapQuestPuzzlesSolved)
        leapQuestUserDefaults.removeObject(forKey: LeapQuestStorageKeys.leapQuestAchievementsUnlocked)
        leapQuestUserDefaults.removeObject(forKey: LeapQuestStorageKeys.leapQuestAchievementProgress)
        leapQuestUserDefaults.removeObject(forKey: LeapQuestStorageKeys.leapQuestPlatformTypesUnlocked)
        leapQuestUserDefaults.removeObject(forKey: LeapQuestStorageKeys.leapQuestPuzzleTypesUnlocked)
        
        let leapQuestDefaultGameProgress = LeapQuestGameProgressModel(
            leapQuestCurrentLevel: 1,
            leapQuestLeapCoins: 0,
            leapQuestSolvedPuzzles: 0,
            leapQuestUnlockedAchievements: 0,
            leapQuestLeapBotMode: .neutral,
            leapQuestSoundEnabled: true,
            leapQuestNotificationsEnabled: true
        )
        
        leapQuestSaveGameProgress(leapQuestDefaultGameProgress)
    }
    
    // MARK: - Achievement Data
    func leapQuestSaveAchievementData(_ achievementData: LeapQuestAchievementData) {
        if let encoded = try? JSONEncoder().encode(achievementData) {
            leapQuestUserDefaults.set(encoded, forKey: LeapQuestStorageKeys.leapQuestAchievementData)
        }
    }
    
    func leapQuestLoadAchievementData() -> LeapQuestAchievementData {
        if let savedData = leapQuestUserDefaults.object(forKey: LeapQuestStorageKeys.leapQuestAchievementData) as? Data {
            if let decodedData = try? JSONDecoder().decode(LeapQuestAchievementData.self, from: savedData) {
                return decodedData
            }
        }
        return LeapQuestAchievementData()
    }
    
    // MARK: - Puzzles Data
    func leapQuestSavePuzzles(_ puzzles: [LeapQuestPuzzle]) {
        if let encoded = try? JSONEncoder().encode(puzzles) {
            leapQuestUserDefaults.set(encoded, forKey: LeapQuestStorageKeys.leapQuestPuzzlesData)
        }
    }
    
    func leapQuestLoadPuzzles() -> [LeapQuestPuzzle]? {
        if let savedData = leapQuestUserDefaults.object(forKey: LeapQuestStorageKeys.leapQuestPuzzlesData) as? Data {
            if let decodedData = try? JSONDecoder().decode([LeapQuestPuzzle].self, from: savedData) {
                return decodedData
            }
        }
        return nil
    }
    
    // MARK: - Facts Data
    func leapQuestGetReadFacts() -> [String] {
        return leapQuestUserDefaults.stringArray(forKey: LeapQuestStorageKeys.leapQuestReadFacts) ?? []
    }
    
    func leapQuestMarkFactAsRead(_ factId: String) {
        var readFacts = leapQuestGetReadFacts()
        if !readFacts.contains(factId) {
            readFacts.append(factId)
            leapQuestUserDefaults.set(readFacts, forKey: LeapQuestStorageKeys.leapQuestReadFacts)
        }
    }
    
    func leapQuestMarkFactAsUnread(_ factId: String) {
        var readFacts = leapQuestGetReadFacts()
        readFacts.removeAll { $0 == factId }
        leapQuestUserDefaults.set(readFacts, forKey: LeapQuestStorageKeys.leapQuestReadFacts)
    }
    
    func leapQuestIsFactRead(_ factId: String) -> Bool {
        return leapQuestGetReadFacts().contains(factId)
    }
    
    // MARK: - First Launch Tracking
    func leapQuestHasLaunchedBefore() -> Bool {
        return leapQuestUserDefaults.bool(forKey: LeapQuestStorageKeys.leapQuestHasLaunchedBefore)
    }
    
    func leapQuestMarkAsLaunched() {
        leapQuestUserDefaults.set(true, forKey: LeapQuestStorageKeys.leapQuestHasLaunchedBefore)
    }
    
}

