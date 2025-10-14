import UIKit
import SpriteKit

class LeapQuestFrogViewController: UIViewController {
    
    private var leapQuestFrogViewModel: LeapQuestFrogViewModel!
    private var leapQuestGameEngine: LeapQuestGameEngine!
    private var leapQuestBackgroundView: LeapQuestGradientView!
    private var leapQuestGameAreaView: LeapQuestGlassmorphismView!
    private var leapQuestSpriteKitView: SKView!
    private var leapQuestGameScene: LeapQuestGameScene!
    private var leapQuestLevelLabel: UILabel!
    private var leapQuestLeapCoinsLabel: UILabel!
    private var leapQuestStartButton: UIButton!
    private var leapQuestPauseButton: UIButton!
    private var leapQuestShopButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestFrogViewController()
        setupLeapQuestFrogViewModel()
        setupLeapQuestFrogUI()
    }
    
    private func setupLeapQuestFrogViewController() {
        title = "🐸 LeapQuest"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = LeapQuestColorTheme.Text.primary
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        
        setupLeapQuestBackgroundView()
    }
    
    private func setupLeapQuestBackgroundView() {
        leapQuestBackgroundView = LeapQuestGradientView(leapQuestGradientType: .water)
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
    
    private func setupLeapQuestFrogViewModel() {
        leapQuestFrogViewModel = LeapQuestFrogViewModel()
        leapQuestFrogViewModel.leapQuestFrogDelegate = self
        
        leapQuestGameEngine = LeapQuestGameEngine()
        leapQuestGameEngine.leapQuestGameEngineDelegate = self
    }
    
    private func setupLeapQuestFrogUI() {
        setupLeapQuestFrogHeaderView()
        setupLeapQuestFrogControls()
        setupLeapQuestFrogGameArea()
        updateLeapQuestFrogDisplay()
    }
    
    private func setupLeapQuestFrogHeaderView() {
        let leapQuestHeaderStackView = UIStackView()
        leapQuestHeaderStackView.axis = .horizontal
        leapQuestHeaderStackView.distribution = .equalSpacing
        leapQuestHeaderStackView.alignment = .center
        leapQuestHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestLevelLabel = UILabel()
        leapQuestLevelLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        leapQuestLevelLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestLevelLabel.text = "Level 1"
        leapQuestLevelLabel.layer.shadowColor = LeapQuestColorTheme.Shadow.primary.cgColor
        leapQuestLevelLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        leapQuestLevelLabel.layer.shadowRadius = 4
        leapQuestLevelLabel.layer.shadowOpacity = 0.3
        
        leapQuestLeapCoinsLabel = UILabel()
        leapQuestLeapCoinsLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        leapQuestLeapCoinsLabel.textColor = LeapQuestColorTheme.Text.accent
        leapQuestLeapCoinsLabel.text = "💰 0"
        leapQuestLeapCoinsLabel.layer.shadowColor = LeapQuestColorTheme.Shadow.primary.cgColor
        leapQuestLeapCoinsLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        leapQuestLeapCoinsLabel.layer.shadowRadius = 4
        leapQuestLeapCoinsLabel.layer.shadowOpacity = 0.3
        
        leapQuestHeaderStackView.addArrangedSubview(leapQuestLevelLabel)
        leapQuestHeaderStackView.addArrangedSubview(leapQuestLeapCoinsLabel)
        
        view.addSubview(leapQuestHeaderStackView)
        
        NSLayoutConstraint.activate([
            leapQuestHeaderStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            leapQuestHeaderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestHeaderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupLeapQuestFrogGameArea() {
        leapQuestGameAreaView = LeapQuestGlassmorphismView()
        leapQuestGameAreaView.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestSpriteKitView = SKView()
        leapQuestSpriteKitView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestSpriteKitView.ignoresSiblingOrder = true
        leapQuestSpriteKitView.showsFPS = false
        leapQuestSpriteKitView.showsNodeCount = false
        
        leapQuestGameAreaView.addSubview(leapQuestSpriteKitView)
        view.addSubview(leapQuestGameAreaView)
        
        NSLayoutConstraint.activate([
            leapQuestGameAreaView.topAnchor.constraint(equalTo: leapQuestLevelLabel.bottomAnchor, constant: 20),
            leapQuestGameAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestGameAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            leapQuestGameAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            
            leapQuestSpriteKitView.topAnchor.constraint(equalTo: leapQuestGameAreaView.topAnchor, constant: 10),
            leapQuestSpriteKitView.leadingAnchor.constraint(equalTo: leapQuestGameAreaView.leadingAnchor, constant: 10),
            leapQuestSpriteKitView.trailingAnchor.constraint(equalTo: leapQuestGameAreaView.trailingAnchor, constant: -10),
            leapQuestSpriteKitView.bottomAnchor.constraint(equalTo: leapQuestGameAreaView.bottomAnchor, constant: -10)
        ])
        
        setupLeapQuestGameScene()
    }
    
    private func setupLeapQuestGameScene() {
        leapQuestGameScene = LeapQuestGameScene()
        leapQuestGameScene.scaleMode = .aspectFill
        leapQuestGameScene.size = CGSize(width: 400, height: 500)
        leapQuestSpriteKitView.presentScene(leapQuestGameScene)
    }
    
    private func setupLeapQuestFrogControls() {
        leapQuestStartButton = UIButton(type: .system)
        leapQuestStartButton.setTitle("🚀 Start Game", for: .normal)
        leapQuestStartButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        let leapQuestButtonGradient = CAGradientLayer()
        leapQuestButtonGradient.colors = LeapQuestColorTheme.Gradients.frog.map { $0.cgColor }
        leapQuestButtonGradient.startPoint = CGPoint(x: 0, y: 0)
        leapQuestButtonGradient.endPoint = CGPoint(x: 1, y: 1)
        leapQuestButtonGradient.cornerRadius = 25
        leapQuestStartButton.layer.insertSublayer(leapQuestButtonGradient, at: 0)
        
        leapQuestStartButton.setTitleColor(LeapQuestColorTheme.Text.primary, for: .normal)
        leapQuestStartButton.layer.cornerRadius = 25
        leapQuestStartButton.layer.shadowColor = LeapQuestColorTheme.Shadow.success.cgColor
        leapQuestStartButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        leapQuestStartButton.layer.shadowRadius = 8
        leapQuestStartButton.layer.shadowOpacity = 0.3
        leapQuestStartButton.translatesAutoresizingMaskIntoConstraints = false
        leapQuestStartButton.addTarget(self, action: #selector(leapQuestStartButtonTapped), for: .touchUpInside)
        
        leapQuestPauseButton = UIButton(type: .system)
        leapQuestPauseButton.setTitle("⏸️ Pause", for: .normal)
        leapQuestPauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        leapQuestPauseButton.backgroundColor = LeapQuestColorTheme.Secondary.starGold
        leapQuestPauseButton.setTitleColor(LeapQuestColorTheme.Text.primary, for: .normal)
        leapQuestPauseButton.layer.cornerRadius = 20
        leapQuestPauseButton.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPauseButton.addTarget(self, action: #selector(leapQuestPauseButtonTapped), for: .touchUpInside)
        leapQuestPauseButton.isHidden = true
        
        leapQuestShopButton = UIButton(type: .system)
        leapQuestShopButton.setTitle("🛒 Shop", for: .normal)
        leapQuestShopButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        let leapQuestShopButtonGradient = CAGradientLayer()
        leapQuestShopButtonGradient.colors = LeapQuestColorTheme.Gradients.coins.map { $0.cgColor }
        leapQuestShopButtonGradient.startPoint = CGPoint(x: 0, y: 0)
        leapQuestShopButtonGradient.endPoint = CGPoint(x: 1, y: 1)
        leapQuestShopButtonGradient.cornerRadius = 20
        leapQuestShopButton.layer.insertSublayer(leapQuestShopButtonGradient, at: 0)
        
        leapQuestShopButton.setTitleColor(LeapQuestColorTheme.Text.primary, for: .normal)
        leapQuestShopButton.layer.cornerRadius = 20
        leapQuestShopButton.layer.shadowColor = LeapQuestColorTheme.Shadow.glow.cgColor
        leapQuestShopButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        leapQuestShopButton.layer.shadowRadius = 4
        leapQuestShopButton.layer.shadowOpacity = 0.3
        leapQuestShopButton.translatesAutoresizingMaskIntoConstraints = false
        leapQuestShopButton.addTarget(self, action: #selector(leapQuestShopButtonTapped), for: .touchUpInside)
        leapQuestShopButton.isHidden = false
        
        view.addSubview(leapQuestStartButton)
        view.addSubview(leapQuestPauseButton)
        view.addSubview(leapQuestShopButton)
        
        NSLayoutConstraint.activate([
            leapQuestStartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            leapQuestStartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestStartButton.widthAnchor.constraint(equalToConstant: 180),
            leapQuestStartButton.heightAnchor.constraint(equalToConstant: 50),
            
            leapQuestPauseButton.bottomAnchor.constraint(equalTo: leapQuestStartButton.topAnchor, constant: -10),
            leapQuestPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestPauseButton.widthAnchor.constraint(equalToConstant: 120),
            leapQuestPauseButton.heightAnchor.constraint(equalToConstant: 40),
            
            leapQuestShopButton.bottomAnchor.constraint(equalTo: leapQuestStartButton.topAnchor, constant: -10),
            leapQuestShopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestShopButton.widthAnchor.constraint(equalToConstant: 120),
            leapQuestShopButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        DispatchQueue.main.async {
            leapQuestButtonGradient.frame = self.leapQuestStartButton.bounds
            leapQuestShopButtonGradient.frame = self.leapQuestShopButton.bounds
        }
    }
    
    @objc private func leapQuestStartButtonTapped() {
        let leapQuestButtonAnimation = CABasicAnimation(keyPath: "transform.scale")
        leapQuestButtonAnimation.fromValue = 1.0
        leapQuestButtonAnimation.toValue = 0.95
        leapQuestButtonAnimation.duration = 0.1
        leapQuestButtonAnimation.autoreverses = true
        leapQuestStartButton.layer.add(leapQuestButtonAnimation, forKey: "buttonPress")
        
        LeapQuestHapticFeedbackManager.shared.leapQuestJumpFeedback()
        LeapQuestSoundManager.shared.leapQuestPlayJumpSound()
        
        leapQuestStartButton.isHidden = true
        leapQuestPauseButton.isHidden = false
        
        leapQuestGameScene.startLeapQuestGame()
    }
    
    @objc private func leapQuestPauseButtonTapped() {
        let leapQuestButtonAnimation = CABasicAnimation(keyPath: "transform.scale")
        leapQuestButtonAnimation.fromValue = 1.0
        leapQuestButtonAnimation.toValue = 0.95
        leapQuestButtonAnimation.duration = 0.1
        leapQuestButtonAnimation.autoreverses = true
        leapQuestPauseButton.layer.add(leapQuestButtonAnimation, forKey: "buttonPress")
        
        if leapQuestGameScene.isPaused {
            leapQuestGameScene.isPaused = false
            leapQuestPauseButton.setTitle("⏸️ Pause", for: .normal)
        } else {
            leapQuestGameScene.isPaused = true
            leapQuestPauseButton.setTitle("▶️ Resume", for: .normal)
        }
    }
    
    @objc private func leapQuestShopButtonTapped() {
        let leapQuestButtonAnimation = CABasicAnimation(keyPath: "transform.scale")
        leapQuestButtonAnimation.fromValue = 1.0
        leapQuestButtonAnimation.toValue = 0.95
        leapQuestButtonAnimation.duration = 0.1
        leapQuestButtonAnimation.autoreverses = true
        leapQuestShopButton.layer.add(leapQuestButtonAnimation, forKey: "buttonPress")
        
        LeapQuestHapticFeedbackManager.shared.leapQuestCoinFeedback()
        LeapQuestSoundManager.shared.leapQuestPlayCoinSound()
        
        let leapQuestShopVC = LeapQuestShopViewController()
        let leapQuestNavigationController = UINavigationController(rootViewController: leapQuestShopVC)
        leapQuestNavigationController.modalPresentationStyle = .fullScreen
        leapQuestNavigationController.modalTransitionStyle = .coverVertical
        present(leapQuestNavigationController, animated: true)
    }
    
    private func updateLeapQuestFrogDisplay() {
        leapQuestLevelLabel.text = "Level \(leapQuestFrogViewModel.leapQuestCurrentLevel)"
        leapQuestLeapCoinsLabel.text = "💰 \(leapQuestFrogViewModel.leapQuestLeapCoins)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if leapQuestSpriteKitView != nil && leapQuestGameScene != nil {
            let leapQuestNewSize = CGSize(width: leapQuestSpriteKitView.bounds.width, height: leapQuestSpriteKitView.bounds.height)
            if leapQuestNewSize.width > 0 && leapQuestNewSize.height > 0 {
                leapQuestGameScene.size = leapQuestNewSize
            }
        }
    }
}

extension LeapQuestFrogViewController: LeapQuestFrogViewModelDelegate {
    func leapQuestFrogViewModelDidUpdate() {
        DispatchQueue.main.async {
            self.updateLeapQuestFrogDisplay()
        }
    }
}

extension LeapQuestFrogViewController: LeapQuestGameEngineDelegate {
    func leapQuestGameEngineDidCompleteLevel() {
        DispatchQueue.main.async {
            LeapQuestHapticFeedbackManager.shared.leapQuestSuccessFeedback()
            LeapQuestSoundManager.shared.leapQuestPlaySuccessSound()
            
            let leapQuestAlert = UIAlertController(title: "🎉 Level Complete!", message: "Great job! You completed the level with a score of \(self.leapQuestGameEngine.leapQuestCurrentScore)", preferredStyle: .alert)
            leapQuestAlert.addAction(UIAlertAction(title: "Continue", style: .default) { _ in
                self.leapQuestFrogViewModel.leapQuestCompleteLevel()
            })
            self.present(leapQuestAlert, animated: true)
        }
    }
    
    func leapQuestGameEngineDidFailLevel() {
        DispatchQueue.main.async {
            LeapQuestHapticFeedbackManager.shared.leapQuestFailureFeedback()
            LeapQuestSoundManager.shared.leapQuestPlayFailureSound()
            
            let leapQuestAlert = UIAlertController(title: "💥 Game Over", message: "Better luck next time! Try again?", preferredStyle: .alert)
            leapQuestAlert.addAction(UIAlertAction(title: "Try Again", style: .default) { _ in
                self.leapQuestFrogViewModel.leapQuestStartLevel()
            })
            leapQuestAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(leapQuestAlert, animated: true)
        }
    }
    
    func leapQuestGameEngineDidEarnCoins(_ amount: Int) {
        DispatchQueue.main.async {
            LeapQuestHapticFeedbackManager.shared.leapQuestCoinFeedback()
            LeapQuestSoundManager.shared.leapQuestPlayCoinSound()
            
            self.leapQuestFrogViewModel.leapQuestEarnLeapCoins(amount)
            
            let leapQuestCoinLabel = UILabel()
            leapQuestCoinLabel.text = "+\(amount) 💰"
            leapQuestCoinLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            leapQuestCoinLabel.textColor = LeapQuestColorTheme.Text.accent
            leapQuestCoinLabel.alpha = 0
            leapQuestCoinLabel.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(leapQuestCoinLabel)
            
            leapQuestCoinLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            leapQuestCoinLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            
            UIView.animate(withDuration: 1.0, animations: {
                leapQuestCoinLabel.alpha = 1
                leapQuestCoinLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }) { _ in
                UIView.animate(withDuration: 0.5, animations: {
                    leapQuestCoinLabel.alpha = 0
                    leapQuestCoinLabel.transform = CGAffineTransform(translationX: 0, y: -50)
                }) { _ in
                    leapQuestCoinLabel.removeFromSuperview()
                }
            }
        }
    }
}
