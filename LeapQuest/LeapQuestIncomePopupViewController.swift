import UIKit

class LeapQuestIncomePopupViewController: UIViewController {
    
    private let leapQuestIncome: Int
    private let leapQuestBackgroundView = UIView()
    private let leapQuestPopupView = UIView()
    private let leapQuestEmojiLabel = UILabel()
    private let leapQuestTitleLabel = UILabel()
    private let leapQuestIncomeLabel = UILabel()
    private let leapQuestMessageLabel = UILabel()
    private let leapQuestOkButton = UIButton(type: .system)
    private var leapQuestParticleViews: [UIView] = []
    
    init(income: Int) {
        self.leapQuestIncome = income
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestIncomePopup()
        animateLeapQuestPopup()
        createLeapQuestParticleEffect()
    }
    
    private func setupLeapQuestIncomePopup() {
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
        leapQuestEmojiLabel.text = "💰"
        leapQuestEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPopupView.addSubview(leapQuestEmojiLabel)
        
        leapQuestTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        leapQuestTitleLabel.textColor = UIColor.white
        leapQuestTitleLabel.textAlignment = .center
        leapQuestTitleLabel.text = "Passive Income Collected!"
        leapQuestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPopupView.addSubview(leapQuestTitleLabel)
        
        leapQuestIncomeLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        leapQuestIncomeLabel.textColor = UIColor.systemYellow
        leapQuestIncomeLabel.textAlignment = .center
        leapQuestIncomeLabel.text = "+\(formatLeapQuestNumber(leapQuestIncome))"
        leapQuestIncomeLabel.layer.shadowColor = UIColor.black.cgColor
        leapQuestIncomeLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        leapQuestIncomeLabel.layer.shadowRadius = 4
        leapQuestIncomeLabel.layer.shadowOpacity = 0.5
        leapQuestIncomeLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPopupView.addSubview(leapQuestIncomeLabel)
        
        leapQuestMessageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        leapQuestMessageLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        leapQuestMessageLabel.textAlignment = .center
        leapQuestMessageLabel.text = "Keep upgrading to earn more passive income!"
        leapQuestMessageLabel.numberOfLines = 0
        leapQuestMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPopupView.addSubview(leapQuestMessageLabel)
        
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
        setupLeapQuestButtonGradient()
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
            leapQuestPopupView.heightAnchor.constraint(equalToConstant: 350),
            
            glassEffect.topAnchor.constraint(equalTo: leapQuestPopupView.topAnchor),
            glassEffect.leadingAnchor.constraint(equalTo: leapQuestPopupView.leadingAnchor),
            glassEffect.trailingAnchor.constraint(equalTo: leapQuestPopupView.trailingAnchor),
            glassEffect.bottomAnchor.constraint(equalTo: leapQuestPopupView.bottomAnchor),
            
            leapQuestEmojiLabel.topAnchor.constraint(equalTo: leapQuestPopupView.topAnchor, constant: 20),
            leapQuestEmojiLabel.centerXAnchor.constraint(equalTo: leapQuestPopupView.centerXAnchor),
            
            leapQuestTitleLabel.topAnchor.constraint(equalTo: leapQuestEmojiLabel.bottomAnchor, constant: 10),
            leapQuestTitleLabel.leadingAnchor.constraint(equalTo: leapQuestPopupView.leadingAnchor, constant: 20),
            leapQuestTitleLabel.trailingAnchor.constraint(equalTo: leapQuestPopupView.trailingAnchor, constant: -20),
            
            leapQuestIncomeLabel.topAnchor.constraint(equalTo: leapQuestTitleLabel.bottomAnchor, constant: 15),
            leapQuestIncomeLabel.leadingAnchor.constraint(equalTo: leapQuestPopupView.leadingAnchor, constant: 20),
            leapQuestIncomeLabel.trailingAnchor.constraint(equalTo: leapQuestPopupView.trailingAnchor, constant: -20),
            
            leapQuestMessageLabel.topAnchor.constraint(equalTo: leapQuestIncomeLabel.bottomAnchor, constant: 15),
            leapQuestMessageLabel.leadingAnchor.constraint(equalTo: leapQuestPopupView.leadingAnchor, constant: 20),
            leapQuestMessageLabel.trailingAnchor.constraint(equalTo: leapQuestPopupView.trailingAnchor, constant: -20),
            
            leapQuestOkButton.bottomAnchor.constraint(equalTo: leapQuestPopupView.bottomAnchor, constant: -20),
            leapQuestOkButton.leadingAnchor.constraint(equalTo: leapQuestPopupView.leadingAnchor, constant: 40),
            leapQuestOkButton.trailingAnchor.constraint(equalTo: leapQuestPopupView.trailingAnchor, constant: -40),
            leapQuestOkButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupLeapQuestButtonGradient() {
        let leapQuestGradient = CAGradientLayer()
        leapQuestGradient.colors = [
            UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0).cgColor,
            UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0).cgColor
        ]
        leapQuestGradient.startPoint = CGPoint(x: 0, y: 0)
        leapQuestGradient.endPoint = CGPoint(x: 1, y: 1)
        leapQuestGradient.cornerRadius = 25
        leapQuestOkButton.layer.insertSublayer(leapQuestGradient, at: 0)
        
        DispatchQueue.main.async {
            leapQuestGradient.frame = self.leapQuestOkButton.bounds
        }
    }
    
    private func createLeapQuestParticleEffect() {
        let leapQuestParticleCount = 20
        
        for i in 0..<leapQuestParticleCount {
            let leapQuestParticle = UIView()
            leapQuestParticle.backgroundColor = UIColor.systemYellow
            leapQuestParticle.layer.cornerRadius = 4
            leapQuestParticle.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
            
            let leapQuestRandomX = CGFloat.random(in: 0...view.bounds.width)
            let leapQuestRandomY = CGFloat.random(in: 0...view.bounds.height)
            leapQuestParticle.center = CGPoint(x: leapQuestRandomX, y: leapQuestRandomY)
            
            leapQuestParticle.alpha = 0
            view.addSubview(leapQuestParticle)
            leapQuestParticleViews.append(leapQuestParticle)
            
            let leapQuestDelay = Double(i) * 0.1
            let leapQuestDuration = Double.random(in: 1.0...2.0)
            
            UIView.animate(withDuration: leapQuestDuration, delay: leapQuestDelay, options: [.curveEaseOut]) {
                leapQuestParticle.alpha = 1
                leapQuestParticle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
            
            UIView.animate(withDuration: leapQuestDuration, delay: leapQuestDelay + 0.5, options: [.curveEaseIn]) {
                leapQuestParticle.alpha = 0
                leapQuestParticle.transform = CGAffineTransform(translationX: CGFloat.random(in: -100...100), y: CGFloat.random(in: -100...100))
            }
        }
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
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseOut) {
            self.leapQuestBackgroundView.alpha = 1
            self.leapQuestPopupView.transform = .identity
            self.leapQuestPopupView.alpha = 1
        }
        
        let leapQuestIncomeAnimation = CABasicAnimation(keyPath: "transform.scale")
        leapQuestIncomeAnimation.fromValue = 0.5
        leapQuestIncomeAnimation.toValue = 1.2
        leapQuestIncomeAnimation.duration = 0.3
        leapQuestIncomeAnimation.autoreverses = true
        leapQuestIncomeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        leapQuestIncomeLabel.layer.add(leapQuestIncomeAnimation, forKey: "incomePulse")
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
    
    deinit {
        leapQuestParticleViews.forEach { $0.removeFromSuperview() }
    }
}

