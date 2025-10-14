import UIKit

class LeapQuestFactsViewController: UIViewController {
    
    private var leapQuestFactsTableView: UITableView!
    private var leapQuestBackgroundGradient: LeapQuestGradientView!
    private var leapQuestFactsCountLabel: UILabel!
    private var leapQuestSegmentedControl: UISegmentedControl!
    
    private var leapQuestAllFacts: [LeapQuestFact] = []
    private var leapQuestFilteredFacts: [LeapQuestFact] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestFactsViewController()
        setupLeapQuestFactsUI()
        loadLeapQuestFacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leapQuestFactsTableView.reloadData()
        updateLeapQuestFactsCount()
    }
    
    private func setupLeapQuestFactsViewController() {
        title = "📚 Facts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = LeapQuestColorTheme.Text.primary
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        
        leapQuestBackgroundGradient = LeapQuestGradientView(leapQuestGradientType: .cosmic)
        leapQuestBackgroundGradient.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(leapQuestBackgroundGradient)
        view.sendSubviewToBack(leapQuestBackgroundGradient)
    }
    
    private func setupLeapQuestFactsUI() {
        setupLeapQuestFactsCountLabel()
        setupLeapQuestSegmentedControl()
        setupLeapQuestFactsTableView()
    }
    
    private func setupLeapQuestFactsCountLabel() {
        leapQuestFactsCountLabel = UILabel()
        leapQuestFactsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestFactsCountLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        leapQuestFactsCountLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestFactsCountLabel.textAlignment = .center
        view.addSubview(leapQuestFactsCountLabel)
        
        NSLayoutConstraint.activate([
            leapQuestFactsCountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            leapQuestFactsCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leapQuestFactsCountLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        updateLeapQuestFactsCount()
    }
    
    private func setupLeapQuestSegmentedControl() {
        let categories = LeapQuestFactCategory.allCases.map { $0.rawValue }
        leapQuestSegmentedControl = UISegmentedControl(items: ["All"] + categories)
        leapQuestSegmentedControl.selectedSegmentIndex = 0
        leapQuestSegmentedControl.addTarget(self, action: #selector(leapQuestSegmentedControlChanged), for: .valueChanged)
        leapQuestSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        leapQuestSegmentedControl.backgroundColor = LeapQuestColorTheme.Background.card
        leapQuestSegmentedControl.selectedSegmentTintColor = LeapQuestColorTheme.Primary.waterBlue.withAlphaComponent(0.3)
        leapQuestSegmentedControl.setTitleTextAttributes([.foregroundColor: LeapQuestColorTheme.Text.primary], for: .normal)
        leapQuestSegmentedControl.setTitleTextAttributes([.foregroundColor: LeapQuestColorTheme.Text.primary], for: .selected)
        
        view.addSubview(leapQuestSegmentedControl)
        
        NSLayoutConstraint.activate([
            leapQuestSegmentedControl.topAnchor.constraint(equalTo: leapQuestFactsCountLabel.bottomAnchor, constant: 8),
            leapQuestSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            leapQuestSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            leapQuestSegmentedControl.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupLeapQuestFactsTableView() {
        leapQuestFactsTableView = UITableView(frame: .zero, style: .grouped)
        leapQuestFactsTableView.delegate = self
        leapQuestFactsTableView.dataSource = self
        leapQuestFactsTableView.register(LeapQuestFactTableViewCell.self, forCellReuseIdentifier: LeapQuestFactTableViewCell.leapQuestReuseIdentifier)
        leapQuestFactsTableView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestFactsTableView.backgroundColor = .clear
        leapQuestFactsTableView.separatorStyle = .none
        
        view.addSubview(leapQuestFactsTableView)
        
        NSLayoutConstraint.activate([
            leapQuestFactsTableView.topAnchor.constraint(equalTo: leapQuestSegmentedControl.bottomAnchor, constant: 8),
            leapQuestFactsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestFactsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestFactsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadLeapQuestFacts() {
        leapQuestAllFacts = LeapQuestFactData.leapQuestFacts
        filterLeapQuestFacts()
    }
    
    private func filterLeapQuestFacts() {
        let selectedIndex = leapQuestSegmentedControl.selectedSegmentIndex
        
        if selectedIndex == 0 {
            leapQuestFilteredFacts = leapQuestAllFacts
        } else {
            let selectedCategory = LeapQuestFactCategory.allCases[selectedIndex - 1]
            leapQuestFilteredFacts = leapQuestAllFacts.filter { $0.leapQuestCategory == selectedCategory }
        }
        
        leapQuestFactsTableView.reloadData()
        updateLeapQuestFactsCount()
    }
    
    private func updateLeapQuestFactsCount() {
        let readCount = leapQuestFilteredFacts.filter { $0.leapQuestIsRead }.count
        let totalCount = leapQuestFilteredFacts.count
        leapQuestFactsCountLabel.text = "Facts: \(readCount)/\(totalCount) read"
    }
    
    @objc private func leapQuestSegmentedControlChanged() {
        filterLeapQuestFacts()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension LeapQuestFactsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leapQuestFilteredFacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeapQuestFactTableViewCell.leapQuestReuseIdentifier, for: indexPath) as? LeapQuestFactTableViewCell else {
            return UITableViewCell()
        }
        let fact = leapQuestFilteredFacts[indexPath.row]
        cell.leapQuestConfigure(with: fact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedFact = leapQuestFilteredFacts[indexPath.row]
        
        LeapQuestHapticFeedbackManager.shared.leapQuestJumpFeedback()
        
        let factDetailVC = LeapQuestFactDetailViewController(fact: selectedFact)
        navigationController?.pushViewController(factDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}
