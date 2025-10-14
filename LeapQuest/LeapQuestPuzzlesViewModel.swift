import Foundation

class LeapQuestPuzzlesViewModel {
    
    weak var leapQuestPuzzlesDelegate: LeapQuestPuzzlesViewModelDelegate?
    
    private var leapQuestPuzzles: [LeapQuestPuzzle] = []
    private let leapQuestStorageManager = LeapQuestStorageManager.shared
    private let leapQuestAchievementManager = LeapQuestAchievementManager.shared
    
    init() {
        loadLeapQuestPuzzles()
    }
    
    func leapQuestGetPuzzles() -> [LeapQuestPuzzle] {
        return leapQuestPuzzles
    }
    
    func leapQuestGetPuzzle(for type: LeapQuestPuzzleType) -> LeapQuestPuzzle? {
        return leapQuestPuzzles.first { $0.leapQuestType == type }
    }
    
    func leapQuestCompletePuzzle(_ type: LeapQuestPuzzleType, with score: Int) {
        guard let index = leapQuestPuzzles.firstIndex(where: { $0.leapQuestType == type }) else { return }
        
        leapQuestPuzzles[index].leapQuestComplete(with: score)
        saveLeapQuestPuzzles()
        
        // Track achievement
        leapQuestAchievementManager.leapQuestHandlePuzzleSolved()
        
        leapQuestPuzzlesDelegate?.leapQuestPuzzlesViewModelDidUpdate()
    }
    
    func leapQuestUnlockPuzzle(_ type: LeapQuestPuzzleType) {
        guard let index = leapQuestPuzzles.firstIndex(where: { $0.leapQuestType == type }) else { return }
        
        leapQuestPuzzles[index].leapQuestState = .available
        saveLeapQuestPuzzles()
        
        leapQuestPuzzlesDelegate?.leapQuestPuzzlesViewModelDidUpdate()
    }
    
    func leapQuestGetCompletedPuzzles() -> [LeapQuestPuzzle] {
        return leapQuestPuzzles.filter { $0.leapQuestIsCompleted }
    }
    
    func leapQuestGetTotalScore() -> Int {
        return leapQuestPuzzles.reduce(0) { $0 + $1.leapQuestBestScore }
    }
    
    private func loadLeapQuestPuzzles() {
        if let savedPuzzles = leapQuestStorageManager.leapQuestLoadPuzzles() {
            leapQuestPuzzles = savedPuzzles
        } else {
            initializeLeapQuestPuzzles()
        }
    }
    
    private func initializeLeapQuestPuzzles() {
        leapQuestPuzzles = LeapQuestPuzzleType.allCases.map { type in
            LeapQuestPuzzle(leapQuestType: type)
        }
        saveLeapQuestPuzzles()
    }
    
    private func saveLeapQuestPuzzles() {
        leapQuestStorageManager.leapQuestSavePuzzles(leapQuestPuzzles)
    }
}