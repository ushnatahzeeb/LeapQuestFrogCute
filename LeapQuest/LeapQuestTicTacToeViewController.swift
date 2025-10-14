import UIKit

class LeapQuestTicTacToeViewController: UIViewController {
    
    private var leapQuestGameState: LeapQuestTicTacToeState!
    private var leapQuestButtons: [UIButton] = []
    private var leapQuestScoreLabel: UILabel!
    private var leapQuestStatusLabel: UILabel!
    private var leapQuestBackgroundView: LeapQuestGradientView!
    private var leapQuestGameBoard: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestTicTacToeViewController()
        setupLeapQuestBackground()
        setupLeapQuestGameBoard()
        setupLeapQuestUI()
        startLeapQuestNewGame()
    }
    
    private func setupLeapQuestTicTacToeViewController() {
        title = "🎯 Tic Tac Toe"
        navigationController?.navigationBar.tintColor = LeapQuestColorTheme.Text.primary
        
        leapQuestGameState = LeapQuestTicTacToeState()
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
        
        for i in 0..<9 {
            let button = UIButton(type: .system)
            button.backgroundColor = LeapQuestColorTheme.Text.primary
            button.layer.cornerRadius = 15
            button.titleLabel?.font = UIFont.systemFont(ofSize: 48, weight: .bold)
            button.setTitleColor(LeapQuestColorTheme.Background.primary, for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(leapQuestButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            leapQuestGameBoard.addSubview(button)
            leapQuestButtons.append(button)
        }
    }
    
    private func setupLeapQuestUI() {
        leapQuestScoreLabel = UILabel()
        leapQuestScoreLabel.text = "Score: 0 - 0"
        leapQuestScoreLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        leapQuestScoreLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestScoreLabel.textAlignment = .center
        leapQuestScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestScoreLabel)
        
        leapQuestStatusLabel = UILabel()
        leapQuestStatusLabel.text = "Your turn!"
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
            leapQuestScoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            leapQuestScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            leapQuestStatusLabel.topAnchor.constraint(equalTo: leapQuestScoreLabel.bottomAnchor, constant: 10),
            leapQuestStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            leapQuestGameBoard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestGameBoard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
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
                button.widthAnchor.constraint(equalToConstant: 85),
                button.heightAnchor.constraint(equalToConstant: 85),
                button.leadingAnchor.constraint(equalTo: leapQuestGameBoard.leadingAnchor, constant: CGFloat(10 + col * 95)),
                button.topAnchor.constraint(equalTo: leapQuestGameBoard.topAnchor, constant: CGFloat(10 + row * 95))
            ])
        }
    }
    
    @objc private func leapQuestButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        guard leapQuestGameState.leapQuestBoard[index] == "" && leapQuestGameState.leapQuestGameStatus == .playing else {
            return
        }
        
        leapQuestGameState.leapQuestBoard[index] = leapQuestGameState.leapQuestCurrentPlayer
        sender.setTitle(leapQuestGameState.leapQuestCurrentPlayer, for: .normal)
        
        if leapQuestGameState.leapQuestCurrentPlayer == "X" {
            sender.setTitleColor(LeapQuestColorTheme.Primary.waterBlue, for: .normal)
        } else {
            sender.setTitleColor(UIColor.systemRed, for: .normal)
        }
        
        LeapQuestHapticFeedbackManager.shared.leapQuestCoinFeedback()
        
        if leapQuestGameState.leapQuestCurrentPlayer == "X" {
            leapQuestGameState.leapQuestCurrentPlayer = "O"
            leapQuestStatusLabel.text = "Computer's turn..."
            updateLeapQuestGameStatus()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.leapQuestComputerMove()
            }
        }
    }
    
    private func leapQuestComputerMove() {
        guard leapQuestGameState.leapQuestGameStatus == .playing else { return }
        
        let availableMoves = leapQuestGameState.leapQuestBoard.enumerated().compactMap { index, value in
            value == "" ? index : nil
        }
        
        if let randomMove = availableMoves.randomElement() {
            leapQuestGameState.leapQuestBoard[randomMove] = "O"
            let button = leapQuestButtons[randomMove]
            button.setTitle("O", for: .normal)
            button.setTitleColor(UIColor.systemRed, for: .normal)
            
            LeapQuestHapticFeedbackManager.shared.leapQuestCoinFeedback()
            
            leapQuestGameState.leapQuestCurrentPlayer = "X"
            leapQuestStatusLabel.text = "Your turn!"
            updateLeapQuestGameStatus()
        }
    }
    
    private func updateLeapQuestGameStatus() {
        if let winner = leapQuestCheckWinner() {
            leapQuestGameState.leapQuestGameStatus = winner == "X" ? .playerWon : .computerWon
            
            if winner == "X" {
                leapQuestGameState.leapQuestPlayerScore += 1
                leapQuestStatusLabel.text = "You won! 🎉"
                LeapQuestSoundManager.shared.leapQuestPlayCoinSound()
            } else {
                leapQuestGameState.leapQuestComputerScore += 1
                leapQuestStatusLabel.text = "Computer won! 😔"
            }
            
            updateLeapQuestScore()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.startLeapQuestNewGame()
            }
        } else if leapQuestGameState.leapQuestBoard.allSatisfy({ $0 != "" }) {
            leapQuestGameState.leapQuestGameStatus = .draw
            leapQuestStatusLabel.text = "It's a draw! 🤝"
            updateLeapQuestScore()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.startLeapQuestNewGame()
            }
        }
    }
    
    private func leapQuestCheckWinner() -> String? {
        let winningCombinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
            [0, 4, 8], [2, 4, 6] // Diagonals
        ]
        
        for combination in winningCombinations {
            let first = leapQuestGameState.leapQuestBoard[combination[0]]
            let second = leapQuestGameState.leapQuestBoard[combination[1]]
            let third = leapQuestGameState.leapQuestBoard[combination[2]]
            
            if first == second && second == third && first != "" {
                return first
            }
        }
        
        return nil
    }
    
    private func updateLeapQuestScore() {
        leapQuestScoreLabel.text = "Score: \(leapQuestGameState.leapQuestPlayerScore) - \(leapQuestGameState.leapQuestComputerScore)"
    }
    
    @objc private func leapQuestNewGameTapped() {
        startLeapQuestNewGame()
    }
    
    private func startLeapQuestNewGame() {
        leapQuestGameState = LeapQuestTicTacToeState()
        leapQuestGameState.leapQuestPlayerScore = leapQuestGameState.leapQuestPlayerScore
        leapQuestGameState.leapQuestComputerScore = leapQuestGameState.leapQuestComputerScore
        
        for button in leapQuestButtons {
            button.setTitle("", for: .normal)
        }
        
        leapQuestStatusLabel.text = "Your turn!"
        updateLeapQuestScore()
    }
}
