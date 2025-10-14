import UIKit

class LeapQuestFactTableViewCell: UITableViewCell {
    
    static let leapQuestReuseIdentifier = "LeapQuestFactCell"
    
    private let leapQuestBackgroundView = LeapQuestGlassmorphismView()
    private let leapQuestCategoryIconLabel = UILabel()
    private let leapQuestFactEmojiLabel = UILabel()
    private let leapQuestTitleLabel = UILabel()
    private let leapQuestDescriptionLabel = UILabel()
    private let leapQuestReadIndicatorView = UIView()
    private let leapQuestDifficultyLabel = UILabel()
    private let leapQuestReadTimeLabel = UILabel()
    private let leapQuestReadStatusImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLeapQuestCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLeapQuestCellUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(leapQuestBackgroundView)
        leapQuestBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestBackgroundView.addSubview(leapQuestCategoryIconLabel)
        leapQuestBackgroundView.addSubview(leapQuestFactEmojiLabel)
        leapQuestBackgroundView.addSubview(leapQuestTitleLabel)
        leapQuestBackgroundView.addSubview(leapQuestDescriptionLabel)
        leapQuestBackgroundView.addSubview(leapQuestReadIndicatorView)
        leapQuestBackgroundView.addSubview(leapQuestDifficultyLabel)
        leapQuestBackgroundView.addSubview(leapQuestReadTimeLabel)
        leapQuestBackgroundView.addSubview(leapQuestReadStatusImageView)
        
        leapQuestCategoryIconLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestFactEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestReadIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestDifficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestReadTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestReadStatusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestCategoryIconLabel.font = UIFont.systemFont(ofSize: 24)
        leapQuestCategoryIconLabel.textAlignment = .center
        
        leapQuestFactEmojiLabel.font = UIFont.systemFont(ofSize: 40)
        leapQuestFactEmojiLabel.textAlignment = .center
        
        leapQuestTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        leapQuestTitleLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestTitleLabel.numberOfLines = 2
        
        leapQuestDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        leapQuestDescriptionLabel.textColor = LeapQuestColorTheme.Text.secondary
        leapQuestDescriptionLabel.numberOfLines = 3
        
        leapQuestReadIndicatorView.backgroundColor = LeapQuestColorTheme.Primary.waterBlue
        leapQuestReadIndicatorView.layer.cornerRadius = 4
        leapQuestReadIndicatorView.isHidden = true
        
        leapQuestDifficultyLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        leapQuestDifficultyLabel.layer.cornerRadius = 8
        leapQuestDifficultyLabel.layer.masksToBounds = true
        leapQuestDifficultyLabel.textAlignment = .center
        
        leapQuestReadTimeLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        leapQuestReadTimeLabel.textColor = LeapQuestColorTheme.Text.secondary
        
        leapQuestReadStatusImageView.image = UIImage(systemName: "checkmark.circle.fill")
        leapQuestReadStatusImageView.tintColor = LeapQuestColorTheme.Primary.frogGreen
        leapQuestReadStatusImageView.contentMode = .scaleAspectFit
        leapQuestReadStatusImageView.isHidden = true
        
        NSLayoutConstraint.activate([
            leapQuestBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            leapQuestBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leapQuestBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            leapQuestBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            leapQuestCategoryIconLabel.topAnchor.constraint(equalTo: leapQuestBackgroundView.topAnchor, constant: 16),
            leapQuestCategoryIconLabel.leadingAnchor.constraint(equalTo: leapQuestBackgroundView.leadingAnchor, constant: 16),
            leapQuestCategoryIconLabel.widthAnchor.constraint(equalToConstant: 30),
            leapQuestCategoryIconLabel.heightAnchor.constraint(equalToConstant: 30),
            
            leapQuestFactEmojiLabel.centerXAnchor.constraint(equalTo: leapQuestBackgroundView.centerXAnchor),
            leapQuestFactEmojiLabel.topAnchor.constraint(equalTo: leapQuestBackgroundView.topAnchor, constant: 16),
            
            leapQuestTitleLabel.topAnchor.constraint(equalTo: leapQuestFactEmojiLabel.bottomAnchor, constant: 12),
            leapQuestTitleLabel.leadingAnchor.constraint(equalTo: leapQuestBackgroundView.leadingAnchor, constant: 16),
            leapQuestTitleLabel.trailingAnchor.constraint(equalTo: leapQuestReadStatusImageView.leadingAnchor, constant: -8),
            
            leapQuestDescriptionLabel.topAnchor.constraint(equalTo: leapQuestTitleLabel.bottomAnchor, constant: 8),
            leapQuestDescriptionLabel.leadingAnchor.constraint(equalTo: leapQuestBackgroundView.leadingAnchor, constant: 16),
            leapQuestDescriptionLabel.trailingAnchor.constraint(equalTo: leapQuestBackgroundView.trailingAnchor, constant: -16),
            
            leapQuestReadIndicatorView.topAnchor.constraint(equalTo: leapQuestDescriptionLabel.bottomAnchor, constant: 12),
            leapQuestReadIndicatorView.leadingAnchor.constraint(equalTo: leapQuestBackgroundView.leadingAnchor, constant: 16),
            leapQuestReadIndicatorView.widthAnchor.constraint(equalToConstant: 8),
            leapQuestReadIndicatorView.heightAnchor.constraint(equalToConstant: 8),
            
            leapQuestDifficultyLabel.centerYAnchor.constraint(equalTo: leapQuestReadIndicatorView.centerYAnchor),
            leapQuestDifficultyLabel.leadingAnchor.constraint(equalTo: leapQuestReadIndicatorView.trailingAnchor, constant: 8),
            leapQuestDifficultyLabel.widthAnchor.constraint(equalToConstant: 60),
            leapQuestDifficultyLabel.heightAnchor.constraint(equalToConstant: 20),
            
            leapQuestReadTimeLabel.centerYAnchor.constraint(equalTo: leapQuestReadIndicatorView.centerYAnchor),
            leapQuestReadTimeLabel.leadingAnchor.constraint(equalTo: leapQuestDifficultyLabel.trailingAnchor, constant: 8),
            
            leapQuestReadStatusImageView.centerYAnchor.constraint(equalTo: leapQuestTitleLabel.centerYAnchor),
            leapQuestReadStatusImageView.trailingAnchor.constraint(equalTo: leapQuestBackgroundView.trailingAnchor, constant: -16),
            leapQuestReadStatusImageView.widthAnchor.constraint(equalToConstant: 24),
            leapQuestReadStatusImageView.heightAnchor.constraint(equalToConstant: 24),
            
            leapQuestBackgroundView.heightAnchor.constraint(greaterThanOrEqualToConstant: 160)
        ])
    }
    
    func leapQuestConfigure(with fact: LeapQuestFact) {
        leapQuestCategoryIconLabel.text = fact.leapQuestCategory.leapQuestEmoji
        leapQuestFactEmojiLabel.text = fact.leapQuestImageEmoji
        leapQuestTitleLabel.text = fact.leapQuestTitle
        leapQuestDescriptionLabel.text = fact.leapQuestShortDescription
        leapQuestReadTimeLabel.text = "\(fact.leapQuestReadTime) min read"
        
        leapQuestDifficultyLabel.text = fact.leapQuestDifficulty.rawValue.capitalized
        switch fact.leapQuestDifficulty {
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
        
        leapQuestReadStatusImageView.isHidden = !fact.leapQuestIsRead
        leapQuestReadIndicatorView.isHidden = !fact.leapQuestIsRead
        
        if fact.leapQuestIsRead {
            leapQuestBackgroundView.layer.borderColor = LeapQuestColorTheme.Primary.frogGreen.cgColor
            leapQuestBackgroundView.layer.borderWidth = 2
            leapQuestBackgroundView.alpha = 0.8
        } else {
            leapQuestBackgroundView.layer.borderColor = UIColor.clear.cgColor
            leapQuestBackgroundView.layer.borderWidth = 0
            leapQuestBackgroundView.alpha = 1.0
        }
    }
}
