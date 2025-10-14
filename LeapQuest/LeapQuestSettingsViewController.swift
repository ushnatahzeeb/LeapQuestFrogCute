import UIKit

class LeapQuestSettingsViewController: UIViewController {
    
    private var leapQuestSettingsViewModel: LeapQuestSettingsViewModel!
    private var leapQuestSettingsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeapQuestSettingsViewController()
        setupLeapQuestSettingsViewModel()
        setupLeapQuestSettingsUI()
    }
    
    private func setupLeapQuestSettingsViewController() {
        title = "⚙️ Settings"
        view.backgroundColor = LeapQuestColorTheme.Background.primary
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = LeapQuestColorTheme.Text.primary
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: LeapQuestColorTheme.Text.primary]
    }
    
    private func setupLeapQuestSettingsViewModel() {
        leapQuestSettingsViewModel = LeapQuestSettingsViewModel()
        leapQuestSettingsViewModel.leapQuestSettingsDelegate = self
    }
    
    private func setupLeapQuestSettingsUI() {
        setupLeapQuestSettingsTableView()
    }
    
    private func setupLeapQuestSettingsTableView() {
        leapQuestSettingsTableView = UITableView(frame: .zero, style: .grouped)
        leapQuestSettingsTableView.delegate = self
        leapQuestSettingsTableView.dataSource = self
        leapQuestSettingsTableView.register(LeapQuestSettingsTableViewCell.self, forCellReuseIdentifier: "LeapQuestSettingsCell")
        leapQuestSettingsTableView.register(LeapQuestSettingsSwitchTableViewCell.self, forCellReuseIdentifier: "LeapQuestSettingsSwitchCell")
        leapQuestSettingsTableView.backgroundColor = LeapQuestColorTheme.Background.primary
        leapQuestSettingsTableView.separatorStyle = .none
        leapQuestSettingsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leapQuestSettingsTableView)
        
        NSLayoutConstraint.activate([
            leapQuestSettingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leapQuestSettingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestSettingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestSettingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LeapQuestSettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return leapQuestSettingsViewModel.leapQuestSettingsSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leapQuestSettingsViewModel.leapQuestSettingsSections[section].leapQuestSettingsSectionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = leapQuestSettingsViewModel.leapQuestSettingsSections[indexPath.section]
        let item = section.leapQuestSettingsSectionItems[indexPath.row]
        
        if item.leapQuestSettingsItemType == .`switch` {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeapQuestSettingsSwitchCell", for: indexPath) as! LeapQuestSettingsSwitchTableViewCell
            cell.configureLeapQuestSettingsSwitchItem(item)
            cell.leapQuestSettingsSwitchDelegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeapQuestSettingsCell", for: indexPath) as! LeapQuestSettingsTableViewCell
            cell.configureLeapQuestSettingsItem(item)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return leapQuestSettingsViewModel.leapQuestSettingsSections[section].leapQuestSettingsSectionTitle
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel()
        label.text = leapQuestSettingsViewModel.leapQuestSettingsSections[section].leapQuestSettingsSectionTitle
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = LeapQuestColorTheme.Text.accent
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = leapQuestSettingsViewModel.leapQuestSettingsSections[indexPath.section]
        let item = section.leapQuestSettingsSectionItems[indexPath.row]
        
        leapQuestSettingsViewModel.leapQuestSettingsSelectItem(item)
        
        if item.leapQuestSettingsItemType == .action, let action = item.leapQuestSettingsItemAction {
            handleLeapQuestSettingsAction(action)
        }
    }
    
    private func handleLeapQuestSettingsAction(_ action: LeapQuestSettingsAction) {
        switch action {
        case .resetData:
            showLeapQuestResetDataAlert()
        case .privacyPolicy:
            showLeapQuestPrivacyPolicy()
        case .termsOfUse:
            showLeapQuestTermsOfUse()
        }
    }
    
    private func showLeapQuestResetDataAlert() {
        let alert = UIAlertController(title: "Reset Data", message: "Are you sure you want to reset all game data? This action cannot be undone.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reset", style: .destructive) { _ in
            self.leapQuestSettingsViewModel.leapQuestSettingsResetData()
        })
        
        present(alert, animated: true)
    }
    
    private func showLeapQuestPrivacyPolicy() {
        openURL("https://example.com")
    }
    
    private func showLeapQuestTermsOfUse() {
        openURL("https://example.com")
    }
    
    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            let alert = UIAlertController(title: "Error", message: "Invalid URL", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Cannot open URL", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}

extension LeapQuestSettingsViewController: LeapQuestSettingsSwitchDelegate {
    func leapQuestSettingsSwitchDidChange(_ item: LeapQuestSettingsItemModel, isOn: Bool) {
        leapQuestSettingsViewModel.leapQuestSettingsToggleSwitch(item, isOn: isOn)
    }
}

extension LeapQuestSettingsViewController: LeapQuestSettingsViewModelDelegate {
    func leapQuestSettingsViewModelDidUpdate() {
        DispatchQueue.main.async {
            self.leapQuestSettingsTableView.reloadData()
        }
    }
}

class LeapQuestSettingsTableViewCell: UITableViewCell {
    
    private var leapQuestSettingsEmojiLabel: UILabel!
    private var leapQuestSettingsTitleLabel: UILabel!
    private var leapQuestSettingsAccessoryImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLeapQuestSettingsCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLeapQuestSettingsCell() {
        backgroundColor = LeapQuestColorTheme.Background.card
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = LeapQuestColorTheme.Border.primary.cgColor
        layer.shadowColor = LeapQuestColorTheme.Shadow.primary.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        
        leapQuestSettingsEmojiLabel = UILabel()
        leapQuestSettingsEmojiLabel.font = UIFont.systemFont(ofSize: 24)
        leapQuestSettingsEmojiLabel.textAlignment = .center
        leapQuestSettingsEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestSettingsTitleLabel = UILabel()
        leapQuestSettingsTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        leapQuestSettingsTitleLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestSettingsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestSettingsAccessoryImageView = UIImageView()
        leapQuestSettingsAccessoryImageView.contentMode = .scaleAspectFit
        leapQuestSettingsAccessoryImageView.tintColor = LeapQuestColorTheme.Text.secondary
        leapQuestSettingsAccessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(leapQuestSettingsEmojiLabel)
        contentView.addSubview(leapQuestSettingsTitleLabel)
        contentView.addSubview(leapQuestSettingsAccessoryImageView)
        
        NSLayoutConstraint.activate([
            leapQuestSettingsEmojiLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leapQuestSettingsEmojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leapQuestSettingsEmojiLabel.widthAnchor.constraint(equalToConstant: 32),
            leapQuestSettingsEmojiLabel.heightAnchor.constraint(equalToConstant: 32),
            
            leapQuestSettingsTitleLabel.leadingAnchor.constraint(equalTo: leapQuestSettingsEmojiLabel.trailingAnchor, constant: 12),
            leapQuestSettingsTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leapQuestSettingsTitleLabel.trailingAnchor.constraint(equalTo: leapQuestSettingsAccessoryImageView.leadingAnchor, constant: -12),
            
            leapQuestSettingsAccessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            leapQuestSettingsAccessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leapQuestSettingsAccessoryImageView.widthAnchor.constraint(equalToConstant: 16),
            leapQuestSettingsAccessoryImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configureLeapQuestSettingsItem(_ item: LeapQuestSettingsItemModel) {
        leapQuestSettingsEmojiLabel.text = item.leapQuestSettingsItemEmoji
        leapQuestSettingsTitleLabel.text = item.leapQuestSettingsItemTitle
        
        if item.leapQuestSettingsItemType == .action {
            leapQuestSettingsAccessoryImageView.image = UIImage(systemName: "chevron.right")
        } else {
            leapQuestSettingsAccessoryImageView.image = nil
        }
    }
}

class LeapQuestSettingsSwitchTableViewCell: UITableViewCell {
    
    private var leapQuestSettingsEmojiLabel: UILabel!
    private var leapQuestSettingsTitleLabel: UILabel!
    private var leapQuestSettingsSwitch: UISwitch!
    
    weak var leapQuestSettingsSwitchDelegate: LeapQuestSettingsSwitchDelegate?
    private var leapQuestSettingsCurrentItem: LeapQuestSettingsItemModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLeapQuestSettingsSwitchCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLeapQuestSettingsSwitchCell() {
        backgroundColor = LeapQuestColorTheme.Background.card
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = LeapQuestColorTheme.Border.primary.cgColor
        layer.shadowColor = LeapQuestColorTheme.Shadow.primary.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        
        leapQuestSettingsEmojiLabel = UILabel()
        leapQuestSettingsEmojiLabel.font = UIFont.systemFont(ofSize: 24)
        leapQuestSettingsEmojiLabel.textAlignment = .center
        leapQuestSettingsEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestSettingsTitleLabel = UILabel()
        leapQuestSettingsTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        leapQuestSettingsTitleLabel.textColor = LeapQuestColorTheme.Text.primary
        leapQuestSettingsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leapQuestSettingsSwitch = UISwitch()
        leapQuestSettingsSwitch.onTintColor = LeapQuestColorTheme.Primary.frogGreen
        leapQuestSettingsSwitch.thumbTintColor = LeapQuestColorTheme.Text.primary
        leapQuestSettingsSwitch.addTarget(self, action: #selector(leapQuestSettingsSwitchChanged), for: .valueChanged)
        leapQuestSettingsSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(leapQuestSettingsEmojiLabel)
        contentView.addSubview(leapQuestSettingsTitleLabel)
        contentView.addSubview(leapQuestSettingsSwitch)
        
        NSLayoutConstraint.activate([
            leapQuestSettingsEmojiLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leapQuestSettingsEmojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leapQuestSettingsEmojiLabel.widthAnchor.constraint(equalToConstant: 32),
            leapQuestSettingsEmojiLabel.heightAnchor.constraint(equalToConstant: 32),
            
            leapQuestSettingsTitleLabel.leadingAnchor.constraint(equalTo: leapQuestSettingsEmojiLabel.trailingAnchor, constant: 12),
            leapQuestSettingsTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leapQuestSettingsTitleLabel.trailingAnchor.constraint(equalTo: leapQuestSettingsSwitch.leadingAnchor, constant: -12),
            
            leapQuestSettingsSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            leapQuestSettingsSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureLeapQuestSettingsSwitchItem(_ item: LeapQuestSettingsItemModel) {
        leapQuestSettingsCurrentItem = item
        leapQuestSettingsEmojiLabel.text = item.leapQuestSettingsItemEmoji
        leapQuestSettingsTitleLabel.text = item.leapQuestSettingsItemTitle
        leapQuestSettingsSwitch.isOn = item.leapQuestSettingsItemBoolValue
    }
    
    @objc private func leapQuestSettingsSwitchChanged() {
        guard let item = leapQuestSettingsCurrentItem else { return }
        leapQuestSettingsSwitchDelegate?.leapQuestSettingsSwitchDidChange(item, isOn: leapQuestSettingsSwitch.isOn)
    }
}

