import UIKit

class LeapQuestMemorySequenceViewController: UIViewController {
    
    private var leapQuestGameState: LeapQuestMemorySequenceState!
    private var leapQuestButtons: [UIButton] = []
    private var leapQuestLevelLabel: UILabel!
    private var leapQuestScoreLabel: UILabel!
    private var leapQuestStatusLabel: UILabel!
    private var leapQuestBackgroundView: LeapQuestGradientView!
    private var leapQuestGameBoard: UIView!
    private var leapQuestDisplayTimer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestMemorySequenceViewController()
        setupLeapQuestBackground()
        setupLeapQuestGameBoard()
        setupLeapQuestUI()
        startLeapQuestNewGame()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        leapQuestDisplayTimer?.invalidate()
    }
    
    private func setupLeapQuestMemorySequenceViewController() {
        title = "🧠 Memory Sequence"
        navigationController?.navigationBar.tintColor = LeapQuestColorTheme.Text.primary
        
        leapQuestGameState = LeapQuestMemorySequenceState()
    }
    
    private func setupLeapQuestBackground() {
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
    
    private func setupLeapQuestGameBoard() {
        leapQuestGameBoard = UIView()
        leapQuestGameBoard.backgroundColor = LeapQuestColorTheme.Background.card
        leapQuestGameBoard.layer.cornerRadius = 20
        leapQuestGameBoard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestGameBoard)
        
        let leapQuestColors: [UIColor] = [
            UIColor.systemRed,
            UIColor.systemBlue,
            UIColor.systemGreen,
            UIColor.systemOrange,
            UIColor.systemPurple,
            UIColor.systemYellow,
            UIColor.systemPink,
            UIColor.systemTeal,
            UIColor.systemIndigo
        ]
        
        for i in 0..<9 {
            let button = UIButton(type: .system)
            button.backgroundColor = leapQuestColors[i].withAlphaComponent(0.7)
            button.layer.cornerRadius = 25
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            button.setTitle("\(i + 1)", for: .normal)
            button.setTitleColor(LeapQuestColorTheme.Text.primary, for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(leapQuestButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.alpha = 0.5
            
            leapQuestGameBoard.addSubview(button)
            leapQuestButtons.append(button)
        }
    }
    
    private func setupLeapQuestUI() {
        leapQuestLevelLabel = UILabel()
        leapQuestLevelLabel.text = "Level: 1"
        leapQuestLevelLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        leapQuestLevelLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestLevelLabel.textAlignment = .center
        leapQuestLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestLevelLabel)
        
        leapQuestScoreLabel = UILabel()
        leapQuestScoreLabel.text = "Score: 0"
        leapQuestScoreLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        leapQuestScoreLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestScoreLabel.textAlignment = .center
        leapQuestScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestScoreLabel)
        
        leapQuestStatusLabel = UILabel()
        leapQuestStatusLabel.text = "Watch the sequence!"
        leapQuestStatusLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        leapQuestStatusLabel.textColor = LeapQuestColorTheme.Text.secondary
        leapQuestStatusLabel.textAlignment = .center
        leapQuestStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestStatusLabel)
        
        let leapQuestNewGameButton = UIButton(type: .system)
        leapQuestNewGameButton.setTitle("New Game", for: .normal)
        leapQuestNewGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        leapQuestNewGameButton.backgroundColor = LeapQuestColorTheme.Primary.waterBlue.withAlphaComponent(0.8)
        leapQuestNewGameButton.setTitleColor(LeapQuestColorTheme.Text.primary, for: .normal)
        leapQuestNewGameButton.layer.cornerRadius = 12
        leapQuestNewGameButton.addTarget(self, action: #selector(leapQuestNewGameTapped), for: .touchUpInside)
        leapQuestNewGameButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestNewGameButton)
        
        NSLayoutConstraint.activate([
            leapQuestLevelLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            leapQuestLevelLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestLevelLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            leapQuestScoreLabel.topAnchor.constraint(equalTo: leapQuestLevelLabel.bottomAnchor, constant: 5),
            leapQuestScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            leapQuestStatusLabel.topAnchor.constraint(equalTo: leapQuestScoreLabel.bottomAnchor, constant: 10),
            leapQuestStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            leapQuestGameBoard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestGameBoard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leapQuestGameBoard.widthAnchor.constraint(equalToConstant: 300),
            leapQuestGameBoard.heightAnchor.constraint(equalToConstant: 300),
            
            leapQuestNewGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            leapQuestNewGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestNewGameButton.widthAnchor.constraint(equalToConstant: 120),
            leapQuestNewGameButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        setupLeapQuestGameBoardConstraints()
    }
    
    private func setupLeapQuestGameBoardConstraints() {
        for (index, button) in leapQuestButtons.enumerated() {
            let row = index / 3
            let col = index % 3
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 80),
                button.heightAnchor.constraint(equalToConstant: 80),
                button.leadingAnchor.constraint(equalTo: leapQuestGameBoard.leadingAnchor, constant: CGFloat(20 + col * 90)),
                button.topAnchor.constraint(equalTo: leapQuestGameBoard.topAnchor, constant: CGFloat(20 + row * 90))
            ])
        }
    }
    
    private func startLeapQuestNewGame() {
        leapQuestGameState = LeapQuestMemorySequenceState()
        leapQuestGameState.leapQuestCurrentLevel = 1
        leapQuestGameState.leapQuestMaxLevel = 1
        leapQuestGameState.leapQuestPlayerSequence = []
        
        updateLeapQuestUI()
        generateLeapQuestNewSequence()
        showLeapQuestSequence()
    }
    
    private func generateLeapQuestNewSequence() {
        leapQuestGameState.leapQuestSequence = []
        for _ in 0..<leapQuestGameState.leapQuestCurrentLevel {
            leapQuestGameState.leapQuestSequence.append(Int.random(in: 0..<9))
        }
    }
    
    private func showLeapQuestSequence() {
        leapQuestGameState.leapQuestGameStatus = .showing
        leapQuestGameState.leapQuestShowSequence = true
        leapQuestGameState.leapQuestSequenceIndex = 0
        leapQuestStatusLabel.text = "Watch the sequence!"
        
        for button in leapQuestButtons {
            button.alpha = 0.5
            button.isEnabled = false
        }
        
        leapQuestDisplaySequence()
    }
    
    private func leapQuestDisplaySequence() {
        guard leapQuestGameState.leapQuestSequenceIndex < leapQuestGameState.leapQuestSequence.count else {
            leapQuestGameState.leapQuestGameStatus = .playing
            leapQuestGameState.leapQuestShowSequence = false
            leapQuestGameState.leapQuestPlayerSequence = []
            leapQuestStatusLabel.text = "Now repeat the sequence!"
            
            for button in leapQuestButtons {
                button.alpha = 1.0
                button.isEnabled = true
            }
            return
        }
        
        let currentIndex = leapQuestGameState.leapQuestSequence[leapQuestGameState.leapQuestSequenceIndex]
        let button = leapQuestButtons[currentIndex]
        
        UIView.animate(withDuration: 0.3, animations: {
            button.alpha = 1.0
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                button.alpha = 0.5
                button.transform = CGAffineTransform.identity
            }) { _ in
                self.leapQuestGameState.leapQuestSequenceIndex += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.leapQuestDisplaySequence()
                }
            }
        }
        
        LeapQuestHapticFeedbackManager.shared.leapQuestCoinFeedback()
    }
    
    @objc private func leapQuestButtonTapped(_ sender: UIButton) {
        guard leapQuestGameState.leapQuestGameStatus == .playing else { return }
        
        let selectedIndex = sender.tag
        leapQuestGameState.leapQuestPlayerSequence.append(selectedIndex)
        
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = CGAffineTransform.identity
            }
        }
        
        LeapQuestHapticFeedbackManager.shared.leapQuestCoinFeedback()
        
        checkLeapQuestPlayerSequence()
    }
    
    private func checkLeapQuestPlayerSequence() {
        let playerSequence = leapQuestGameState.leapQuestPlayerSequence
        let correctSequence = leapQuestGameState.leapQuestSequence
        
        if playerSequence.count == correctSequence.count {
            if playerSequence == correctSequence {
                leapQuestGameState.leapQuestGameStatus = .correct
                leapQuestGameState.leapQuestCurrentLevel += 1
                leapQuestGameState.leapQuestMaxLevel = max(leapQuestGameState.leapQuestMaxLevel, leapQuestGameState.leapQuestCurrentLevel)
                
                leapQuestStatusLabel.text = "Correct! Next level!"
                LeapQuestSoundManager.shared.leapQuestPlayCoinSound()
                
                updateLeapQuestUI()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.generateLeapQuestNewSequence()
                    self.showLeapQuestSequence()
                }
            } else {
                leapQuestGameState.leapQuestGameStatus = .wrong
                leapQuestStatusLabel.text = "Wrong sequence! Game over!"
                
                for button in leapQuestButtons {
                    button.isEnabled = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.showLeapQuestGameOver()
                }
            }
        }
    }
    
    private func showLeapQuestGameOver() {
        let score = (leapQuestGameState.leapQuestMaxLevel - 1) * 10
        
        let alert = UIAlertController(
            title: "Game Over!",
            message: "You reached level \(leapQuestGameState.leapQuestMaxLevel)!\nFinal score: \(score)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default) { _ in
            self.startLeapQuestNewGame()
        })
        
        alert.addAction(UIAlertAction(title: "Back", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    private func updateLeapQuestUI() {
        leapQuestLevelLabel.text = "Level: \(leapQuestGameState.leapQuestCurrentLevel)"
        leapQuestScoreLabel.text = "Best: \(leapQuestGameState.leapQuestMaxLevel - 1)"
    }
    
    @objc private func leapQuestNewGameTapped() {
        startLeapQuestNewGame()
    }
}
