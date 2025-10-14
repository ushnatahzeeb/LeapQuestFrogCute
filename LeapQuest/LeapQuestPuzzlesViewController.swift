import UIKit

class LeapQuestPuzzlesViewController: UIViewController {
    
    private var leapQuestPuzzlesViewModel: LeapQuestPuzzlesViewModel!
    private var leapQuestPuzzlesCollectionView: UICollectionView!
    private var leapQuestBackgroundView: LeapQuestGradientView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestPuzzlesViewController()
        setupLeapQuestPuzzlesViewModel()
        setupLeapQuestPuzzlesUI()
    }
    
    private func setupLeapQuestPuzzlesViewController() {
        title = "🧩 Puzzles"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = LeapQuestColorTheme.Text.primary
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        
        setupLeapQuestBackground()
    }
    
    private func setupLeapQuestBackground() {
        leapQuestBackgroundView = LeapQuestGradientView(leapQuestGradientType: .cosmic)
        leapQuestBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(leapQuestBackgroundView, at: 0)
        
        NSLayoutConstraint.activate([
            leapQuestBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            leapQuestBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        leapQuestBackgroundView.leapQuestAnimateGradient()
    }
    
    private func setupLeapQuestPuzzlesViewModel() {
        leapQuestPuzzlesViewModel = LeapQuestPuzzlesViewModel()
        leapQuestPuzzlesViewModel.leapQuestPuzzlesDelegate = self
    }
    
    private func setupLeapQuestPuzzlesUI() {
        setupLeapQuestPuzzlesCollectionView()
    }
    
    private func setupLeapQuestPuzzlesCollectionView() {
        let leapQuestLayout = UICollectionViewFlowLayout()
        leapQuestLayout.scrollDirection = .vertical
        leapQuestLayout.minimumLineSpacing = 20
        leapQuestLayout.minimumInteritemSpacing = 20
        leapQuestLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        leapQuestPuzzlesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: leapQuestLayout)
        leapQuestPuzzlesCollectionView.delegate = self
        leapQuestPuzzlesCollectionView.dataSource = self
        leapQuestPuzzlesCollectionView.register(LeapQuestPuzzleCell.self, forCellWithReuseIdentifier: LeapQuestPuzzleCell.identifier)
        leapQuestPuzzlesCollectionView.backgroundColor = UIColor.clear
        leapQuestPuzzlesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leapQuestPuzzlesCollectionView)
        
        NSLayoutConstraint.activate([
            leapQuestPuzzlesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leapQuestPuzzlesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestPuzzlesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestPuzzlesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension LeapQuestPuzzlesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LeapQuestPuzzleType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeapQuestPuzzleCell.identifier, for: indexPath) as? LeapQuestPuzzleCell else {
            return UICollectionViewCell()
        }
        
        let puzzleType = LeapQuestPuzzleType.allCases[indexPath.item]
        cell.configure(with: puzzleType)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension LeapQuestPuzzlesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let puzzleType = LeapQuestPuzzleType.allCases[indexPath.item]
        
        LeapQuestHapticFeedbackManager.shared.leapQuestCoinFeedback()
        
        switch puzzleType {
        case .ticTacToe:
            let ticTacToeVC = LeapQuestTicTacToeViewController()
            navigationController?.pushViewController(ticTacToeVC, animated: true)
            
        case .memorySequence:
            let memoryVC = LeapQuestMemorySequenceViewController()
            navigationController?.pushViewController(memoryVC, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LeapQuestPuzzlesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - 60 // 20 + 20 + 20 margins
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: 160)
    }
}

// MARK: - LeapQuestPuzzlesViewModelDelegate
extension LeapQuestPuzzlesViewController: LeapQuestPuzzlesViewModelDelegate {
    func leapQuestPuzzlesViewModelDidUpdate() {
        leapQuestPuzzlesCollectionView.reloadData()
    }
}