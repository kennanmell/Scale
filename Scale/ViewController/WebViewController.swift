import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: Properties

    private var webView: ProgressWebView {
        return self.view as! ProgressWebView
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = ProgressWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizedString.navigationDone,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(self.doneTapped))
    }
    
    // MARK: Functions
    
    func showPage(title: String, urlString: String) {
        self.title = title
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        } else {
            assertionFailure("load failed (invalid url)")
            presentErrorAlert(title: LocalizedString.webpageLoadErrorTitle,
                              message: LocalizedString.genericErrorDescription)
        }
    }
    
    // MARK: Callbacks
    
    @objc func doneTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: WKNavigationDelegate
    
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        self.webView.progressView.stopAnimating()
        presentErrorAlert(title: nil, message: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation!) {
        self.webView.progressView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.progressView.stopAnimating()
    }
    
    // MARK: Private
    
    private func presentErrorAlert(title: String?, message: String?) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: LocalizedString.alertOkButton,
                                        style: .default,
                                        handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alertVC, animated: true)
        alertVC.view.tintColor = .sAlertTint
    }
}
