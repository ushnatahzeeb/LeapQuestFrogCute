import UIKit

class LeapQuestAchievementCell: UITableViewCell {
    
    static let identifier = "LeapQuestAchievementCell"
    
    private var leapQuestEmojiLabel: UILabel!
    private var leapQuestTitleLabel: UILabel!
    private var leapQuestDescriptionLabel: UILabel!
    private var leapQuestProgressBar: UIProgressView!
    private var leapQuestProgressLabel: UILabel!
    private var leapQuestCompletionImageView: UIImageView!
    private var leapQuestCardView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLeapQuestAchievementCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLeapQuestAchievementCell()
    }
    
    private func setupLeapQuestAchievementCell() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupLeapQuestCardView()
        setupLeapQuestEmojiLabel()
        setupLeapQuestTitleLabel()
        setupLeapQuestDescriptionLabel()
        setupLeapQuestProgressBar()
        setupLeapQuestProgressLabel()
        setupLeapQuestCompletionImageView()
        setupLeapQuestConstraints()
    }
    
    private func setupLeapQuestCardView() {
        leapQuestCardView = UIView()
        leapQuestCardView.backgroundColor = LeapQuestColorTheme.Background.card
        leapQuestCardView.layer.cornerRadius = 16
        leapQuestCardView.layer.shadowColor = LeapQuestColorTheme.Shadow.primary.cgColor
        leapQuestCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        leapQuestCardView.layer.shadowRadius = 8
        leapQuestCardView.layer.shadowOpacity = 0.1
        leapQuestCardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(leapQuestCardView)
    }
    
    private func setupLeapQuestEmojiLabel() {
        leapQuestEmojiLabel = UILabel()
        leapQuestEmojiLabel.font = UIFont.systemFont(ofSize: 32)
        leapQuestEmojiLabel.textAlignment = .center
        leapQuestEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCardView.addSubview(leapQuestEmojiLabel)
    }
    
    private func setupLeapQuestTitleLabel() {
        leapQuestTitleLabel = UILabel()
        leapQuestTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        leapQuestTitleLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCardView.addSubview(leapQuestTitleLabel)
    }
    
    private func setupLeapQuestDescriptionLabel() {
        leapQuestDescriptionLabel = UILabel()
        leapQuestDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        leapQuestDescriptionLabel.textColor = LeapQuestColorTheme.Text.secondary
        leapQuestDescriptionLabel.numberOfLines = 2
        leapQuestDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCardView.addSubview(leapQuestDescriptionLabel)
    }
    
    private func setupLeapQuestProgressBar() {
        leapQuestProgressBar = UIProgressView(progressViewStyle: .default)
        leapQuestProgressBar.progressTintColor = LeapQuestColorTheme.Primary.frogGreen
        leapQuestProgressBar.trackTintColor = LeapQuestColorTheme.Text.secondary
        leapQuestProgressBar.layer.cornerRadius = 4
        leapQuestProgressBar.clipsToBounds = true
        leapQuestProgressBar.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCardView.addSubview(leapQuestProgressBar)
    }
    
    private func setupLeapQuestProgressLabel() {
        leapQuestProgressLabel = UILabel()
        leapQuestProgressLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        leapQuestProgressLabel.textColor = LeapQuestColorTheme.Primary.frogGreen
        leapQuestProgressLabel.textAlignment = .right
        leapQuestProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCardView.addSubview(leapQuestProgressLabel)
    }
    
    private func setupLeapQuestCompletionImageView() {
        leapQuestCompletionImageView = UIImageView()
        leapQuestCompletionImageView.image = UIImage(systemName: "checkmark.circle.fill")
        leapQuestCompletionImageView.tintColor = LeapQuestColorTheme.Primary.frogGreen
        leapQuestCompletionImageView.contentMode = .scaleAspectFit
        leapQuestCompletionImageView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCompletionImageView.isHidden = true
        leapQuestCardView.addSubview(leapQuestCompletionImageView)
    }
    
    private func setupLeapQuestConstraints() {
        NSLayoutConstraint.activate([
            // Card View
            leapQuestCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            leapQuestCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leapQuestCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            leapQuestCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            leapQuestCardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            // Emoji Label
            leapQuestEmojiLabel.topAnchor.constraint(equalTo: leapQuestCardView.topAnchor, constant: 16),
            leapQuestEmojiLabel.leadingAnchor.constraint(equalTo: leapQuestCardView.leadingAnchor, constant: 16),
            leapQuestEmojiLabel.widthAnchor.constraint(equalToConstant: 50),
            leapQuestEmojiLabel.heightAnchor.constraint(equalToConstant: 50),
            
            // Title Label
            leapQuestTitleLabel.topAnchor.constraint(equalTo: leapQuestCardView.topAnchor, constant: 16),
            leapQuestTitleLabel.leadingAnchor.constraint(equalTo: leapQuestEmojiLabel.trailingAnchor, constant: 12),
            leapQuestTitleLabel.trailingAnchor.constraint(equalTo: leapQuestCompletionImageView.leadingAnchor, constant: -8),
            
            // Description Label
            leapQuestDescriptionLabel.topAnchor.constraint(equalTo: leapQuestTitleLabel.bottomAnchor, constant: 4),
            leapQuestDescriptionLabel.leadingAnchor.constraint(equalTo: leapQuestEmojiLabel.trailingAnchor, constant: 12),
            leapQuestDescriptionLabel.trailingAnchor.constraint(equalTo: leapQuestCompletionImageView.leadingAnchor, constant: -8),
            
            // Progress Bar
            leapQuestProgressBar.topAnchor.constraint(equalTo: leapQuestDescriptionLabel.bottomAnchor, constant: 12),
            leapQuestProgressBar.leadingAnchor.constraint(equalTo: leapQuestEmojiLabel.trailingAnchor, constant: 12),
            leapQuestProgressBar.trailingAnchor.constraint(equalTo: leapQuestCompletionImageView.leadingAnchor, constant: -8),
            leapQuestProgressBar.heightAnchor.constraint(equalToConstant: 8),
            
            // Progress Label
            leapQuestProgressLabel.topAnchor.constraint(equalTo: leapQuestProgressBar.bottomAnchor, constant: 4),
            leapQuestProgressLabel.leadingAnchor.constraint(equalTo: leapQuestEmojiLabel.trailingAnchor, constant: 12),
            leapQuestProgressLabel.trailingAnchor.constraint(equalTo: leapQuestCompletionImageView.leadingAnchor, constant: -8),
            leapQuestProgressLabel.bottomAnchor.constraint(lessThanOrEqualTo: leapQuestCardView.bottomAnchor, constant: -16),
            
            // Completion Image View
            leapQuestCompletionImageView.centerYAnchor.constraint(equalTo: leapQuestCardView.centerYAnchor),
            leapQuestCompletionImageView.trailingAnchor.constraint(equalTo: leapQuestCardView.trailingAnchor, constant: -16),
            leapQuestCompletionImageView.widthAnchor.constraint(equalToConstant: 24),
            leapQuestCompletionImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with achievement: LeapQuestAchievement) {
        leapQuestEmojiLabel.text = achievement.leapQuestType.leapQuestEmoji
        leapQuestTitleLabel.text = achievement.leapQuestType.rawValue
        leapQuestDescriptionLabel.text = achievement.leapQuestType.leapQuestDescription
        
        let progress = achievement.leapQuestProgressPercentage
        leapQuestProgressBar.setProgress(progress, animated: false)
        
        let currentProgress = achievement.leapQuestCurrentProgress
        let targetProgress = achievement.leapQuestType.leapQuestTargetValue
        leapQuestProgressLabel.text = "\(currentProgress)/\(targetProgress)"
        
        leapQuestCompletionImageView.isHidden = !achievement.leapQuestIsCompleted
        
        if achievement.leapQuestIsCompleted {
            leapQuestProgressBar.progressTintColor = LeapQuestColorTheme.Primary.frogGreen
            leapQuestProgressLabel.textColor = LeapQuestColorTheme.Primary.frogGreen
            leapQuestTitleLabel.textColor = LeapQuestColorTheme.Primary.frogGreen
        } else {
            leapQuestProgressBar.progressTintColor = LeapQuestColorTheme.Primary.waterBlue
            leapQuestProgressLabel.textColor = LeapQuestColorTheme.Primary.waterBlue
            leapQuestTitleLabel.textColor = LeapQuestColorTheme.Text.primary
        }
    }
}
