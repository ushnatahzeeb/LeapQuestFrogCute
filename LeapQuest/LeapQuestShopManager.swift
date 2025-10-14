import Foundation
import UIKit
import Combine

// MARK: - Shop Manager Protocol
protocol LeapQuestShopManagerDelegate: AnyObject {
    func leapQuestShopManagerDidUpdateIncome(_ income: Int)
    func leapQuestShopManagerDidUpdateUpgrades()
}

// MARK: - Shop Manager
class LeapQuestShopManager: ObservableObject {
    
    static let shared = LeapQuestShopManager()
    
    weak var leapQuestDelegate: LeapQuestShopManagerDelegate?
    
    private var leapQuestShopData: LeapQuestShopData
    private var leapQuestPassiveIncomeTimer: Timer?
    private var leapQuestBackgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    
    private let leapQuestQueue = DispatchQueue(label: "com.leapquest.shop", qos: .background)
    private let leapQuestSaveQueue = DispatchQueue(label: "com.leapquest.save", qos: .utility)
    
    private init() {
        leapQuestShopData = LeapQuestStorageManager.shared.leapQuestLoadShopData()
        leapQuestShopData.leapQuestUpdatePassiveIncome()
        startLeapQuestPassiveIncomeTimer()
        setupLeapQuestBackgroundHandling()
    }
    
    deinit {
        stopLeapQuestPassiveIncomeTimer()
    }
    
    // MARK: - Public Methods
    
    var leapQuestCurrentUpgrades: [LeapQuestUpgradeType: LeapQuestShopUpgrade] {
        return leapQuestShopData.leapQuestUpgrades
    }
    
    var leapQuestTotalPassiveIncome: Int {
        return leapQuestShopData.leapQuestTotalPassiveIncome
    }
    
    var leapQuestTotalIncomePerMinute: Int {
        return leapQuestShopData.leapQuestGetTotalIncomePerMinute()
    }
    
    var leapQuestTotalIncomePerHour: Int {
        return leapQuestShopData.leapQuestGetTotalIncomePerHour()
    }
    
    func leapQuestPurchaseUpgrade(_ upgradeType: LeapQuestUpgradeType) -> LeapQuestPurchaseResult {
        guard var upgrade = leapQuestShopData.leapQuestUpgrades[upgradeType] else {
            return LeapQuestPurchaseResult(
                leapQuestSuccess: false,
                leapQuestMessage: "Upgrade not found",
                leapQuestNewCost: nil,
                leapQuestNewIncome: nil
            )
        }
        
        let leapQuestCurrentCost = upgrade.leapQuestCurrentCost
        let leapQuestCurrentCoins = LeapQuestStorageManager.shared.leapQuestLoadGameProgress().leapQuestLeapCoins
        
        guard leapQuestCurrentCoins >= leapQuestCurrentCost else {
            return LeapQuestPurchaseResult(
                leapQuestSuccess: false,
                leapQuestMessage: "Not enough coins! Need \(leapQuestCurrentCost - leapQuestCurrentCoins) more.",
                leapQuestNewCost: leapQuestCurrentCost,
                leapQuestNewIncome: nil
            )
        }
        
        upgrade.leapQuestOwned += 1
        leapQuestShopData.leapQuestUpgrades[upgradeType] = upgrade
        
        var leapQuestGameProgress = LeapQuestStorageManager.shared.leapQuestLoadGameProgress()
        leapQuestGameProgress = LeapQuestGameProgressModel(
            leapQuestCurrentLevel: leapQuestGameProgress.leapQuestCurrentLevel,
            leapQuestLeapCoins: leapQuestGameProgress.leapQuestLeapCoins - leapQuestCurrentCost,
            leapQuestSolvedPuzzles: leapQuestGameProgress.leapQuestSolvedPuzzles,
            leapQuestUnlockedAchievements: leapQuestGameProgress.leapQuestUnlockedAchievements,
            leapQuestLeapBotMode: leapQuestGameProgress.leapQuestLeapBotMode,
            leapQuestSoundEnabled: leapQuestGameProgress.leapQuestSoundEnabled,
            leapQuestNotificationsEnabled: leapQuestGameProgress.leapQuestNotificationsEnabled
        )
        
        LeapQuestStorageManager.shared.leapQuestSaveGameProgress(leapQuestGameProgress)
        saveLeapQuestShopData()
        
        let leapQuestNewCost = upgrade.leapQuestCurrentCost
        let leapQuestNewIncome = upgrade.leapQuestTotalIncome
        
        leapQuestDelegate?.leapQuestShopManagerDidUpdateUpgrades()
        
        return LeapQuestPurchaseResult(
            leapQuestSuccess: true,
            leapQuestMessage: "Purchased \(upgradeType.leapQuestDisplayName) for \(leapQuestCurrentCost) coins!",
            leapQuestNewCost: leapQuestNewCost,
            leapQuestNewIncome: leapQuestNewIncome
        )
    }
    
    func leapQuestCollectPassiveIncome() -> Int {
        leapQuestShopData.leapQuestUpdatePassiveIncome()
        let leapQuestCollectedIncome = leapQuestShopData.leapQuestTotalPassiveIncome
        
        if leapQuestCollectedIncome > 0 {
            var leapQuestGameProgress = LeapQuestStorageManager.shared.leapQuestLoadGameProgress()
            leapQuestGameProgress = LeapQuestGameProgressModel(
                leapQuestCurrentLevel: leapQuestGameProgress.leapQuestCurrentLevel,
                leapQuestLeapCoins: leapQuestGameProgress.leapQuestLeapCoins + leapQuestCollectedIncome,
                leapQuestSolvedPuzzles: leapQuestGameProgress.leapQuestSolvedPuzzles,
                leapQuestUnlockedAchievements: leapQuestGameProgress.leapQuestUnlockedAchievements,
                leapQuestLeapBotMode: leapQuestGameProgress.leapQuestLeapBotMode,
                leapQuestSoundEnabled: leapQuestGameProgress.leapQuestSoundEnabled,
                leapQuestNotificationsEnabled: leapQuestGameProgress.leapQuestNotificationsEnabled
            )
            
            LeapQuestStorageManager.shared.leapQuestSaveGameProgress(leapQuestGameProgress)
            leapQuestShopData.leapQuestTotalPassiveIncome = 0
            saveLeapQuestShopData()
            
            leapQuestDelegate?.leapQuestShopManagerDidUpdateIncome(leapQuestCollectedIncome)
        }
        
        return leapQuestCollectedIncome
    }
    
    // MARK: - Private Methods
    
    private func startLeapQuestPassiveIncomeTimer() {
        leapQuestPassiveIncomeTimer?.invalidate()
        leapQuestPassiveIncomeTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.leapQuestQueue.async {
                self?.leapQuestUpdatePassiveIncomeInBackground()
            }
        }
    }
    
    private func stopLeapQuestPassiveIncomeTimer() {
        leapQuestPassiveIncomeTimer?.invalidate()
        leapQuestPassiveIncomeTimer = nil
    }
    
    private func leapQuestUpdatePassiveIncomeInBackground() {
        leapQuestShopData.leapQuestUpdatePassiveIncome()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.leapQuestDelegate?.leapQuestShopManagerDidUpdateUpgrades()
            
            if self.leapQuestShopData.leapQuestTotalPassiveIncome > 0 {
                self.leapQuestDelegate?.leapQuestShopManagerDidUpdateIncome(self.leapQuestShopData.leapQuestTotalPassiveIncome)
            }
        }
    }
    
    private func setupLeapQuestBackgroundHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(leapQuestAppDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(leapQuestAppWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc private func leapQuestAppDidEnterBackground() {
        leapQuestBackgroundTask = UIApplication.shared.beginBackgroundTask(withName: "LeapQuestPassiveIncome") {
            self.leapQuestBackgroundTask = UIBackgroundTaskIdentifier.invalid
        }
        
        leapQuestSaveQueue.async {
            self.saveLeapQuestShopData()
        }
    }
    
    @objc private func leapQuestAppWillEnterForeground() {
        if leapQuestBackgroundTask != UIBackgroundTaskIdentifier.invalid {
            UIApplication.shared.endBackgroundTask(leapQuestBackgroundTask)
            leapQuestBackgroundTask = UIBackgroundTaskIdentifier.invalid
        }
        
        leapQuestShopData.leapQuestUpdatePassiveIncome()
        leapQuestDelegate?.leapQuestShopManagerDidUpdateUpgrades()
    }
    
    private func saveLeapQuestShopData() {
        LeapQuestStorageManager.shared.leapQuestSaveShopData(leapQuestShopData)
    }
}

// MARK: - Storage Manager Extension
extension LeapQuestStorageManager {
    
    private static let leapQuestShopDataKey = "LeapQuestShopData"
    
    func leapQuestLoadShopData() -> LeapQuestShopData {
        guard let leapQuestData = UserDefaults.standard.data(forKey: LeapQuestStorageManager.leapQuestShopDataKey),
              let leapQuestShopData = try? JSONDecoder().decode(LeapQuestShopData.self, from: leapQuestData) else {
            return LeapQuestShopData()
        }
        return leapQuestShopData
    }
    
    func leapQuestSaveShopData(_ shopData: LeapQuestShopData) {
        do {
            let leapQuestData = try JSONEncoder().encode(shopData)
            UserDefaults.standard.set(leapQuestData, forKey: LeapQuestStorageManager.leapQuestShopDataKey)
        } catch {
            print("Failed to save shop data: \(error)")
        }
    }
}
