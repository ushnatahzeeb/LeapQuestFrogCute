import UIKit

class LeapQuestPurchasePopupViewController: UIViewController {
    
    private let leapQuestResult: LeapQuestPurchaseResult
    private let leapQuestBackgroundView = UIView()
    private let leapQuestPopupView = UIView()
    private let leapQuestEmojiLabel = UILabel()
    private let leapQuestTitleLabel = UILabel()
    private let leapQuestMessageLabel = UILabel()
    private let leapQuestStatsStackView = UIStackView()
    private let leapQuestOkButton = UIButton(type: .system)
    
    init(result: LeapQuestPurchaseResult) {
        self.leapQuestResult = result
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestPurchasePopup()
        animateLeapQuestPopup()
    }
    
    private func setupLeapQuestPurchasePopup() {
        view.backgroundColor = UIColor.clear
        
        leapQuestBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        leapQuestBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestBackgroundView)
        
        leapQuestPopupView.backgroundColor = UIColor.clear
        leapQuestPopupView.layer.cornerRadius = 20
        leapQuestPopupView.layer.shadowColor = UIColor.black.cgColor
        leapQuestPopupView.layer.shadowOffset = CGSize(width: 0, height: 10)
        leapQuestPopupView.layer.shadowRadius = 20
        leapQuestPopupView.layer.shadowOpacity = 0.3
        leapQuestPopupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestPopupView)
        
        let leapQuestGlassEffect = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        leapQuestGlassEffect.layer.cornerRadius = 20
        leapQuestGlassEffect.layer.masksToBounds = true
        leapQuestGlassEffect.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPopupView.addSubview(leapQuestGlassEffect)
        
        leapQuestEmojiLabel.font = UIFont.systemFont(ofSize: 60)
        leapQuestEmojiLabel.textAlignment = .center
        leapQuestEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPopupView.addSubview(leapQuestEmojiLabel)
        
        leapQuestTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        leapQuestTitleLabel.textColor = UIColor.white
        leapQuestTitleLabel.textAlignment = .center
        leapQuestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPopupView.addSubview(leapQuestTitleLabel)
        
        leapQuestMessageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        leapQuestMessageLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        leapQuestMessageLabel.textAlignment = .center
        leapQuestMessageLabel.numberOfLines = 0
        leapQuestMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPopupView.addSubview(leapQuestMessageLabel)
        
        leapQuestStatsStackView.axis = .vertical
        leapQuestStatsStackView.spacing = 8
        leapQuestStatsStackView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPopupView.addSubview(leapQuestStatsStackView)
        
        leapQuestOkButton.setTitle("Awesome! 🎉", for: .normal)
        leapQuestOkButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        leapQuestOkButton.setTitleColor(.white, for: .normal)
        leapQuestOkButton.layer.cornerRadius = 25
        leapQuestOkButton.layer.shadowColor = UIColor.black.cgColor
        leapQuestOkButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        leapQuestOkButton.layer.shadowRadius = 8
        leapQuestOkButton.layer.shadowOpacity = 0.3
        leapQuestOkButton.translatesAutoresizingMaskIntoConstraints = false
        leapQuestOkButton.addTarget(self, action: #selector(leapQuestOkButtonTapped), for: .touchUpInside)
        leapQuestPopupView.addSubview(leapQuestOkButton)
        
        setupLeapQuestConstraints(glassEffect: leapQuestGlassEffect)
        configureLeapQuestContent()
    }
    
    private func setupLeapQuestConstraints(glassEffect: UIVisualEffectView) {
        NSLayoutConstraint.activate([
            leapQuestBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            leapQuestBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            leapQuestPopupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestPopupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leapQuestPopupView.widthAnchor.constraint(equalToConstant: 320),
            leapQuestPopupView.heightAnchor.constraint(equalToConstant: 400),
            
            glassEffect.topAnchor.constraint(equalTo: leapQuestPopupView.topAnchor),
            glassEffect.leadingAnchor.constraint(equalTo: leapQuestPopupView.leadingAnchor),
            glassEffect.trailingAnchor.constraint(equalTo: leapQuestPopupView.trailingAnchor),
            glassEffect.bottomAnchor.constraint(equalTo: leapQuestPopupView.bottomAnchor),
            
            leapQuestEmojiLabel.topAnchor.constraint(equalTo: leapQuestPopupView.topAnchor, constant: 20),
            leapQuestEmojiLabel.centerXAnchor.constraint(equalTo: leapQuestPopupView.centerXAnchor),
            
            leapQuestTitleLabel.topAnchor.constraint(equalTo: leapQuestEmojiLabel.bottomAnchor, constant: 10),
            leapQuestTitleLabel.leadingAnchor.constraint(equalTo: leapQuestPopupView.leadingAnchor, constant: 20),
            leapQuestTitleLabel.trailingAnchor.constraint(equalTo: leapQuestPopupView.trailingAnchor, constant: -20),
            
            leapQuestMessageLabel.topAnchor.constraint(equalTo: leapQuestTitleLabel.bottomAnchor, constant: 15),
            leapQuestMessageLabel.leadingAnchor.constraint(equalTo: leapQuestPopupView.leadingAnchor, constant: 20),
            leapQuestMessageLabel.trailingAnchor.constraint(equalTo: leapQuestPopupView.trailingAnchor, constant: -20),
            
            leapQuestStatsStackView.topAnchor.constraint(equalTo: leapQuestMessageLabel.bottomAnchor, constant: 20),
            leapQuestStatsStackView.leadingAnchor.constraint(equalTo: leapQuestPopupView.leadingAnchor, constant: 20),
            leapQuestStatsStackView.trailingAnchor.constraint(equalTo: leapQuestPopupView.trailingAnchor, constant: -20),
            
            leapQuestOkButton.bottomAnchor.constraint(equalTo: leapQuestPopupView.bottomAnchor, constant: -20),
            leapQuestOkButton.leadingAnchor.constraint(equalTo: leapQuestPopupView.leadingAnchor, constant: 40),
            leapQuestOkButton.trailingAnchor.constraint(equalTo: leapQuestPopupView.trailingAnchor, constant: -40),
            leapQuestOkButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureLeapQuestContent() {
        if leapQuestResult.leapQuestSuccess {
            leapQuestEmojiLabel.text = "🎉"
            leapQuestTitleLabel.text = "Purchase Successful!"
            leapQuestMessageLabel.text = leapQuestResult.leapQuestMessage
            
            if let newCost = leapQuestResult.leapQuestNewCost {
                let leapQuestCostLabel = createLeapQuestStatLabel(text: "Next cost: 💰 \(formatLeapQuestNumber(newCost))", color: .systemYellow)
                leapQuestStatsStackView.addArrangedSubview(leapQuestCostLabel)
            }
            
            if let newIncome = leapQuestResult.leapQuestNewIncome {
                let leapQuestIncomeLabel = createLeapQuestStatLabel(text: "Income: +\(formatLeapQuestNumber(newIncome))/min", color: .systemGreen)
                leapQuestStatsStackView.addArrangedSubview(leapQuestIncomeLabel)
            }
            
            let leapQuestGradient = CAGradientLayer()
            leapQuestGradient.colors = [
                UIColor(red: 0.2, green: 0.8, blue: 0.3, alpha: 1.0).cgColor,
                UIColor(red: 0.1, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
            ]
            leapQuestGradient.startPoint = CGPoint(x: 0, y: 0)
            leapQuestGradient.endPoint = CGPoint(x: 1, y: 1)
            leapQuestGradient.cornerRadius = 25
            leapQuestOkButton.layer.insertSublayer(leapQuestGradient, at: 0)
            
        } else {
            leapQuestEmojiLabel.text = "😔"
            leapQuestTitleLabel.text = "Purchase Failed"
            leapQuestMessageLabel.text = leapQuestResult.leapQuestMessage
            
            if let newCost = leapQuestResult.leapQuestNewCost {
                let leapQuestCostLabel = createLeapQuestStatLabel(text: "Cost: 💰 \(formatLeapQuestNumber(newCost))", color: .systemYellow)
                leapQuestStatsStackView.addArrangedSubview(leapQuestCostLabel)
            }
            
            let leapQuestGradient = CAGradientLayer()
            leapQuestGradient.colors = [
                UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0).cgColor,
                UIColor(red: 0.6, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
            ]
            leapQuestGradient.startPoint = CGPoint(x: 0, y: 0)
            leapQuestGradient.endPoint = CGPoint(x: 1, y: 1)
            leapQuestGradient.cornerRadius = 25
            leapQuestOkButton.layer.insertSublayer(leapQuestGradient, at: 0)
        }
        
        DispatchQueue.main.async {
            if let leapQuestGradient = self.leapQuestOkButton.layer.sublayers?.first as? CAGradientLayer {
                leapQuestGradient.frame = self.leapQuestOkButton.bounds
            }
        }
    }
    
    private func createLeapQuestStatLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = color
        label.textAlignment = .center
        return label
    }
    
    private func formatLeapQuestNumber(_ number: Int) -> String {
        if number >= 1_000_000 {
            return String(format: "%.1fM", Double(number) / 1_000_000)
        } else if number >= 1_000 {
            return String(format: "%.1fK", Double(number) / 1_000)
        } else {
            return "\(number)"
        }
    }
    
    private func animateLeapQuestPopup() {
        leapQuestBackgroundView.alpha = 0
        leapQuestPopupView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        leapQuestPopupView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.leapQuestBackgroundView.alpha = 1
            self.leapQuestPopupView.transform = .identity
            self.leapQuestPopupView.alpha = 1
        }
    }
    
    @objc private func leapQuestOkButtonTapped() {
        let leapQuestButtonAnimation = CABasicAnimation(keyPath: "transform.scale")
        leapQuestButtonAnimation.fromValue = 1.0
        leapQuestButtonAnimation.toValue = 0.95
        leapQuestButtonAnimation.duration = 0.1
        leapQuestButtonAnimation.autoreverses = true
        leapQuestOkButton.layer.add(leapQuestButtonAnimation, forKey: "buttonPress")
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }) { _ in
            self.dismiss(animated: false)
        }
    }
}

