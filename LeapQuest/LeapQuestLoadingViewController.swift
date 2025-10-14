import UIKit

class LeapQuestLoadingViewController: UIViewController {
    let leapQuestLogoImageView = UIImageView()
    let leapQuestTitleLabel = UILabel()
    let leapQuestSubtitleLabel = UILabel()
    let leapQuestLoadingLabel = UILabel()
    let leapQuestProgressView = UIProgressView(progressViewStyle: .default)
    let leapQuestBackgroundView = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        leapQuestSetupUI()
        leapQuestStartAnimation()
    }

    func leapQuestSetupUI() {
        view.backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)

        leapQuestBackgroundView.backgroundColor = .clear
        leapQuestBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestBackgroundView)

        leapQuestLogoImageView.image = UIImage(systemName: "leaf.fill")
        leapQuestLogoImageView.tintColor = .white
        leapQuestLogoImageView.contentMode = .scaleAspectFit
        leapQuestLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestLogoImageView)

        leapQuestTitleLabel.text = "🐸 LeapQuest"
        leapQuestTitleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        leapQuestTitleLabel.textColor = .white
        leapQuestTitleLabel.textAlignment = .center
        leapQuestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestTitleLabel)

        leapQuestSubtitleLabel.text = "Jump Through Adventure"
        leapQuestSubtitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        leapQuestSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        leapQuestSubtitleLabel.textAlignment = .center
        leapQuestSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestSubtitleLabel)

        leapQuestLoadingLabel.text = "Loading..."
        leapQuestLoadingLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        leapQuestLoadingLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        leapQuestLoadingLabel.textAlignment = .center
        leapQuestLoadingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestLoadingLabel)

        leapQuestProgressView.progressTintColor = .systemGreen
        leapQuestProgressView.trackTintColor = UIColor.white.withAlphaComponent(0.3)
        leapQuestProgressView.layer.cornerRadius = 4
        leapQuestProgressView.clipsToBounds = true
        leapQuestProgressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestProgressView)

        NSLayoutConstraint.activate([
            leapQuestBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            leapQuestBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            leapQuestLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestLogoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            leapQuestLogoImageView.widthAnchor.constraint(equalToConstant: 120),
            leapQuestLogoImageView.heightAnchor.constraint(equalToConstant: 120),

            leapQuestTitleLabel.topAnchor.constraint(equalTo: leapQuestLogoImageView.bottomAnchor, constant: 20),
            leapQuestTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            leapQuestSubtitleLabel.topAnchor.constraint(equalTo: leapQuestTitleLabel.bottomAnchor, constant: 8),
            leapQuestSubtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestSubtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            leapQuestLoadingLabel.bottomAnchor.constraint(equalTo: leapQuestProgressView.topAnchor, constant: -12),
            leapQuestLoadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestLoadingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            leapQuestProgressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            leapQuestProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            leapQuestProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            leapQuestProgressView.heightAnchor.constraint(equalToConstant: 8)
        ])

        leapQuestSetupBackgroundEmojis()
    }

    func leapQuestSetupBackgroundEmojis() {
        let leapQuestEmojis = ["🐸", "🌿", "🍃", "🌱", "🌾", "🦋", "🌸", "🌺", "🌻", "🍄", "🌰", "🍂", "🍁", "☀️", "🌙", "⭐", "🌟", "💫", "✨", "🎮", "🧩", "🏆"]

        for i in 0..<15 {
            let leapQuestEmojiLabel = UILabel()
            leapQuestEmojiLabel.text = leapQuestEmojis.randomElement()
            leapQuestEmojiLabel.font = UIFont.systemFont(ofSize: CGFloat.random(in: 20...40))
            leapQuestEmojiLabel.alpha = CGFloat.random(in: 0.1...0.3)
            leapQuestEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
            leapQuestBackgroundView.addSubview(leapQuestEmojiLabel)

            NSLayoutConstraint.activate([
                leapQuestEmojiLabel.centerXAnchor.constraint(equalTo: leapQuestBackgroundView.leadingAnchor, constant: CGFloat.random(in: 0...UIScreen.main.bounds.width)),
                leapQuestEmojiLabel.centerYAnchor.constraint(equalTo: leapQuestBackgroundView.topAnchor, constant: CGFloat.random(in: 0...UIScreen.main.bounds.height))
            ])
        }
    }

    func leapQuestStartAnimation() {
        leapQuestLogoImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        leapQuestLogoImageView.alpha = 0

        UIView.animate(withDuration: 1.0, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseOut) {
            self.leapQuestLogoImageView.transform = .identity
            self.leapQuestLogoImageView.alpha = 1
        }

        leapQuestTitleLabel.alpha = 0
        leapQuestSubtitleLabel.alpha = 0

        UIView.animate(withDuration: 0.8, delay: 0.6) {
            self.leapQuestTitleLabel.alpha = 1
            self.leapQuestSubtitleLabel.alpha = 1
        }

        leapQuestAnimateLoading()
        leapQuestAnimateProgress()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.leapQuestNavigateToMainApp()
        }
    }

    func leapQuestAnimateLoading() {
        let leapQuestLoadingTexts = ["Loading...", "Preparing adventure...", "Gathering resources...", "Almost ready..."]
        var leapQuestCurrentIndex = 0

        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
            UIView.transition(with: self.leapQuestLoadingLabel, duration: 0.3, options: .transitionCrossDissolve) {
                self.leapQuestLoadingLabel.text = leapQuestLoadingTexts[leapQuestCurrentIndex]
            }
            leapQuestCurrentIndex = (leapQuestCurrentIndex + 1) % leapQuestLoadingTexts.count
        }
    }

    func leapQuestAnimateProgress() {
        leapQuestProgressView.progress = 0

        UIView.animate(withDuration: 1.8, delay: 0.2, options: .curveEaseInOut) {
            self.leapQuestProgressView.progress = 1.0
        }
    }

    func leapQuestNavigateToMainApp() {
        let leapQuestIsFirstLaunch = !UserDefaults.standard.bool(forKey: "LeapQuestHasLaunched")

        if leapQuestIsFirstLaunch {
            let leapQuestOnboardingVC = LeapQuestOnboardingViewController()
            leapQuestOnboardingVC.modalPresentationStyle = .fullScreen
            present(leapQuestOnboardingVC, animated: true)
        } else {
            let leapQuestTabBarVC = LeapQuestTabBarController()
            leapQuestTabBarVC.modalPresentationStyle = .fullScreen
            present(leapQuestTabBarVC, animated: true)
        }
    }
}

