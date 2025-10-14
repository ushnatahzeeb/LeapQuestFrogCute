import UIKit

class LeapQuestFactDetailViewController: UIViewController {
    
    private var leapQuestFact: LeapQuestFact
    
    private var leapQuestScrollView: UIScrollView!
    private var leapQuestContentView: UIView!
    private var leapQuestBackgroundGradient: LeapQuestGradientView!
    
    private var leapQuestCategoryIconLabel: UILabel!
    private var leapQuestFactEmojiLabel: UILabel!
    private var leapQuestTitleLabel: UILabel!
    private var leapQuestCategoryLabel: UILabel!
    private var leapQuestDifficultyLabel: UILabel!
    private var leapQuestReadTimeLabel: UILabel!
    private var leapQuestContentLabel: UILabel!
    private var leapQuestReadStatusView: UIView!
    
    init(fact: LeapQuestFact) {
        self.leapQuestFact = fact
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestFactDetailViewController()
        setupLeapQuestFactDetailUI()
        markLeapQuestFactAsRead()
    }
    
    private func setupLeapQuestFactDetailViewController() {
        title = leapQuestFact.leapQuestTitle
        navigationController?.navigationBar.tintColor = LeapQuestColorTheme.Text.primary
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        
        leapQuestBackgroundGradient = LeapQuestGradientView(leapQuestGradientType: .cosmic)
        leapQuestBackgroundGradient.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(leapQuestBackgroundGradient)
        view.sendSubviewToBack(leapQuestBackgroundGradient)
    }
    
    private func setupLeapQuestFactDetailUI() {
        setupLeapQuestScrollView()
        setupLeapQuestHeaderSection()
        setupLeapQuestContentSection()
        setupLeapQuestReadStatusSection()
    }
    
    private func setupLeapQuestScrollView() {
        leapQuestScrollView = UIScrollView()
        leapQuestScrollView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestScrollView.showsVerticalScrollIndicator = false
        leapQuestScrollView.backgroundColor = .clear
        view.addSubview(leapQuestScrollView)
        
        leapQuestContentView = UIView()
        leapQuestContentView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestContentView.backgroundColor = .clear
        leapQuestScrollView.addSubview(leapQuestContentView)
        
        NSLayoutConstraint.activate([
            leapQuestScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leapQuestScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            leapQuestContentView.topAnchor.constraint(equalTo: leapQuestScrollView.topAnchor),
            leapQuestContentView.leadingAnchor.constraint(equalTo: leapQuestScrollView.leadingAnchor),
            leapQuestContentView.trailingAnchor.constraint(equalTo: leapQuestScrollView.trailingAnchor),
            leapQuestContentView.bottomAnchor.constraint(equalTo: leapQuestScrollView.bottomAnchor),
            leapQuestContentView.widthAnchor.constraint(equalTo: leapQuestScrollView.widthAnchor)
        ])
    }
    
    private func setupLeapQuestHeaderSection() {
        let headerBackgroundView = LeapQuestGlassmorphismView()
        headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestContentView.addSubview(headerBackgroundView)
        
        leapQuestCategoryIconLabel = UILabel()
        leapQuestCategoryIconLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCategoryIconLabel.font = UIFont.systemFont(ofSize: 30)
        leapQuestCategoryIconLabel.textAlignment = .center
        headerBackgroundView.addSubview(leapQuestCategoryIconLabel)
        
        leapQuestFactEmojiLabel = UILabel()
        leapQuestFactEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestFactEmojiLabel.font = UIFont.systemFont(ofSize: 80)
        leapQuestFactEmojiLabel.textAlignment = .center
        headerBackgroundView.addSubview(leapQuestFactEmojiLabel)
        
        leapQuestTitleLabel = UILabel()
        leapQuestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        leapQuestTitleLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestTitleLabel.textAlignment = .center
        leapQuestTitleLabel.numberOfLines = 0
        headerBackgroundView.addSubview(leapQuestTitleLabel)
        
        leapQuestCategoryLabel = UILabel()
        leapQuestCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCategoryLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        leapQuestCategoryLabel.textColor = leapQuestFact.leapQuestCategory.leapQuestColor
        leapQuestCategoryLabel.textAlignment = .center
        headerBackgroundView.addSubview(leapQuestCategoryLabel)
        
        let infoStackView = UIStackView()
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .horizontal
        infoStackView.distribution = .fillEqually
        infoStackView.spacing = 16
        headerBackgroundView.addSubview(infoStackView)
        
        leapQuestDifficultyLabel = UILabel()
        leapQuestDifficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestDifficultyLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        leapQuestDifficultyLabel.textAlignment = .center
        leapQuestDifficultyLabel.layer.cornerRadius = 12
        leapQuestDifficultyLabel.layer.masksToBounds = true
        infoStackView.addArrangedSubview(leapQuestDifficultyLabel)
        
        leapQuestReadTimeLabel = UILabel()
        leapQuestReadTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestReadTimeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        leapQuestReadTimeLabel.textColor = LeapQuestColorTheme.Text.secondary
        leapQuestReadTimeLabel.textAlignment = .center
        infoStackView.addArrangedSubview(leapQuestReadTimeLabel)
        
        NSLayoutConstraint.activate([
            headerBackgroundView.topAnchor.constraint(equalTo: leapQuestContentView.topAnchor, constant: 16),
            headerBackgroundView.leadingAnchor.constraint(equalTo: leapQuestContentView.leadingAnchor, constant: 16),
            headerBackgroundView.trailingAnchor.constraint(equalTo: leapQuestContentView.trailingAnchor, constant: -16),
            
            leapQuestCategoryIconLabel.topAnchor.constraint(equalTo: headerBackgroundView.topAnchor, constant: 20),
            leapQuestCategoryIconLabel.leadingAnchor.constraint(equalTo: headerBackgroundView.leadingAnchor, constant: 20),
            leapQuestCategoryIconLabel.widthAnchor.constraint(equalToConstant: 40),
            leapQuestCategoryIconLabel.heightAnchor.constraint(equalToConstant: 40),
            
            leapQuestFactEmojiLabel.topAnchor.constraint(equalTo: headerBackgroundView.topAnchor, constant: 20),
            leapQuestFactEmojiLabel.centerXAnchor.constraint(equalTo: headerBackgroundView.centerXAnchor),
            
            leapQuestTitleLabel.topAnchor.constraint(equalTo: leapQuestFactEmojiLabel.bottomAnchor, constant: 16),
            leapQuestTitleLabel.leadingAnchor.constraint(equalTo: headerBackgroundView.leadingAnchor, constant: 20),
            leapQuestTitleLabel.trailingAnchor.constraint(equalTo: headerBackgroundView.trailingAnchor, constant: -20),
            
            leapQuestCategoryLabel.topAnchor.constraint(equalTo: leapQuestTitleLabel.bottomAnchor, constant: 8),
            leapQuestCategoryLabel.centerXAnchor.constraint(equalTo: headerBackgroundView.centerXAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: leapQuestCategoryLabel.bottomAnchor, constant: 16),
            infoStackView.leadingAnchor.constraint(equalTo: headerBackgroundView.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: headerBackgroundView.trailingAnchor, constant: -20),
            infoStackView.bottomAnchor.constraint(equalTo: headerBackgroundView.bottomAnchor, constant: -20),
            
            leapQuestDifficultyLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupLeapQuestContentSection() {
        let contentBackgroundView = LeapQuestGlassmorphismView()
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestContentView.addSubview(contentBackgroundView)
        
        leapQuestContentLabel = UILabel()
        leapQuestContentLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestContentLabel.font = UIFont.systemFont(ofSize: 17)
        leapQuestContentLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestContentLabel.numberOfLines = 0
        leapQuestContentLabel.lineBreakMode = .byWordWrapping
        contentBackgroundView.addSubview(leapQuestContentLabel)
        
        NSLayoutConstraint.activate([
            contentBackgroundView.topAnchor.constraint(equalTo: leapQuestCategoryIconLabel.bottomAnchor, constant: 16),
            contentBackgroundView.leadingAnchor.constraint(equalTo: leapQuestContentView.leadingAnchor, constant: 16),
            contentBackgroundView.trailingAnchor.constraint(equalTo: leapQuestContentView.trailingAnchor, constant: -16),
            
            leapQuestContentLabel.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 20),
            leapQuestContentLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 20),
            leapQuestContentLabel.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor, constant: -20),
            leapQuestContentLabel.bottomAnchor.constraint(equalTo: contentBackgroundView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupLeapQuestReadStatusSection() {
        leapQuestReadStatusView = LeapQuestGlassmorphismView()
        leapQuestReadStatusView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestContentView.addSubview(leapQuestReadStatusView)
        
        let readStatusImageView = UIImageView()
        readStatusImageView.translatesAutoresizingMaskIntoConstraints = false
        readStatusImageView.image = UIImage(systemName: "checkmark.circle.fill")
        readStatusImageView.tintColor = LeapQuestColorTheme.Primary.frogGreen
        readStatusImageView.contentMode = .scaleAspectFit
        leapQuestReadStatusView.addSubview(readStatusImageView)
        
        let readStatusLabel = UILabel()
        readStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        readStatusLabel.text = "Fact Read!"
        readStatusLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        readStatusLabel.textColor = LeapQuestColorTheme.Primary.frogGreen
        readStatusLabel.textAlignment = .center
        leapQuestReadStatusView.addSubview(readStatusLabel)
        
        NSLayoutConstraint.activate([
            leapQuestReadStatusView.topAnchor.constraint(equalTo: leapQuestContentLabel.bottomAnchor, constant: 16),
            leapQuestReadStatusView.leadingAnchor.constraint(equalTo: leapQuestContentView.leadingAnchor, constant: 16),
            leapQuestReadStatusView.trailingAnchor.constraint(equalTo: leapQuestContentView.trailingAnchor, constant: -16),
            leapQuestReadStatusView.bottomAnchor.constraint(equalTo: leapQuestContentView.bottomAnchor, constant: -16),
            
            readStatusImageView.topAnchor.constraint(equalTo: leapQuestReadStatusView.topAnchor, constant: 16),
            readStatusImageView.centerXAnchor.constraint(equalTo: leapQuestReadStatusView.centerXAnchor),
            readStatusImageView.widthAnchor.constraint(equalToConstant: 30),
            readStatusImageView.heightAnchor.constraint(equalToConstant: 30),
            
            readStatusLabel.topAnchor.constraint(equalTo: readStatusImageView.bottomAnchor, constant: 8),
            readStatusLabel.leadingAnchor.constraint(equalTo: leapQuestReadStatusView.leadingAnchor, constant: 16),
            readStatusLabel.trailingAnchor.constraint(equalTo: leapQuestReadStatusView.trailingAnchor, constant: -16),
            readStatusLabel.bottomAnchor.constraint(equalTo: leapQuestReadStatusView.bottomAnchor, constant: -16)
        ])
    }
    
    private func markLeapQuestFactAsRead() {
        leapQuestFact.leapQuestIsRead = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureLeapQuestFactDetail()
    }
    
    private func configureLeapQuestFactDetail() {
        leapQuestCategoryIconLabel.text = leapQuestFact.leapQuestCategory.leapQuestEmoji
        leapQuestFactEmojiLabel.text = leapQuestFact.leapQuestImageEmoji
        leapQuestTitleLabel.text = leapQuestFact.leapQuestTitle
        leapQuestCategoryLabel.text = leapQuestFact.leapQuestCategory.rawValue
        leapQuestReadTimeLabel.text = "\(leapQuestFact.leapQuestReadTime) min read"
        
        leapQuestDifficultyLabel.text = leapQuestFact.leapQuestDifficulty.rawValue.capitalized
        switch leapQuestFact.leapQuestDifficulty {
        case .easy:
            leapQuestDifficultyLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
            leapQuestDifficultyLabel.textColor = .systemGreen
        case .medium:
            leapQuestDifficultyLabel.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.2)
            leapQuestDifficultyLabel.textColor = .systemOrange
        case .hard:
            leapQuestDifficultyLabel.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
            leapQuestDifficultyLabel.textColor = .systemRed
        case .expert:
            leapQuestDifficultyLabel.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.2)
            leapQuestDifficultyLabel.textColor = .systemPurple
        }
        
        leapQuestContentLabel.text = leapQuestFact.leapQuestFullContent
        
        leapQuestReadStatusView.isHidden = !leapQuestFact.leapQuestIsRead
        
        if leapQuestFact.leapQuestIsRead {
            LeapQuestHapticFeedbackManager.shared.leapQuestSuccessFeedback()
        }
    }
}
