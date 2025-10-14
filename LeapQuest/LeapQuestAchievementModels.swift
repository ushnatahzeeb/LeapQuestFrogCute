import Foundation

// MARK: - Achievement Type
enum LeapQuestAchievementType: String, Codable, CaseIterable {
    case firstJump = "First Jump"
    case frogMaster = "Frog Master"
    case puzzleSolver = "Puzzle Solver"
    case coinCollector = "Coin Collector"
    case platformExplorer = "Platform Explorer"
    case jumpMaster = "Jump Master"
    case scoreHunter = "Score Hunter"
    case levelCompleter = "Level Completer"
    
    var leapQuestEmoji: String {
        switch self {
        case .firstJump: return "🦘"
        case .frogMaster: return "👑"
        case .puzzleSolver: return "🧩"
        case .coinCollector: return "💰"
        case .platformExplorer: return "🌿"
        case .jumpMaster: return "🚀"
        case .scoreHunter: return "🎯"
        case .levelCompleter: return "⭐"
        }
    }
    
    var leapQuestDescription: String {
        switch self {
        case .firstJump: return "Make your first jump on a platform"
        case .frogMaster: return "Complete all levels"
        case .puzzleSolver: return "Solve 50 puzzles"
        case .coinCollector: return "Collect 1000 LeapCoins"
        case .platformExplorer: return "Jump on all platform types"
        case .jumpMaster: return "Make 100 successful jumps"
        case .scoreHunter: return "Reach a total score of 10000"
        case .levelCompleter: return "Complete 10 levels"
        }
    }
    
    var leapQuestTargetValue: Int {
        switch self {
        case .firstJump: return 1
        case .frogMaster: return 20 // Assuming 20 levels total
        case .puzzleSolver: return 50
        case .coinCollector: return 1000
        case .platformExplorer: return 5 // 5 different platform types
        case .jumpMaster: return 100
        case .scoreHunter: return 10000
        case .levelCompleter: return 10
        }
    }
    
    var leapQuestCategory: LeapQuestAchievementCategory {
        switch self {
        case .firstJump, .jumpMaster: return .jumping
        case .frogMaster, .levelCompleter: return .progress
        case .puzzleSolver: return .puzzles
        case .coinCollector, .scoreHunter: return .economy
        case .platformExplorer: return .exploration
        }
    }
}

// MARK: - Achievement Category
enum LeapQuestAchievementCategory: String, Codable, CaseIterable {
    case jumping = "Jumping"
    case progress = "Progress"
    case puzzles = "Puzzles"
    case economy = "Economy"
    case exploration = "Exploration"
    
    var leapQuestEmoji: String {
        switch self {
        case .jumping: return "🦘"
        case .progress: return "⭐"
        case .puzzles: return "🧩"
        case .economy: return "💰"
        case .exploration: return "🌿"
        }
    }
}

// MARK: - Achievement
struct LeapQuestAchievement: Codable, Identifiable {
    let id = UUID()
    let leapQuestType: LeapQuestAchievementType
    var leapQuestCurrentProgress: Int
    var leapQuestIsCompleted: Bool
    var leapQuestCompletedDate: Date?
    
    var leapQuestProgressPercentage: Float {
        return Float(leapQuestCurrentProgress) / Float(leapQuestType.leapQuestTargetValue)
    }
    
    var leapQuestRemainingProgress: Int {
        return max(0, leapQuestType.leapQuestTargetValue - leapQuestCurrentProgress)
    }
    
    mutating func leapQuestUpdateProgress(_ newProgress: Int) {
        leapQuestCurrentProgress = min(newProgress, leapQuestType.leapQuestTargetValue)
        
        if leapQuestCurrentProgress >= leapQuestType.leapQuestTargetValue && !leapQuestIsCompleted {
            leapQuestIsCompleted = true
            leapQuestCompletedDate = Date()
        }
    }
    
    mutating func leapQuestIncrementProgress(by amount: Int = 1) {
        leapQuestUpdateProgress(leapQuestCurrentProgress + amount)
    }
}

// MARK: - Achievement Data
struct LeapQuestAchievementData: Codable {
    var leapQuestAchievements: [LeapQuestAchievement]
    var leapQuestTotalCompleted: Int
    var leapQuestLastUpdated: Date
    
    init() {
        self.leapQuestAchievements = LeapQuestAchievementType.allCases.map { type in
            LeapQuestAchievement(
                leapQuestType: type,
                leapQuestCurrentProgress: 0,
                leapQuestIsCompleted: false,
                leapQuestCompletedDate: nil
            )
        }
        self.leapQuestTotalCompleted = 0
        self.leapQuestLastUpdated = Date()
    }
    
    mutating func leapQuestUpdateAchievement(_ type: LeapQuestAchievementType, progress: Int) {
        if let index = leapQuestAchievements.firstIndex(where: { $0.leapQuestType == type }) {
            let wasCompleted = leapQuestAchievements[index].leapQuestIsCompleted
            leapQuestAchievements[index].leapQuestUpdateProgress(progress)
            
            if leapQuestAchievements[index].leapQuestIsCompleted && !wasCompleted {
                leapQuestTotalCompleted += 1
            }
        }
        leapQuestLastUpdated = Date()
    }
    
    mutating func leapQuestIncrementAchievement(_ type: LeapQuestAchievementType, by amount: Int = 1) {
        if let index = leapQuestAchievements.firstIndex(where: { $0.leapQuestType == type }) {
            let wasCompleted = leapQuestAchievements[index].leapQuestIsCompleted
            leapQuestAchievements[index].leapQuestIncrementProgress(by: amount)
            
            if leapQuestAchievements[index].leapQuestIsCompleted && !wasCompleted {
                leapQuestTotalCompleted += 1
            }
        }
        leapQuestLastUpdated = Date()
    }
    
    func leapQuestGetAchievement(_ type: LeapQuestAchievementType) -> LeapQuestAchievement? {
        return leapQuestAchievements.first(where: { $0.leapQuestType == type })
    }
}
