import UIKit
import Combine

class LeapQuestShopViewController: UIViewController {
    
    private var leapQuestShopManager: LeapQuestShopManager!
    private var leapQuestBackgroundView: LeapQuestGradientView!
    private var leapQuestShopCollectionView: UICollectionView!
    private var leapQuestIncomeLabel: UILabel!
    private var leapQuestCoinsLabel: UILabel!
    private var leapQuestCollectButton: UIButton!
    private var leapQuestPassiveIncomeLabel: UILabel!
    
    private var leapQuestCancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestShopViewController()
        setupLeapQuestShopManager()
        setupLeapQuestShopUI()
        setupLeapQuestObservers()
    }
    
    private func setupLeapQuestShopViewController() {
        title = "🛒 LeapQuest Shop"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = LeapQuestColorTheme.Text.primary
        
        // Add close button
        let leapQuestCloseButton = UIBarButtonItem(
            title: "✕",
            style: .plain,
            target: self,
            action: #selector(leapQuestCloseButtonTapped)
        )
        leapQuestCloseButton.tintColor = LeapQuestColorTheme.Text.primary
        navigationItem.leftBarButtonItem = leapQuestCloseButton
        
        setupLeapQuestBackgroundView()
    }
    
    private func setupLeapQuestBackgroundView() {
        leapQuestBackgroundView = LeapQuestGradientView(leapQuestGradientType: .cosmic)
        leapQuestBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(leapQuestBackgroundView, at: 0)
        
        NSLayoutConstraint.activate([
            leapQuestBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            leapQuestBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        leapQuestBackgroundView.leapQuestAnimateGradient()
    }
    
    private func setupLeapQuestShopManager() {
        leapQuestShopManager = LeapQuestShopManager.shared
        leapQuestShopManager.leapQuestDelegate = self
    }
    
    private func setupLeapQuestShopUI() {
        setupLeapQuestShopHeader()
        setupLeapQuestShopCollectionView()
        setupLeapQuestCollectButton()
    }
    
    private func setupLeapQuestShopHeader() {
        let leapQuestHeaderStackView = UIStackView()
        leapQuestHeaderStackView.axis = .vertical
        leapQuestHeaderStackView.spacing = 10
        leapQuestHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestCoinsLabel = UILabel()
        leapQuestCoinsLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        leapQuestCoinsLabel.textColor = LeapQuestColorTheme.Text.accent
        leapQuestCoinsLabel.textAlignment = .center
        leapQuestCoinsLabel.layer.shadowColor = LeapQuestColorTheme.Shadow.glow.cgColor
        leapQuestCoinsLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        leapQuestCoinsLabel.layer.shadowRadius = 4
        leapQuestCoinsLabel.layer.shadowOpacity = 0.3
        
        leapQuestIncomeLabel = UILabel()
        leapQuestIncomeLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        leapQuestIncomeLabel.textColor = LeapQuestColorTheme.Text.accent
        leapQuestIncomeLabel.textAlignment = .center
        leapQuestIncomeLabel.layer.shadowColor = LeapQuestColorTheme.Shadow.glow.cgColor
        leapQuestIncomeLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        leapQuestIncomeLabel.layer.shadowRadius = 4
        leapQuestIncomeLabel.layer.shadowOpacity = 0.3
        
        leapQuestPassiveIncomeLabel = UILabel()
        leapQuestPassiveIncomeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        leapQuestPassiveIncomeLabel.textColor = LeapQuestColorTheme.Text.secondary
        leapQuestPassiveIncomeLabel.textAlignment = .center
        leapQuestPassiveIncomeLabel.numberOfLines = 0
        
        leapQuestHeaderStackView.addArrangedSubview(leapQuestCoinsLabel)
        leapQuestHeaderStackView.addArrangedSubview(leapQuestIncomeLabel)
        leapQuestHeaderStackView.addArrangedSubview(leapQuestPassiveIncomeLabel)
        
        view.addSubview(leapQuestHeaderStackView)
        
        NSLayoutConstraint.activate([
            leapQuestHeaderStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            leapQuestHeaderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestHeaderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        updateLeapQuestShopDisplay()
    }
    
    private func setupLeapQuestShopCollectionView() {
        let leapQuestLayout = UICollectionViewFlowLayout()
        leapQuestLayout.scrollDirection = .vertical
        leapQuestLayout.minimumInteritemSpacing = 15
        leapQuestLayout.minimumLineSpacing = 15
        leapQuestLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        leapQuestShopCollectionView = UICollectionView(frame: .zero, collectionViewLayout: leapQuestLayout)
        leapQuestShopCollectionView.backgroundColor = UIColor.clear
        leapQuestShopCollectionView.delegate = self
        leapQuestShopCollectionView.dataSource = self
        leapQuestShopCollectionView.register(LeapQuestShopUpgradeCell.self, forCellWithReuseIdentifier: "LeapQuestShopUpgradeCell")
        leapQuestShopCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leapQuestShopCollectionView)
        
        NSLayoutConstraint.activate([
            leapQuestShopCollectionView.topAnchor.constraint(equalTo: leapQuestPassiveIncomeLabel.bottomAnchor, constant: 20),
            leapQuestShopCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestShopCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestShopCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])
    }
    
    private func setupLeapQuestCollectButton() {
        leapQuestCollectButton = UIButton(type: .system)
        leapQuestCollectButton.setTitle("💰 Collect Passive Income", for: .normal)
        leapQuestCollectButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        let leapQuestButtonGradient = CAGradientLayer()
        leapQuestButtonGradient.colors = LeapQuestColorTheme.Gradients.coins.map { $0.cgColor }
        leapQuestButtonGradient.startPoint = CGPoint(x: 0, y: 0)
        leapQuestButtonGradient.endPoint = CGPoint(x: 1, y: 1)
        leapQuestButtonGradient.cornerRadius = 25
        leapQuestCollectButton.layer.insertSublayer(leapQuestButtonGradient, at: 0)
        
        leapQuestCollectButton.setTitleColor(LeapQuestColorTheme.Text.primary, for: .normal)
        leapQuestCollectButton.layer.cornerRadius = 25
        leapQuestCollectButton.layer.shadowColor = LeapQuestColorTheme.Shadow.glow.cgColor
        leapQuestCollectButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        leapQuestCollectButton.layer.shadowRadius = 8
        leapQuestCollectButton.layer.shadowOpacity = 0.3
        leapQuestCollectButton.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCollectButton.addTarget(self, action: #selector(leapQuestCollectButtonTapped), for: .touchUpInside)
        
        view.addSubview(leapQuestCollectButton)
        
        NSLayoutConstraint.activate([
            leapQuestCollectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            leapQuestCollectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestCollectButton.widthAnchor.constraint(equalToConstant: 280),
            leapQuestCollectButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        DispatchQueue.main.async {
            leapQuestButtonGradient.frame = self.leapQuestCollectButton.bounds
        }
    }
    
    private func setupLeapQuestObservers() {
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in
                self?.updateLeapQuestShopDisplay()
            }
            .store(in: &leapQuestCancellables)
    }
    
    @objc private func leapQuestCollectButtonTapped() {
        let leapQuestButtonAnimation = CABasicAnimation(keyPath: "transform.scale")
        leapQuestButtonAnimation.fromValue = 1.0
        leapQuestButtonAnimation.toValue = 0.95
        leapQuestButtonAnimation.duration = 0.1
        leapQuestButtonAnimation.autoreverses = true
        leapQuestCollectButton.layer.add(leapQuestButtonAnimation, forKey: "buttonPress")
        
        LeapQuestHapticFeedbackManager.shared.leapQuestCoinFeedback()
        LeapQuestSoundManager.shared.leapQuestPlayCoinSound()
        
        let leapQuestCollectedIncome = leapQuestShopManager.leapQuestCollectPassiveIncome()
        
        if leapQuestCollectedIncome > 0 {
            showLeapQuestIncomeCollectedPopup(leapQuestCollectedIncome)
        } else {
            showLeapQuestNoIncomePopup()
        }
        
        updateLeapQuestShopDisplay()
    }
    
    @objc private func leapQuestCloseButtonTapped() {
        LeapQuestHapticFeedbackManager.shared.leapQuestCoinFeedback()
        LeapQuestSoundManager.shared.leapQuestPlayCoinSound()
        
        dismiss(animated: true, completion: nil)
    }
    
    private func updateLeapQuestShopDisplay() {
        let leapQuestGameProgress = LeapQuestStorageManager.shared.leapQuestLoadGameProgress()
        leapQuestCoinsLabel.text = "💰 \(leapQuestGameProgress.leapQuestLeapCoins)"
        leapQuestIncomeLabel.text = "Income: \(leapQuestShopManager.leapQuestTotalIncomePerMinute)/min"
        leapQuestPassiveIncomeLabel.text = "Total passive income: \(leapQuestShopManager.leapQuestTotalIncomePerHour)/hour\nReady to collect: \(leapQuestShopManager.leapQuestTotalPassiveIncome) coins"
    }
    
    private func showLeapQuestIncomeCollectedPopup(_ income: Int) {
        let leapQuestPopup = LeapQuestIncomePopupViewController(income: income)
        leapQuestPopup.modalPresentationStyle = .overCurrentContext
        leapQuestPopup.modalTransitionStyle = .crossDissolve
        present(leapQuestPopup, animated: true)
    }
    
    private func showLeapQuestNoIncomePopup() {
        let leapQuestAlert = UIAlertController(title: "💤 No Passive Income Yet", message: "Purchase upgrades to start earning passive income!", preferredStyle: .alert)
        leapQuestAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(leapQuestAlert, animated: true)
    }
    
    private func showLeapQuestPurchasePopup(_ result: LeapQuestPurchaseResult) {
        let leapQuestPopup = LeapQuestPurchasePopupViewController(result: result)
        leapQuestPopup.modalPresentationStyle = .overCurrentContext
        leapQuestPopup.modalTransitionStyle = .crossDissolve
        present(leapQuestPopup, animated: true)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension LeapQuestShopViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LeapQuestUpgradeType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeapQuestShopUpgradeCell", for: indexPath) as! LeapQuestShopUpgradeCell
        
        let upgradeType = LeapQuestUpgradeType.allCases[indexPath.item]
        let upgrade = leapQuestShopManager.leapQuestCurrentUpgrades[upgradeType]!
        let gameProgress = LeapQuestStorageManager.shared.leapQuestLoadGameProgress()
        
        cell.configure(with: upgrade, currentCoins: gameProgress.leapQuestLeapCoins) { [weak self] in
            self?.leapQuestPurchaseUpgrade(upgradeType)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leapQuestPadding: CGFloat = 40
        let leapQuestSpacing: CGFloat = 15
        let leapQuestAvailableWidth = view.bounds.width - leapQuestPadding - leapQuestSpacing
        let leapQuestCellWidth = leapQuestAvailableWidth / 2
        return CGSize(width: leapQuestCellWidth, height: 200)
    }
    
    private func leapQuestPurchaseUpgrade(_ upgradeType: LeapQuestUpgradeType) {
        let result = leapQuestShopManager.leapQuestPurchaseUpgrade(upgradeType)
        
        if result.leapQuestSuccess {
            LeapQuestHapticFeedbackManager.shared.leapQuestSuccessFeedback()
            LeapQuestSoundManager.shared.leapQuestPlaySuccessSound()
        } else {
            LeapQuestHapticFeedbackManager.shared.leapQuestFailureFeedback()
            LeapQuestSoundManager.shared.leapQuestPlayFailureSound()
        }
        
        showLeapQuestPurchasePopup(result)
        updateLeapQuestShopDisplay()
        leapQuestShopCollectionView.reloadData()
    }
}

// MARK: - Shop Manager Delegate
extension LeapQuestShopViewController: LeapQuestShopManagerDelegate {
    
    func leapQuestShopManagerDidUpdateIncome(_ income: Int) {
        DispatchQueue.main.async {
            self.updateLeapQuestShopDisplay()
        }
    }
    
    func leapQuestShopManagerDidUpdateUpgrades() {
        DispatchQueue.main.async {
            self.updateLeapQuestShopDisplay()
            self.leapQuestShopCollectionView.reloadData()
        }
    }
}

