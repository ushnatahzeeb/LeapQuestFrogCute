import UIKit

class LeapQuestLaunchViewController: UIViewController {
    
    private var leapQuestBackgroundView: LeapQuestGradientView!
    private var leapQuestFrogImageView: UILabel!
    private var leapQuestLoadingLabel: UILabel!
    private var leapQuestParticlesView: LeapQuestParticleEffectView!
    private var leapQuestFloatingEmojis: [UILabel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestLaunchViewController()
        setupLeapQuestLaunchUI()
        startLeapQuestLaunchAnimations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performLeapQuestLaunchSequence()
    }
    
    private func setupLeapQuestLaunchViewController() {
        view.backgroundColor = LeapQuestColorTheme.Background.primary
    }
    
    private func setupLeapQuestLaunchUI() {
        setupLeapQuestBackgroundView()
        setupLeapQuestFrogImageView()
        setupLeapQuestLoadingLabel()
        setupLeapQuestParticlesView()
        setupLeapQuestFloatingEmojis()
    }
    
    private func setupLeapQuestBackgroundView() {
        leapQuestBackgroundView = LeapQuestGradientView(leapQuestGradientType: .cosmic)
        leapQuestBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestBackgroundView)
        
        NSLayoutConstraint.activate([
            leapQuestBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            leapQuestBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        leapQuestBackgroundView.leapQuestAnimateGradient()
    }
    
    private func setupLeapQuestFrogImageView() {
        leapQuestFrogImageView = UILabel()
        leapQuestFrogImageView.text = "🐸"
        leapQuestFrogImageView.font = UIFont.systemFont(ofSize: 120)
        leapQuestFrogImageView.textAlignment = .center
        leapQuestFrogImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestFrogImageView)
        
        NSLayoutConstraint.activate([
            leapQuestFrogImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestFrogImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
    }
    
    private func setupLeapQuestLoadingLabel() {
        leapQuestLoadingLabel = UILabel()
        leapQuestLoadingLabel.text = "Loading..."
        leapQuestLoadingLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        leapQuestLoadingLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestLoadingLabel.textAlignment = .center
        leapQuestLoadingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestLoadingLabel)
        
        NSLayoutConstraint.activate([
            leapQuestLoadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestLoadingLabel.topAnchor.constraint(equalTo: leapQuestFrogImageView.bottomAnchor, constant: 40)
        ])
    }
    
    private func setupLeapQuestParticlesView() {
        leapQuestParticlesView = LeapQuestParticleEffectView()
        leapQuestParticlesView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestParticlesView)
        
        NSLayoutConstraint.activate([
            leapQuestParticlesView.topAnchor.constraint(equalTo: view.topAnchor),
            leapQuestParticlesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestParticlesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestParticlesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        leapQuestParticlesView.leapQuestStartParticles()
    }
    
    private func setupLeapQuestFloatingEmojis() {
        let emojis = ["🌟", "💫", "✨", "⭐", "🌙", "🌊", "🌿", "🍃", "🌱", "🦋", "🐛", "🌺", "🌸", "🌼", "🌻"]
        
        for _ in 0..<12 {
            let emojiLabel = UILabel()
            emojiLabel.text = emojis.randomElement()
            emojiLabel.font = UIFont.systemFont(ofSize: CGFloat.random(in: 20...40))
            emojiLabel.textAlignment = .center
            emojiLabel.alpha = 0.7
            emojiLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(emojiLabel)
            
            // Random positioning
            let xPosition = CGFloat.random(in: 0...view.bounds.width)
            let yPosition = CGFloat.random(in: 0...view.bounds.height)
            
            NSLayoutConstraint.activate([
                emojiLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: xPosition),
                emojiLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: yPosition)
            ])
            
            leapQuestFloatingEmojis.append(emojiLabel)
        }
    }
    
    private func startLeapQuestLaunchAnimations() {
        // Frog bounce animation
        let bounceAnimation = CABasicAnimation(keyPath: "transform.scale")
        bounceAnimation.fromValue = 1.0
        bounceAnimation.toValue = 1.2
        bounceAnimation.duration = 0.8
        bounceAnimation.autoreverses = true
        bounceAnimation.repeatCount = .infinity
        bounceAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        leapQuestFrogImageView.layer.add(bounceAnimation, forKey: "bounceAnimation")
        
        // Loading text animation
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.3
        fadeAnimation.duration = 1.0
        fadeAnimation.autoreverses = true
        fadeAnimation.repeatCount = .infinity
        leapQuestLoadingLabel.layer.add(fadeAnimation, forKey: "fadeAnimation")
        
        // Floating emojis animation
        for (index, emojiLabel) in leapQuestFloatingEmojis.enumerated() {
            let floatAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            floatAnimation.fromValue = 0
            floatAnimation.toValue = -20
            floatAnimation.duration = Double.random(in: 2...4)
            floatAnimation.autoreverses = true
            floatAnimation.repeatCount = .infinity
            floatAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            emojiLabel.layer.add(floatAnimation, forKey: "floatAnimation\(index)")
        }
    }
    
    private func performLeapQuestLaunchSequence() {
        // Wait for 1.5-2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.5...2.0)) {
            self.checkLeapQuestFirstLaunch()
        }
    }
    
    private func checkLeapQuestFirstLaunch() {
        let isFirstLaunch = !LeapQuestStorageManager.shared.leapQuestHasLaunchedBefore()
        
        if isFirstLaunch {
            LeapQuestStorageManager.shared.leapQuestMarkAsLaunched()
            presentLeapQuestOnboarding()
        } else {
            presentLeapQuestMainApp()
        }
    }
    
    private func presentLeapQuestOnboarding() {
        let onboardingVC = LeapQuestOnboardingViewController()
        onboardingVC.modalPresentationStyle = .fullScreen
        onboardingVC.modalTransitionStyle = .crossDissolve
        present(onboardingVC, animated: true)
    }
    
    private func presentLeapQuestMainApp() {
        let tabBarController = LeapQuestTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.modalTransitionStyle = .crossDissolve
        present(tabBarController, animated: true)
    }
}
