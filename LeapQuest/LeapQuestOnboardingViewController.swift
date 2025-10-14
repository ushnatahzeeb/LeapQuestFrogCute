import UIKit

class LeapQuestOnboardingViewController: UIViewController {
    
    private var leapQuestBackgroundView: LeapQuestGradientView!
    private var leapQuestScrollView: UIScrollView!
    private var leapQuestContentView: UIView!
    private var leapQuestPageControl: UIPageControl!
    private var leapQuestNextButton: UIButton!
    private var leapQuestSkipButton: UIButton!
    
    private var leapQuestOnboardingPages: [LeapQuestOnboardingPage] = []
    private var leapQuestCurrentPageIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestOnboardingViewController()
        setupLeapQuestOnboardingData()
        setupLeapQuestOnboardingUI()
        setupLeapQuestOnboardingPages()
    }
    
    private func setupLeapQuestOnboardingViewController() {
        view.backgroundColor = LeapQuestColorTheme.Background.primary
    }
    
    private func setupLeapQuestOnboardingData() {
        leapQuestOnboardingPages = [
            LeapQuestOnboardingPage(
                emoji: "🐸",
                title: "Welcome to LeapQuest!",
                description: "Join our adventurous frog on an exciting journey across mystical rivers and challenging puzzles. Get ready for an amazing gaming experience!"
            ),
            LeapQuestOnboardingPage(
                emoji: "🎮",
                title: "Jump & Solve",
                description: "Help the frog jump on swinging platforms and solve mind-bending puzzles to progress through levels. Each jump requires precision and timing!"
            ),
            LeapQuestOnboardingPage(
                emoji: "🧩",
                title: "Brain Teasers",
                description: "Challenge yourself with various puzzle types including Tic-Tac-Toe and Memory Sequence games. Train your brain while having fun!"
            ),
            LeapQuestOnboardingPage(
                emoji: "🏆",
                title: "Achievements & Rewards",
                description: "Earn LeapCoins by completing levels and solving puzzles. Unlock achievements, upgrade your frog, and discover new locations!"
            ),
            LeapQuestOnboardingPage(
                emoji: "🌟",
                title: "Ready to Start?",
                description: "You're all set! Begin your epic journey and help our brave frog reach the other side of the cosmic river. Good luck, adventurer!"
            )
        ]
    }
    
    private func setupLeapQuestOnboardingUI() {
        setupLeapQuestBackgroundView()
        setupLeapQuestScrollView()
        setupLeapQuestPageControl()
        setupLeapQuestButtons()
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
    
    private func setupLeapQuestScrollView() {
        leapQuestScrollView = UIScrollView()
        leapQuestScrollView.delegate = self
        leapQuestScrollView.isPagingEnabled = true
        leapQuestScrollView.showsHorizontalScrollIndicator = false
        leapQuestScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestScrollView)
        
        leapQuestContentView = UIView()
        leapQuestContentView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestScrollView.addSubview(leapQuestContentView)
        
        NSLayoutConstraint.activate([
            leapQuestScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leapQuestScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestScrollView.widthAnchor.constraint(equalToConstant: 370),
            leapQuestScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            leapQuestContentView.topAnchor.constraint(equalTo: leapQuestScrollView.topAnchor),
            leapQuestContentView.leadingAnchor.constraint(equalTo: leapQuestScrollView.leadingAnchor),
            leapQuestContentView.trailingAnchor.constraint(equalTo: leapQuestScrollView.trailingAnchor),
            leapQuestContentView.bottomAnchor.constraint(equalTo: leapQuestScrollView.bottomAnchor),
            leapQuestContentView.heightAnchor.constraint(equalTo: leapQuestScrollView.heightAnchor)
        ])
    }
    
    private func setupLeapQuestPageControl() {
        leapQuestPageControl = UIPageControl()
        leapQuestPageControl.numberOfPages = leapQuestOnboardingPages.count
        leapQuestPageControl.currentPage = 0
        leapQuestPageControl.pageIndicatorTintColor = LeapQuestColorTheme.Text.secondary
        leapQuestPageControl.currentPageIndicatorTintColor = LeapQuestColorTheme.Primary.frogGreen
        leapQuestPageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestPageControl)
        
        NSLayoutConstraint.activate([
            leapQuestPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestPageControl.bottomAnchor.constraint(equalTo: leapQuestScrollView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupLeapQuestButtons() {
        leapQuestNextButton = UIButton(type: .system)
        leapQuestNextButton.setTitle("Next →", for: .normal)
        leapQuestNextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        leapQuestNextButton.setTitleColor(LeapQuestColorTheme.Text.primary, for: .normal)
        leapQuestNextButton.backgroundColor = LeapQuestColorTheme.Primary.frogGreen
        leapQuestNextButton.layer.cornerRadius = 25
        leapQuestNextButton.layer.shadowColor = LeapQuestColorTheme.Shadow.primary.cgColor
        leapQuestNextButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        leapQuestNextButton.layer.shadowRadius = 8
        leapQuestNextButton.layer.shadowOpacity = 0.3
        leapQuestNextButton.translatesAutoresizingMaskIntoConstraints = false
        leapQuestNextButton.addTarget(self, action: #selector(leapQuestNextButtonTapped), for: .touchUpInside)
        view.addSubview(leapQuestNextButton)
        
        leapQuestSkipButton = UIButton(type: .system)
        leapQuestSkipButton.setTitle("Skip", for: .normal)
        leapQuestSkipButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        leapQuestSkipButton.setTitleColor(LeapQuestColorTheme.Text.secondary, for: .normal)
        leapQuestSkipButton.translatesAutoresizingMaskIntoConstraints = false
        leapQuestSkipButton.addTarget(self, action: #selector(leapQuestSkipButtonTapped), for: .touchUpInside)
        view.addSubview(leapQuestSkipButton)
        
        NSLayoutConstraint.activate([
            leapQuestNextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            leapQuestNextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            leapQuestNextButton.widthAnchor.constraint(equalToConstant: 120),
            leapQuestNextButton.heightAnchor.constraint(equalToConstant: 50),
            
            leapQuestSkipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leapQuestSkipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            leapQuestSkipButton.widthAnchor.constraint(equalToConstant: 80),
            leapQuestSkipButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupLeapQuestOnboardingPages() {
        let fixedWidth: CGFloat = 370
        
        for (index, page) in leapQuestOnboardingPages.enumerated() {
            let pageView = createLeapQuestPageView(for: page)
            pageView.translatesAutoresizingMaskIntoConstraints = false
            leapQuestContentView.addSubview(pageView)
            
            NSLayoutConstraint.activate([
                pageView.leadingAnchor.constraint(equalTo: leapQuestContentView.leadingAnchor, constant: CGFloat(index) * fixedWidth),
                pageView.topAnchor.constraint(equalTo: leapQuestContentView.topAnchor),
                pageView.widthAnchor.constraint(equalToConstant: fixedWidth),
                pageView.heightAnchor.constraint(equalTo: leapQuestContentView.heightAnchor)
            ])
            
            if index == leapQuestOnboardingPages.count - 1 {
                leapQuestContentView.trailingAnchor.constraint(equalTo: pageView.trailingAnchor).isActive = true
            }
        }
    }
    
    private func createLeapQuestPageView(for page: LeapQuestOnboardingPage) -> UIView {
        let pageView = UIView()
        pageView.backgroundColor = .clear
        
        let emojiLabel = UILabel()
        emojiLabel.text = page.emoji
        emojiLabel.font = UIFont.systemFont(ofSize: 100)
        emojiLabel.textAlignment = .center
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        pageView.addSubview(emojiLabel)
        
        let titleLabel = UILabel()
        titleLabel.text = page.title
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = LeapQuestColorTheme.Text.primary
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        pageView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = page.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.textColor = LeapQuestColorTheme.Text.secondary
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        pageView.addSubview(descriptionLabel)
        
        // Add floating emojis for decoration
        let floatingEmojis = ["🌟", "✨", "💫", "⭐", "🌙"]
        for i in 0..<6 {
            let floatingEmoji = UILabel()
            floatingEmoji.text = floatingEmojis.randomElement()
            floatingEmoji.font = UIFont.systemFont(ofSize: CGFloat.random(in: 20...30))
            floatingEmoji.alpha = 0.6
            floatingEmoji.translatesAutoresizingMaskIntoConstraints = false
            pageView.addSubview(floatingEmoji)
            
            NSLayoutConstraint.activate([
                floatingEmoji.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: CGFloat.random(in: 20...300)),
                floatingEmoji.topAnchor.constraint(equalTo: pageView.topAnchor, constant: CGFloat.random(in: 100...400))
            ])
            
            // Add floating animation
            let floatAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            floatAnimation.fromValue = 0
            floatAnimation.toValue = -15
            floatAnimation.duration = Double.random(in: 2...4)
            floatAnimation.autoreverses = true
            floatAnimation.repeatCount = .infinity
            floatAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            floatingEmoji.layer.add(floatAnimation, forKey: "floatAnimation\(i)")
        }
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            emojiLabel.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 80),
            
            titleLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 30),
            titleLabel.widthAnchor.constraint(equalToConstant: 325),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 325)
        ])
        
        return pageView
    }
    
    @objc private func leapQuestNextButtonTapped() {
        if leapQuestCurrentPageIndex < leapQuestOnboardingPages.count - 1 {
            leapQuestCurrentPageIndex += 1
            let fixedWidth: CGFloat = 370
            let offsetX = CGFloat(leapQuestCurrentPageIndex) * fixedWidth
            leapQuestScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            updateLeapQuestButtons()
        } else {
            presentLeapQuestMainApp()
        }
    }
    
    @objc private func leapQuestSkipButtonTapped() {
        presentLeapQuestMainApp()
    }
    
    private func updateLeapQuestButtons() {
        leapQuestPageControl.currentPage = leapQuestCurrentPageIndex
        
        if leapQuestCurrentPageIndex == leapQuestOnboardingPages.count - 1 {
            leapQuestNextButton.setTitle("Start", for: .normal)
            leapQuestSkipButton.isHidden = true
        } else {
            leapQuestNextButton.setTitle("Next →", for: .normal)
            leapQuestSkipButton.isHidden = false
        }
        
        // Add haptic feedback
        LeapQuestHapticFeedbackManager.shared.leapQuestJumpFeedback()
    }
    
    private func presentLeapQuestMainApp() {
        let tabBarController = LeapQuestTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.modalTransitionStyle = .crossDissolve
        present(tabBarController, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension LeapQuestOnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let fixedWidth: CGFloat = 370
        let pageIndex = Int(round(scrollView.contentOffset.x / fixedWidth))
        leapQuestCurrentPageIndex = pageIndex
        updateLeapQuestButtons()
    }
}

// MARK: - Onboarding Page Model
struct LeapQuestOnboardingPage {
    let emoji: String
    let title: String
    let description: String
}
