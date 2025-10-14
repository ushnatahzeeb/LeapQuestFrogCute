import Foundation
import Combine

// MARK: - Achievement Manager Protocol
protocol LeapQuestAchievementManagerDelegate: AnyObject {
    func leapQuestAchievementManagerDidUpdateAchievements()
    func leapQuestAchievementManagerDidUnlockAchievement(_ achievement: LeapQuestAchievement)
}

class LeapQuestAchievementManager {
    
    static let shared = LeapQuestAchievementManager()
    
    weak var leapQuestDelegate: LeapQuestAchievementManagerDelegate?
    
    private var leapQuestAchievementData: LeapQuestAchievementData
    private let leapQuestStorageManager = LeapQuestStorageManager.shared
    private let leapQuestQueue = DispatchQueue(label: "com.leapquest.achievements", qos: .userInitiated)
    
    private init() {
        leapQuestAchievementData = leapQuestStorageManager.leapQuestLoadAchievementData()
    }
    
    // MARK: - Public Accessors
    func leapQuestGetAllAchievements() -> [LeapQuestAchievement] {
        return leapQuestAchievementData.leapQuestAchievements
    }
    
    func leapQuestGetAchievement(_ type: LeapQuestAchievementType) -> LeapQuestAchievement? {
        return leapQuestAchievementData.leapQuestGetAchievement(type)
    }
    
    func leapQuestGetCompletedAchievements() -> [LeapQuestAchievement] {
        return leapQuestAchievementData.leapQuestAchievements.filter { $0.leapQuestIsCompleted }
    }
    
    func leapQuestGetTotalCompleted() -> Int {
        return leapQuestAchievementData.leapQuestTotalCompleted
    }
    
    // MARK: - Achievement Updates
    func leapQuestUpdateAchievement(_ type: LeapQuestAchievementType, progress: Int) {
        leapQuestQueue.async {
            let wasCompleted = self.leapQuestAchievementData.leapQuestGetAchievement(type)?.leapQuestIsCompleted ?? false
            
            self.leapQuestAchievementData.leapQuestUpdateAchievement(type, progress: progress)
            self.leapQuestStorageManager.leapQuestSaveAchievementData(self.leapQuestAchievementData)
            
            DispatchQueue.main.async {
                self.leapQuestDelegate?.leapQuestAchievementManagerDidUpdateAchievements()
                
                if let achievement = self.leapQuestGetAchievement(type), achievement.leapQuestIsCompleted && !wasCompleted {
                    self.leapQuestDelegate?.leapQuestAchievementManagerDidUnlockAchievement(achievement)
                }
            }
        }
    }
    
    func leapQuestIncrementAchievement(_ type: LeapQuestAchievementType, by amount: Int = 1) {
        leapQuestUpdateAchievement(type, progress: (leapQuestGetAchievement(type)?.leapQuestCurrentProgress ?? 0) + amount)
    }
    
    // MARK: - Game Event Handlers
    func leapQuestHandleFirstJump() {
        leapQuestIncrementAchievement(.firstJump)
    }
    
    func leapQuestHandleJump() {
        leapQuestIncrementAchievement(.jumpMaster)
    }
    
    func leapQuestHandleLevelCompletion(_ level: Int) {
        leapQuestUpdateAchievement(.levelCompleter, progress: level)
        if level >= 20 { // Assuming 20 levels total
            leapQuestUpdateAchievement(.frogMaster, progress: 1)
        }
    }
    
    func leapQuestHandlePuzzleSolved() {
        let currentProgress = leapQuestGetAchievement(.puzzleSolver)?.leapQuestCurrentProgress ?? 0
        leapQuestUpdateAchievement(.puzzleSolver, progress: currentProgress + 1)
    }
    
    func leapQuestHandleCoinCollected(_ amount: Int) {
        let currentProgress = leapQuestGetAchievement(.coinCollector)?.leapQuestCurrentProgress ?? 0
        leapQuestUpdateAchievement(.coinCollector, progress: currentProgress + amount)
    }
    
    func leapQuestHandleScoreUpdate(_ score: Int) {
        leapQuestUpdateAchievement(.scoreHunter, progress: score)
    }
    
    func leapQuestHandlePlatformTypeJumped(_ platformType: String) {
        // This would need to be implemented based on your platform types
        let currentProgress = leapQuestGetAchievement(.platformExplorer)?.leapQuestCurrentProgress ?? 0
        leapQuestUpdateAchievement(.platformExplorer, progress: currentProgress + 1)
    }
    
    // MARK: - Data Persistence
    private func saveLeapQuestAchievementData() {
        leapQuestStorageManager.leapQuestSaveAchievementData(leapQuestAchievementData)
    }
}
