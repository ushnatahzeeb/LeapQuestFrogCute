import UIKit

class LeapQuestShopUpgradeCell: UICollectionViewCell {
    
    private var leapQuestUpgrade: LeapQuestShopUpgrade?
    private var leapQuestPurchaseAction: (() -> Void)?
    
    private let leapQuestGlassView = LeapQuestGlassmorphismView()
    private let leapQuestEmojiLabel = UILabel()
    private let leapQuestNameLabel = UILabel()
    private let leapQuestDescriptionLabel = UILabel()
    private let leapQuestOwnedLabel = UILabel()
    private let leapQuestCostLabel = UILabel()
    private let leapQuestIncomeLabel = UILabel()
    private let leapQuestPurchaseButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLeapQuestUpgradeCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLeapQuestUpgradeCell()
    }
    
    private func setupLeapQuestUpgradeCell() {
        contentView.addSubview(leapQuestGlassView)
        
        leapQuestEmojiLabel.font = UIFont.systemFont(ofSize: 40)
        leapQuestEmojiLabel.textAlignment = .center
        leapQuestEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        leapQuestNameLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestNameLabel.textAlignment = .center
        leapQuestNameLabel.numberOfLines = 1
        leapQuestNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestDescriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        leapQuestDescriptionLabel.textColor = LeapQuestColorTheme.Text.secondary
        leapQuestDescriptionLabel.textAlignment = .center
        leapQuestDescriptionLabel.numberOfLines = 2
        leapQuestDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestOwnedLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        leapQuestOwnedLabel.textColor = LeapQuestColorTheme.Primary.frogGreen
        leapQuestOwnedLabel.textAlignment = .center
        leapQuestOwnedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestCostLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        leapQuestCostLabel.textColor = LeapQuestColorTheme.Text.accent
        leapQuestCostLabel.textAlignment = .center
        leapQuestCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestIncomeLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        leapQuestIncomeLabel.textColor = LeapQuestColorTheme.Primary.waterBlue
        leapQuestIncomeLabel.textAlignment = .center
        leapQuestIncomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestPurchaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        leapQuestPurchaseButton.setTitleColor(LeapQuestColorTheme.Text.primary, for: .normal)
        leapQuestPurchaseButton.layer.cornerRadius = 15
        leapQuestPurchaseButton.layer.shadowColor = LeapQuestColorTheme.Shadow.primary.cgColor
        leapQuestPurchaseButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        leapQuestPurchaseButton.layer.shadowRadius = 4
        leapQuestPurchaseButton.layer.shadowOpacity = 0.3
        leapQuestPurchaseButton.translatesAutoresizingMaskIntoConstraints = false
        leapQuestPurchaseButton.addTarget(self, action: #selector(leapQuestPurchaseButtonTapped), for: .touchUpInside)
        
        leapQuestGlassView.addSubview(leapQuestEmojiLabel)
        leapQuestGlassView.addSubview(leapQuestNameLabel)
        leapQuestGlassView.addSubview(leapQuestDescriptionLabel)
        leapQuestGlassView.addSubview(leapQuestOwnedLabel)
        leapQuestGlassView.addSubview(leapQuestCostLabel)
        leapQuestGlassView.addSubview(leapQuestIncomeLabel)
        leapQuestGlassView.addSubview(leapQuestPurchaseButton)
        
        setupLeapQuestConstraints()
    }
    
    private func setupLeapQuestConstraints() {
        leapQuestGlassView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leapQuestGlassView.topAnchor.constraint(equalTo: contentView.topAnchor),
            leapQuestGlassView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leapQuestGlassView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            leapQuestGlassView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            leapQuestEmojiLabel.topAnchor.constraint(equalTo: leapQuestGlassView.topAnchor, constant: 10),
            leapQuestEmojiLabel.centerXAnchor.constraint(equalTo: leapQuestGlassView.centerXAnchor),
            
            leapQuestNameLabel.topAnchor.constraint(equalTo: leapQuestEmojiLabel.bottomAnchor, constant: 5),
            leapQuestNameLabel.leadingAnchor.constraint(equalTo: leapQuestGlassView.leadingAnchor, constant: 8),
            leapQuestNameLabel.trailingAnchor.constraint(equalTo: leapQuestGlassView.trailingAnchor, constant: -8),
            
            leapQuestDescriptionLabel.topAnchor.constraint(equalTo: leapQuestNameLabel.bottomAnchor, constant: 4),
            leapQuestDescriptionLabel.leadingAnchor.constraint(equalTo: leapQuestGlassView.leadingAnchor, constant: 8),
            leapQuestDescriptionLabel.trailingAnchor.constraint(equalTo: leapQuestGlassView.trailingAnchor, constant: -8),
            
            leapQuestOwnedLabel.topAnchor.constraint(equalTo: leapQuestDescriptionLabel.bottomAnchor, constant: 4),
            leapQuestOwnedLabel.leadingAnchor.constraint(equalTo: leapQuestGlassView.leadingAnchor, constant: 8),
            leapQuestOwnedLabel.trailingAnchor.constraint(equalTo: leapQuestGlassView.trailingAnchor, constant: -8),
            
            leapQuestCostLabel.topAnchor.constraint(equalTo: leapQuestOwnedLabel.bottomAnchor, constant: 4),
            leapQuestCostLabel.leadingAnchor.constraint(equalTo: leapQuestGlassView.leadingAnchor, constant: 8),
            leapQuestCostLabel.trailingAnchor.constraint(equalTo: leapQuestGlassView.trailingAnchor, constant: -8),
            
            leapQuestIncomeLabel.topAnchor.constraint(equalTo: leapQuestCostLabel.bottomAnchor, constant: 4),
            leapQuestIncomeLabel.leadingAnchor.constraint(equalTo: leapQuestGlassView.leadingAnchor, constant: 8),
            leapQuestIncomeLabel.trailingAnchor.constraint(equalTo: leapQuestGlassView.trailingAnchor, constant: -8),
            
            leapQuestPurchaseButton.topAnchor.constraint(equalTo: leapQuestIncomeLabel.bottomAnchor, constant: 8),
            leapQuestPurchaseButton.leadingAnchor.constraint(equalTo: leapQuestGlassView.leadingAnchor, constant: 12),
            leapQuestPurchaseButton.trailingAnchor.constraint(equalTo: leapQuestGlassView.trailingAnchor, constant: -12),
            leapQuestPurchaseButton.heightAnchor.constraint(equalToConstant: 30),
            leapQuestPurchaseButton.bottomAnchor.constraint(lessThanOrEqualTo: leapQuestGlassView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with upgrade: LeapQuestShopUpgrade, currentCoins: Int, purchaseAction: @escaping () -> Void) {
        leapQuestUpgrade = upgrade
        leapQuestPurchaseAction = purchaseAction
        
        leapQuestEmojiLabel.text = upgrade.leapQuestUpgradeType.leapQuestEmoji
        leapQuestNameLabel.text = upgrade.leapQuestUpgradeType.leapQuestDisplayName
        leapQuestDescriptionLabel.text = upgrade.leapQuestUpgradeType.leapQuestDescription
        leapQuestOwnedLabel.text = "Owned: \(upgrade.leapQuestOwned)"
        leapQuestCostLabel.text = "💰 \(formatLeapQuestNumber(upgrade.leapQuestCurrentCost))"
        leapQuestIncomeLabel.text = "+\(formatLeapQuestNumber(upgrade.leapQuestTotalIncome))/min"
        
        let leapQuestCanAfford = currentCoins >= upgrade.leapQuestCurrentCost
        
        if leapQuestCanAfford {
            leapQuestPurchaseButton.setTitle("BUY", for: .normal)
            leapQuestPurchaseButton.backgroundColor = LeapQuestColorTheme.Primary.frogGreen
            leapQuestPurchaseButton.isEnabled = true
        } else {
            leapQuestPurchaseButton.setTitle("NOT ENOUGH", for: .normal)
            leapQuestPurchaseButton.backgroundColor = UIColor.systemRed
            leapQuestPurchaseButton.isEnabled = false
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
    
    @objc private func leapQuestPurchaseButtonTapped() {
        leapQuestPurchaseAction?()
        
        let leapQuestButtonAnimation = CABasicAnimation(keyPath: "transform.scale")
        leapQuestButtonAnimation.fromValue = 1.0
        leapQuestButtonAnimation.toValue = 0.95
        leapQuestButtonAnimation.duration = 0.1
        leapQuestButtonAnimation.autoreverses = true
        leapQuestPurchaseButton.layer.add(leapQuestButtonAnimation, forKey: "buttonPress")
    }
}

