import UIKit

class LeapQuestAchievementsViewController: UIViewController {
    
    private var leapQuestAchievementsViewModel: LeapQuestAchievementsViewModel!
    private var leapQuestAchievementManager: LeapQuestAchievementManager!
    private var leapQuestAchievementsTableView: UITableView!
    private var leapQuestHeaderView: UIView!
    private var leapQuestTotalCompletedLabel: UILabel!
    private var leapQuestBackgroundView: LeapQuestGradientView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestAchievementsViewController()
        setupLeapQuestAchievementsViewModel()
        setupLeapQuestAchievementManager()
        setupLeapQuestAchievementsUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLeapQuestAchievementsDisplay()
    }
    
    private func setupLeapQuestAchievementsViewController() {
        title = "🏅 Achievements"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = LeapQuestColorTheme.Text.primary
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        
        setupLeapQuestBackgroundView()
    }
    
    private func setupLeapQuestBackgroundView() {
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
    
    private func setupLeapQuestAchievementsViewModel() {
        leapQuestAchievementsViewModel = LeapQuestAchievementsViewModel()
        leapQuestAchievementsViewModel.leapQuestAchievementsDelegate = self
    }
    
    private func setupLeapQuestAchievementManager() {
        leapQuestAchievementManager = LeapQuestAchievementManager.shared
        leapQuestAchievementManager.leapQuestDelegate = self
    }
    
    private func setupLeapQuestAchievementsUI() {
        setupLeapQuestHeaderView()
        setupLeapQuestTableView()
    }
    
    private func setupLeapQuestHeaderView() {
        leapQuestHeaderView = UIView()
        leapQuestHeaderView.backgroundColor = UIColor.clear
        leapQuestHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        let leapQuestTitleLabel = UILabel()
        leapQuestTitleLabel.text = "YOUR ACHIEVEMENTS"
        leapQuestTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        leapQuestTitleLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestTotalCompletedLabel = UILabel()
        leapQuestTotalCompletedLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        leapQuestTotalCompletedLabel.textColor = LeapQuestColorTheme.Text.secondary
        leapQuestTotalCompletedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestHeaderView.addSubview(leapQuestTitleLabel)
        leapQuestHeaderView.addSubview(leapQuestTotalCompletedLabel)
        
        NSLayoutConstraint.activate([
            leapQuestTitleLabel.topAnchor.constraint(equalTo: leapQuestHeaderView.topAnchor, constant: 16),
            leapQuestTitleLabel.leadingAnchor.constraint(equalTo: leapQuestHeaderView.leadingAnchor, constant: 20),
            leapQuestTitleLabel.trailingAnchor.constraint(equalTo: leapQuestHeaderView.trailingAnchor, constant: -20),
            
            leapQuestTotalCompletedLabel.topAnchor.constraint(equalTo: leapQuestTitleLabel.bottomAnchor, constant: 4),
            leapQuestTotalCompletedLabel.leadingAnchor.constraint(equalTo: leapQuestHeaderView.leadingAnchor, constant: 20),
            leapQuestTotalCompletedLabel.trailingAnchor.constraint(equalTo: leapQuestHeaderView.trailingAnchor, constant: -20),
            leapQuestTotalCompletedLabel.bottomAnchor.constraint(equalTo: leapQuestHeaderView.bottomAnchor, constant: -16),
            leapQuestHeaderView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        view.addSubview(leapQuestHeaderView)
    }
    
    private func setupLeapQuestTableView() {
        leapQuestAchievementsTableView = UITableView(frame: .zero, style: .plain)
        leapQuestAchievementsTableView.backgroundColor = UIColor.clear
        leapQuestAchievementsTableView.separatorStyle = .none
        leapQuestAchievementsTableView.dataSource = self
        leapQuestAchievementsTableView.delegate = self
        leapQuestAchievementsTableView.register(LeapQuestAchievementCell.self, forCellReuseIdentifier: LeapQuestAchievementCell.identifier)
        leapQuestAchievementsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leapQuestAchievementsTableView)
        
        NSLayoutConstraint.activate([
            leapQuestHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            leapQuestHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            leapQuestAchievementsTableView.topAnchor.constraint(equalTo: leapQuestHeaderView.bottomAnchor),
            leapQuestAchievementsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestAchievementsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestAchievementsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func updateLeapQuestAchievementsDisplay() {
        let totalCompleted = leapQuestAchievementManager.leapQuestGetTotalCompleted()
        let totalAchievements = LeapQuestAchievementType.allCases.count
        
        leapQuestTotalCompletedLabel.text = "Completed: \(totalCompleted)/\(totalAchievements) achievements"
        
        leapQuestAchievementsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension LeapQuestAchievementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leapQuestAchievementManager.leapQuestGetAllAchievements().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeapQuestAchievementCell.identifier, for: indexPath) as? LeapQuestAchievementCell else {
            return UITableViewCell()
        }
        
        let achievement = leapQuestAchievementManager.leapQuestGetAllAchievements()[indexPath.row]
        cell.configure(with: achievement)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LeapQuestAchievementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - LeapQuestAchievementsViewModelDelegate
extension LeapQuestAchievementsViewController: LeapQuestAchievementsViewModelDelegate {
    func leapQuestAchievementsViewModelDidUpdate() {
        updateLeapQuestAchievementsDisplay()
    }
}

// MARK: - LeapQuestAchievementManagerDelegate
extension LeapQuestAchievementsViewController: LeapQuestAchievementManagerDelegate {
    func leapQuestAchievementManagerDidUpdateAchievements() {
        updateLeapQuestAchievementsDisplay()
    }
    
    func leapQuestAchievementManagerDidUnlockAchievement(_ achievement: LeapQuestAchievement) {
        // Show achievement unlocked notification
        LeapQuestHapticFeedbackManager.shared.leapQuestCoinFeedback()
        LeapQuestSoundManager.shared.leapQuestPlayCoinSound()
        
        let alert = UIAlertController(
            title: "🏆 Achievement Unlocked!",
            message: "\(achievement.leapQuestType.leapQuestEmoji) \(achievement.leapQuestType.rawValue)\n\(achievement.leapQuestType.leapQuestDescription)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Awesome!", style: .default))
        present(alert, animated: true)
    }
}