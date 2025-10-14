import Foundation

class LeapQuestAchievementsViewModel {
    
    weak var leapQuestAchievementsDelegate: LeapQuestAchievementsViewModelDelegate?
    
    private let leapQuestStorageManager: LeapQuestStorageManager
    private var leapQuestAchievementsList: [LeapQuestAchievementModel] = []
    
    var leapQuestAchievements: [LeapQuestAchievementModel] {
        return leapQuestAchievementsList
    }
    
    init() {
        leapQuestStorageManager = LeapQuestStorageManager.shared
        loadLeapQuestAchievements()
    }
    
    private func loadLeapQuestAchievements() {
        leapQuestAchievementsList = [
            LeapQuestAchievementModel(
                leapQuestAchievementId: "first_jump",
                leapQuestAchievementEmoji: "🦘",
                leapQuestAchievementTitle: "First Jump",
                leapQuestAchievementDescription: "Make your first jump on a platform",
                leapQuestAchievementIsUnlocked: leapQuestStorageManager.leapQuestIsAchievementUnlocked("first_jump"),
                leapQuestAchievementRewardCoins: 10,
                leapQuestAchievementProgress: leapQuestStorageManager.leapQuestGetAchievementProgress("first_jump"),
                leapQuestAchievementMaxProgress: 1
            ),
            LeapQuestAchievementModel(
                leapQuestAchievementId: "frog_master",
                leapQuestAchievementEmoji: "👑",
                leapQuestAchievementTitle: "Frog Master",
                leapQuestAchievementDescription: "Complete all levels",
                leapQuestAchievementIsUnlocked: leapQuestStorageManager.leapQuestIsAchievementUnlocked("frog_master"),
                leapQuestAchievementRewardCoins: 100,
                leapQuestAchievementProgress: leapQuestStorageManager.leapQuestGetAchievementProgress("frog_master"),
                leapQuestAchievementMaxProgress: 10
            ),
            LeapQuestAchievementModel(
                leapQuestAchievementId: "puzzle_solver",
                leapQuestAchievementEmoji: "🧩",
                leapQuestAchievementTitle: "Puzzle Solver",
                leapQuestAchievementDescription: "Solve 50 puzzles",
                leapQuestAchievementIsUnlocked: leapQuestStorageManager.leapQuestIsAchievementUnlocked("puzzle_solver"),
                leapQuestAchievementRewardCoins: 200,
                leapQuestAchievementProgress: leapQuestStorageManager.leapQuestGetAchievementProgress("puzzle_solver"),
                leapQuestAchievementMaxProgress: 50
            ),
            LeapQuestAchievementModel(
                leapQuestAchievementId: "coin_collector",
                leapQuestAchievementEmoji: "💰",
                leapQuestAchievementTitle: "Coin Collector",
                leapQuestAchievementDescription: "Collect 1000 LeapCoins",
                leapQuestAchievementIsUnlocked: leapQuestStorageManager.leapQuestIsAchievementUnlocked("coin_collector"),
                leapQuestAchievementRewardCoins: 50,
                leapQuestAchievementProgress: leapQuestStorageManager.leapQuestGetAchievementProgress("coin_collector"),
                leapQuestAchievementMaxProgress: 1000
            ),
            LeapQuestAchievementModel(
                leapQuestAchievementId: "platform_explorer",
                leapQuestAchievementEmoji: "🌿",
                leapQuestAchievementTitle: "Platform Explorer",
                leapQuestAchievementDescription: "Jump on all platform types",
                leapQuestAchievementIsUnlocked: leapQuestStorageManager.leapQuestIsAchievementUnlocked("platform_explorer"),
                leapQuestAchievementRewardCoins: 75,
                leapQuestAchievementProgress: leapQuestStorageManager.leapQuestGetAchievementProgress("platform_explorer"),
                leapQuestAchievementMaxProgress: 4
            )
        ]
    }
    
    func leapQuestUpdateAchievement(_ leapQuestAchievementId: String, progress: Int) {
        if let index = leapQuestAchievementsList.firstIndex(where: { $0.leapQuestAchievementId == leapQuestAchievementId }) {
            var leapQuestAchievement = leapQuestAchievementsList[index]
            let leapQuestNewProgress = min(progress, leapQuestAchievement.leapQuestAchievementMaxProgress)
            let leapQuestWasUnlocked = leapQuestAchievement.leapQuestAchievementIsUnlocked
            
            leapQuestAchievement = LeapQuestAchievementModel(
                leapQuestAchievementId: leapQuestAchievement.leapQuestAchievementId,
                leapQuestAchievementEmoji: leapQuestAchievement.leapQuestAchievementEmoji,
                leapQuestAchievementTitle: leapQuestAchievement.leapQuestAchievementTitle,
                leapQuestAchievementDescription: leapQuestAchievement.leapQuestAchievementDescription,
                leapQuestAchievementIsUnlocked: leapQuestNewProgress >= leapQuestAchievement.leapQuestAchievementMaxProgress,
                leapQuestAchievementRewardCoins: leapQuestAchievement.leapQuestAchievementRewardCoins,
                leapQuestAchievementProgress: leapQuestNewProgress,
                leapQuestAchievementMaxProgress: leapQuestAchievement.leapQuestAchievementMaxProgress
            )
            
            leapQuestAchievementsList[index] = leapQuestAchievement
            leapQuestStorageManager.leapQuestSaveAchievementProgress(leapQuestAchievementId, progress: leapQuestNewProgress)
            
            if !leapQuestWasUnlocked && leapQuestAchievement.leapQuestAchievementIsUnlocked {
                leapQuestStorageManager.leapQuestUnlockAchievement(leapQuestAchievementId)
                leapQuestAchievementsDelegate?.leapQuestAchievementsViewModelDidUpdate()
            }
        }
    }
    
    func leapQuestRefreshAchievements() {
        loadLeapQuestAchievements()
        leapQuestAchievementsDelegate?.leapQuestAchievementsViewModelDidUpdate()
    }
}
