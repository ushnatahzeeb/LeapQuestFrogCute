import UIKit

protocol LeapQuestGameEngineDelegate: AnyObject {
    func leapQuestGameEngineDidCompleteLevel()
    func leapQuestGameEngineDidFailLevel()
    func leapQuestGameEngineDidEarnCoins(_ amount: Int)
}

class LeapQuestGameEngine {
    
    weak var leapQuestGameEngineDelegate: LeapQuestGameEngineDelegate?
    
    private var leapQuestCurrentPlatforms: [LeapQuestPlatformModel] = []
    private var leapQuestCurrentPlatformIndex: Int = 0
    private var leapQuestScore: Int = 0
    private var leapQuestCombo: Int = 0
    private var leapQuestIsGameActive: Bool = false
    
    var leapQuestCurrentScore: Int {
        return leapQuestScore
    }
    
    var leapQuestCurrentCombo: Int {
        return leapQuestCombo
    }
    
    func leapQuestStartGame(with platforms: [LeapQuestPlatformModel]) {
        leapQuestCurrentPlatforms = platforms
        leapQuestCurrentPlatformIndex = 0
        leapQuestScore = 0
        leapQuestCombo = 0
        leapQuestIsGameActive = true
    }
    
    func leapQuestJumpToPlatform(at index: Int) -> Bool {
        guard leapQuestIsGameActive, index < leapQuestCurrentPlatforms.count else { return false }
        
        let leapQuestTargetPlatform = leapQuestCurrentPlatforms[index]
        let leapQuestJumpSuccess = calculateLeapQuestJumpSuccess(from: leapQuestCurrentPlatformIndex, to: index)
        
        if leapQuestJumpSuccess {
            leapQuestCurrentPlatformIndex = index
            leapQuestCombo += 1
            leapQuestScore += calculateLeapQuestJumpScore(platform: leapQuestTargetPlatform, combo: leapQuestCombo)
            
            if index == leapQuestCurrentPlatforms.count - 1 {
                leapQuestCompleteLevel()
            }
            
            return true
        } else {
            leapQuestFailJump()
            return false
        }
    }
    
    private func calculateLeapQuestJumpSuccess(from fromIndex: Int, to toIndex: Int) -> Bool {
        let leapQuestDistance = abs(toIndex - fromIndex)
        let leapQuestTargetPlatform = leapQuestCurrentPlatforms[toIndex]
        
        let leapQuestBaseSuccessRate: Double
        switch leapQuestTargetPlatform.leapQuestPlatformType {
        case .stable:
            leapQuestBaseSuccessRate = 0.9
        case .swinging:
            leapQuestBaseSuccessRate = 0.7
        case .falling:
            leapQuestBaseSuccessRate = 0.5
        case .moving:
            leapQuestBaseSuccessRate = 0.6
        }
        
        let leapQuestDistancePenalty = Double(leapQuestDistance) * 0.1
        let leapQuestFinalSuccessRate = max(0.1, leapQuestBaseSuccessRate - leapQuestDistancePenalty)
        
        return Double.random(in: 0...1) < leapQuestFinalSuccessRate
    }
    
    private func calculateLeapQuestJumpScore(platform: LeapQuestPlatformModel, combo: Int) -> Int {
        let leapQuestBaseScore: Int
        switch platform.leapQuestPlatformType {
        case .stable:
            leapQuestBaseScore = 10
        case .swinging:
            leapQuestBaseScore = 20
        case .falling:
            leapQuestBaseScore = 30
        case .moving:
            leapQuestBaseScore = 25
        }
        
        let leapQuestComboMultiplier = min(combo, 10)
        return leapQuestBaseScore * (1 + leapQuestComboMultiplier / 5)
    }
    
    private func leapQuestCompleteLevel() {
        leapQuestIsGameActive = false
        let leapQuestBonusCoins = leapQuestScore / 10
        leapQuestGameEngineDelegate?.leapQuestGameEngineDidEarnCoins(leapQuestBonusCoins)
        leapQuestGameEngineDelegate?.leapQuestGameEngineDidCompleteLevel()
    }
    
    private func leapQuestFailJump() {
        leapQuestCombo = 0
        leapQuestScore = max(0, leapQuestScore - 5)
    }
    
    func leapQuestEndGame() {
        leapQuestIsGameActive = false
    }
    
    func leapQuestGetCurrentPlatform() -> LeapQuestPlatformModel? {
        guard leapQuestCurrentPlatformIndex < leapQuestCurrentPlatforms.count else { return nil }
        return leapQuestCurrentPlatforms[leapQuestCurrentPlatformIndex]
    }
    
    func leapQuestGetAvailablePlatforms() -> [LeapQuestPlatformModel] {
        let leapQuestMaxJumpDistance = 2
        let leapQuestStartIndex = max(0, leapQuestCurrentPlatformIndex - leapQuestMaxJumpDistance)
        let leapQuestEndIndex = min(leapQuestCurrentPlatforms.count - 1, leapQuestCurrentPlatformIndex + leapQuestMaxJumpDistance)
        
        return Array(leapQuestCurrentPlatforms[leapQuestStartIndex...leapQuestEndIndex])
    }
}

class LeapQuestHapticFeedbackManager {
    
    static let shared = LeapQuestHapticFeedbackManager()
    private init() {}
    
    func leapQuestSuccessFeedback() {
        let leapQuestImpactFeedback = UIImpactFeedbackGenerator(style: .medium)
        leapQuestImpactFeedback.impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let leapQuestSuccessFeedback = UINotificationFeedbackGenerator()
            leapQuestSuccessFeedback.notificationOccurred(.success)
        }
    }
    
    func leapQuestFailureFeedback() {
        let leapQuestImpactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        leapQuestImpactFeedback.impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let leapQuestFailureFeedback = UINotificationFeedbackGenerator()
            leapQuestFailureFeedback.notificationOccurred(.error)
        }
    }
    
    func leapQuestJumpFeedback() {
        let leapQuestImpactFeedback = UIImpactFeedbackGenerator(style: .light)
        leapQuestImpactFeedback.impactOccurred()
    }
    
    func leapQuestCoinFeedback() {
        let leapQuestImpactFeedback = UIImpactFeedbackGenerator(style: .medium)
        leapQuestImpactFeedback.impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let leapQuestCoinFeedback = UIImpactFeedbackGenerator(style: .light)
            leapQuestCoinFeedback.impactOccurred()
        }
    }
}

class LeapQuestSoundManager {
    
    static let shared = LeapQuestSoundManager()
    private init() {}
    
    func leapQuestPlayJumpSound() {
        playLeapQuestSystemSound(1016)
    }
    
    func leapQuestPlaySuccessSound() {
        playLeapQuestSystemSound(1057)
    }
    
    func leapQuestPlayFailureSound() {
        playLeapQuestSystemSound(1053)
    }
    
    func leapQuestPlayCoinSound() {
        playLeapQuestSystemSound(1103)
    }
    
    private func playLeapQuestSystemSound(_ soundID: SystemSoundID) {
        AudioServicesPlaySystemSound(soundID)
    }
}

import AudioToolbox


