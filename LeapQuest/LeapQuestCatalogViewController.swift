import UIKit

class LeapQuestCatalogViewController: UIViewController {
    
    private var leapQuestCatalogViewModel: LeapQuestCatalogViewModel!
    private var leapQuestCatalogSegmentedControl: UISegmentedControl!
    private var leapQuestCatalogCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestCatalogViewController()
        setupLeapQuestCatalogViewModel()
        setupLeapQuestCatalogUI()
    }
    
    private func setupLeapQuestCatalogViewController() {
        title = "📖 Catalog"
        view.backgroundColor = LeapQuestColorTheme.Background.primary
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = LeapQuestColorTheme.Text.primary
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
    }
    
    private func setupLeapQuestCatalogViewModel() {
        leapQuestCatalogViewModel = LeapQuestCatalogViewModel()
        leapQuestCatalogViewModel.leapQuestCatalogDelegate = self
    }
    
    private func setupLeapQuestCatalogUI() {
        setupLeapQuestCatalogSegmentedControl()
        setupLeapQuestCatalogCollectionView()
    }
    
    private func setupLeapQuestCatalogSegmentedControl() {
        leapQuestCatalogSegmentedControl = UISegmentedControl(items: ["Platforms", "Puzzles", "Achievements", "Facts"])
        leapQuestCatalogSegmentedControl.selectedSegmentIndex = 0
        leapQuestCatalogSegmentedControl.addTarget(self, action: #selector(leapQuestCatalogSegmentedControlChanged), for: .valueChanged)
        leapQuestCatalogSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leapQuestCatalogSegmentedControl)
        
        NSLayoutConstraint.activate([
            leapQuestCatalogSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            leapQuestCatalogSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            leapQuestCatalogSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            leapQuestCatalogSegmentedControl.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupLeapQuestCatalogCollectionView() {
        let leapQuestLayout = UICollectionViewFlowLayout()
        leapQuestLayout.scrollDirection = .vertical
        leapQuestLayout.minimumLineSpacing = 16
        leapQuestLayout.minimumInteritemSpacing = 16
        leapQuestLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        leapQuestCatalogCollectionView = UICollectionView(frame: .zero, collectionViewLayout: leapQuestLayout)
        leapQuestCatalogCollectionView.delegate = self
        leapQuestCatalogCollectionView.dataSource = self
        leapQuestCatalogCollectionView.register(LeapQuestCatalogCollectionViewCell.self, forCellWithReuseIdentifier: "LeapQuestCatalogCell")
        leapQuestCatalogCollectionView.backgroundColor = LeapQuestColorTheme.Background.primary
        leapQuestCatalogCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leapQuestCatalogCollectionView)
        
        NSLayoutConstraint.activate([
            leapQuestCatalogCollectionView.topAnchor.constraint(equalTo: leapQuestCatalogSegmentedControl.bottomAnchor, constant: 16),
            leapQuestCatalogCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestCatalogCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestCatalogCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func leapQuestCatalogSegmentedControlChanged() {
        leapQuestCatalogViewModel.leapQuestCatalogChangeCategory(leapQuestCatalogSegmentedControl.selectedSegmentIndex)
    }
}

extension LeapQuestCatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leapQuestCatalogViewModel.leapQuestCatalogCurrentItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeapQuestCatalogCell", for: indexPath) as! LeapQuestCatalogCollectionViewCell
        let item = leapQuestCatalogViewModel.leapQuestCatalogCurrentItems[indexPath.item]
        cell.configureLeapQuestCatalogItem(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leapQuestCellWidth = (collectionView.frame.width - 48) / 2
        return CGSize(width: leapQuestCellWidth, height: leapQuestCellWidth * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = leapQuestCatalogViewModel.leapQuestCatalogCurrentItems[indexPath.item]
        
        if item.leapQuestCatalogItemCategory == .facts {
            if let fact = LeapQuestFactData.leapQuestFacts.first(where: { $0.id.uuidString == item.leapQuestCatalogItemId }) {
                let factDetailVC = LeapQuestFactDetailViewController(fact: fact)
                navigationController?.pushViewController(factDetailVC, animated: true)
            }
        } else {
            leapQuestCatalogViewModel.leapQuestCatalogSelectItem(item.leapQuestCatalogItemId)
        }
    }
}

extension LeapQuestCatalogViewController: LeapQuestCatalogViewModelDelegate {
    func leapQuestCatalogViewModelDidUpdate() {
        DispatchQueue.main.async {
            self.leapQuestCatalogCollectionView.reloadData()
        }
    }
}

class LeapQuestCatalogCollectionViewCell: UICollectionViewCell {
    
    private var leapQuestCatalogEmojiLabel: UILabel!
    private var leapQuestCatalogTitleLabel: UILabel!
    private var leapQuestCatalogDescriptionLabel: UILabel!
    private var leapQuestCatalogStatusLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLeapQuestCatalogCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLeapQuestCatalogCell() {
        backgroundColor = LeapQuestColorTheme.Background.card
        layer.cornerRadius = 12
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.borderWidth = 1
        layer.borderColor = LeapQuestColorTheme.Border.primary.cgColor
        
        leapQuestCatalogEmojiLabel = UILabel()
        leapQuestCatalogEmojiLabel.font = UIFont.systemFont(ofSize: 40)
        leapQuestCatalogEmojiLabel.textAlignment = .center
        leapQuestCatalogEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestCatalogTitleLabel = UILabel()
        leapQuestCatalogTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        leapQuestCatalogTitleLabel.textColor = LeapQuestColorTheme.Primary.frogGreen
        leapQuestCatalogTitleLabel.textAlignment = .center
        leapQuestCatalogTitleLabel.numberOfLines = 2
        leapQuestCatalogTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestCatalogDescriptionLabel = UILabel()
        leapQuestCatalogDescriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        leapQuestCatalogDescriptionLabel.textColor = LeapQuestColorTheme.Text.secondary
        leapQuestCatalogDescriptionLabel.textAlignment = .center
        leapQuestCatalogDescriptionLabel.numberOfLines = 3
        leapQuestCatalogDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestCatalogStatusLabel = UILabel()
        leapQuestCatalogStatusLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        leapQuestCatalogStatusLabel.textAlignment = .center
        leapQuestCatalogStatusLabel.layer.cornerRadius = 8
        leapQuestCatalogStatusLabel.layer.masksToBounds = true
        leapQuestCatalogStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(leapQuestCatalogEmojiLabel)
        contentView.addSubview(leapQuestCatalogTitleLabel)
        contentView.addSubview(leapQuestCatalogDescriptionLabel)
        contentView.addSubview(leapQuestCatalogStatusLabel)
        
        NSLayoutConstraint.activate([
            leapQuestCatalogEmojiLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            leapQuestCatalogEmojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            leapQuestCatalogEmojiLabel.widthAnchor.constraint(equalToConstant: 50),
            leapQuestCatalogEmojiLabel.heightAnchor.constraint(equalToConstant: 50),
            
            leapQuestCatalogTitleLabel.topAnchor.constraint(equalTo: leapQuestCatalogEmojiLabel.bottomAnchor, constant: 8),
            leapQuestCatalogTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            leapQuestCatalogTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            leapQuestCatalogDescriptionLabel.topAnchor.constraint(equalTo: leapQuestCatalogTitleLabel.bottomAnchor, constant: 4),
            leapQuestCatalogDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            leapQuestCatalogDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            leapQuestCatalogStatusLabel.topAnchor.constraint(equalTo: leapQuestCatalogDescriptionLabel.bottomAnchor, constant: 8),
            leapQuestCatalogStatusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            leapQuestCatalogStatusLabel.widthAnchor.constraint(equalToConstant: 80),
            leapQuestCatalogStatusLabel.heightAnchor.constraint(equalToConstant: 16),
            leapQuestCatalogStatusLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configureLeapQuestCatalogItem(_ item: LeapQuestCatalogItemModel) {
        leapQuestCatalogEmojiLabel.text = item.leapQuestCatalogItemEmoji
        leapQuestCatalogTitleLabel.text = item.leapQuestCatalogItemTitle
        leapQuestCatalogDescriptionLabel.text = item.leapQuestCatalogItemDescription
        
        if item.leapQuestCatalogItemIsUnlocked {
            leapQuestCatalogStatusLabel.text = "UNLOCKED"
            leapQuestCatalogStatusLabel.backgroundColor = LeapQuestColorTheme.Primary.frogGreen.withAlphaComponent(0.2)
            leapQuestCatalogStatusLabel.textColor = LeapQuestColorTheme.Primary.frogGreen
        } else {
            leapQuestCatalogStatusLabel.text = "LOCKED"
            leapQuestCatalogStatusLabel.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
            leapQuestCatalogStatusLabel.textColor = UIColor.systemGray
        }
    }
}


