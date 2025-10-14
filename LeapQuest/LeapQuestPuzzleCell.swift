import UIKit

class LeapQuestPuzzleCell: UICollectionViewCell {
    
    static let identifier = "LeapQuestPuzzleCell"
    
    private var leapQuestEmojiLabel: UILabel!
    private var leapQuestTitleLabel: UILabel!
    private var leapQuestDescriptionLabel: UILabel!
    private var leapQuestDifficultyLabel: UILabel!
    private var leapQuestCardView: UIView!
    private var leapQuestStatusIndicator: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLeapQuestPuzzleCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLeapQuestPuzzleCell()
    }
    
    private func setupLeapQuestPuzzleCell() {
        backgroundColor = .clear
        
        setupLeapQuestCardView()
        setupLeapQuestEmojiLabel()
        setupLeapQuestTitleLabel()
        setupLeapQuestDescriptionLabel()
        setupLeapQuestDifficultyLabel()
        setupLeapQuestStatusIndicator()
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
        leapQuestEmojiLabel.font = UIFont.systemFont(ofSize: 40)
        leapQuestEmojiLabel.textAlignment = .center
        leapQuestEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCardView.addSubview(leapQuestEmojiLabel)
    }
    
    private func setupLeapQuestTitleLabel() {
        leapQuestTitleLabel = UILabel()
        leapQuestTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        leapQuestTitleLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestTitleLabel.textAlignment = .center
        leapQuestTitleLabel.numberOfLines = 1
        leapQuestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCardView.addSubview(leapQuestTitleLabel)
    }
    
    private func setupLeapQuestDescriptionLabel() {
        leapQuestDescriptionLabel = UILabel()
        leapQuestDescriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        leapQuestDescriptionLabel.textColor = LeapQuestColorTheme.Text.secondary
        leapQuestDescriptionLabel.textAlignment = .center
        leapQuestDescriptionLabel.numberOfLines = 2
        leapQuestDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCardView.addSubview(leapQuestDescriptionLabel)
    }
    
    private func setupLeapQuestDifficultyLabel() {
        leapQuestDifficultyLabel = UILabel()
        leapQuestDifficultyLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        leapQuestDifficultyLabel.textAlignment = .center
        leapQuestDifficultyLabel.layer.cornerRadius = 8
        leapQuestDifficultyLabel.layer.masksToBounds = true
        leapQuestDifficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCardView.addSubview(leapQuestDifficultyLabel)
    }
    
    private func setupLeapQuestStatusIndicator() {
        leapQuestStatusIndicator = UIView()
        leapQuestStatusIndicator.backgroundColor = LeapQuestColorTheme.Primary.waterBlue
        leapQuestStatusIndicator.layer.cornerRadius = 6
        leapQuestStatusIndicator.translatesAutoresizingMaskIntoConstraints = false
        leapQuestCardView.addSubview(leapQuestStatusIndicator)
    }
    
    private func setupLeapQuestConstraints() {
        NSLayoutConstraint.activate([
            // Card View
            leapQuestCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            leapQuestCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leapQuestCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            leapQuestCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Status Indicator
            leapQuestStatusIndicator.topAnchor.constraint(equalTo: leapQuestCardView.topAnchor, constant: 8),
            leapQuestStatusIndicator.trailingAnchor.constraint(equalTo: leapQuestCardView.trailingAnchor, constant: -8),
            leapQuestStatusIndicator.widthAnchor.constraint(equalToConstant: 12),
            leapQuestStatusIndicator.heightAnchor.constraint(equalToConstant: 12),
            
            // Emoji Label
            leapQuestEmojiLabel.topAnchor.constraint(equalTo: leapQuestCardView.topAnchor, constant: 20),
            leapQuestEmojiLabel.centerXAnchor.constraint(equalTo: leapQuestCardView.centerXAnchor),
            
            // Title Label
            leapQuestTitleLabel.topAnchor.constraint(equalTo: leapQuestEmojiLabel.bottomAnchor, constant: 8),
            leapQuestTitleLabel.leadingAnchor.constraint(equalTo: leapQuestCardView.leadingAnchor, constant: 12),
            leapQuestTitleLabel.trailingAnchor.constraint(equalTo: leapQuestCardView.trailingAnchor, constant: -12),
            
            // Description Label
            leapQuestDescriptionLabel.topAnchor.constraint(equalTo: leapQuestTitleLabel.bottomAnchor, constant: 4),
            leapQuestDescriptionLabel.leadingAnchor.constraint(equalTo: leapQuestCardView.leadingAnchor, constant: 12),
            leapQuestDescriptionLabel.trailingAnchor.constraint(equalTo: leapQuestCardView.trailingAnchor, constant: -12),
            
            // Difficulty Label
            leapQuestDifficultyLabel.topAnchor.constraint(equalTo: leapQuestDescriptionLabel.bottomAnchor, constant: 8),
            leapQuestDifficultyLabel.centerXAnchor.constraint(equalTo: leapQuestCardView.centerXAnchor),
            leapQuestDifficultyLabel.widthAnchor.constraint(equalToConstant: 60),
            leapQuestDifficultyLabel.heightAnchor.constraint(equalToConstant: 20),
            leapQuestDifficultyLabel.bottomAnchor.constraint(lessThanOrEqualTo: leapQuestCardView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with puzzleType: LeapQuestPuzzleType) {
        leapQuestEmojiLabel.text = puzzleType.leapQuestEmoji
        leapQuestTitleLabel.text = puzzleType.rawValue
        leapQuestDescriptionLabel.text = puzzleType.leapQuestDescription
        
        let difficulty = puzzleType.leapQuestDifficulty
        leapQuestDifficultyLabel.text = difficulty.rawValue
        
        switch difficulty {
        case .easy:
            leapQuestDifficultyLabel.backgroundColor = UIColor.systemGreen
            leapQuestDifficultyLabel.textColor = UIColor.white
        case .medium:
            leapQuestDifficultyLabel.backgroundColor = UIColor.systemOrange
            leapQuestDifficultyLabel.textColor = UIColor.white
        case .hard:
            leapQuestDifficultyLabel.backgroundColor = UIColor.systemRed
            leapQuestDifficultyLabel.textColor = UIColor.white
        case .expert:
            leapQuestDifficultyLabel.backgroundColor = UIColor.systemPurple
            leapQuestDifficultyLabel.textColor = UIColor.white
        }
        
        leapQuestStatusIndicator.backgroundColor = LeapQuestColorTheme.Primary.waterBlue
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leapQuestEmojiLabel.text = nil
        leapQuestTitleLabel.text = nil
        leapQuestDescriptionLabel.text = nil
        leapQuestDifficultyLabel.text = nil
    }
}
