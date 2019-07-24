import MessageUI
import UIKit

/** The webpage address for this app. */
private let kWebpageAddress = "https://kennanmell.com/scale"

/** The GitHub webpage address for this app. */
private let kCodeAddress = "https://github.com/kennanmell/Scale"

/** The contact email for this app. */
private let kContactEmail = "kennanmell@gmail.com"

private enum MenuViewControllerSection: Int {
    case settings = 0
    case links
    
    /** The number of sections in the table. New sections should be added above this line. */
    case count
}

private enum MenuViewControllerSettingsRow: Int {
    case unitsToggle = 0

    /** The number of rows in the table. New rows should be added above this line. */
    case count
}

private enum MenuViewControllerLinksRow: Int {
    case webpage
    case sourceCode
    case contact

    /** The number of rows in the table. New rows should be added above this line. */
    case count
}

protocol MenuViewControllerDelegate: class {
    func menuViewControllerDidToggleUnits(_ menuViewController: MenuViewController)
}

class MenuViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    // MARK: Properties
    
    weak var delegate: MenuViewControllerDelegate?
    
    // MARK: Initialization
    
    init() {
        super.init(style: .grouped)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        assertionFailure()
        return nil
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedString.navigationMenu
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizedString.navigationDone,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(self.doneTapped))
        navigationItem.hidesBackButton = true
        
        tableView.backgroundColor = .sAppBackground
        tableView.separatorColor = .sTableSeparator
        tableView.isScrollEnabled = false
    }
    
    // MARK: Callbacks
    
    @objc func doneTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func unitsToggleTapped() {
        Settings.isMetric = !Settings.isMetric
        delegate?.menuViewControllerDidToggleUnits(self)
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        assert(tableView == self.tableView)
        
        tableView.deselectRow(at: indexPath, animated: true)
        switch MenuViewControllerSection(rawValue: indexPath.section)! {
        case .settings:
            switch MenuViewControllerSettingsRow(rawValue: indexPath.row)! {
            case .unitsToggle:
                break
            case .count:
                assertionFailure()
            }
        case .links:
            switch MenuViewControllerLinksRow(rawValue: indexPath.row)! {
            case .webpage:
                webpageTapped()
            case .sourceCode:
                sourceCodeTapped()
            case .contact:
                contactTapped()
            case .count:
                assertionFailure()
            }
        case .count:
            assertionFailure()
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        assert(tableView == self.tableView)
        return MenuViewControllerSection.count.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assert(tableView == self.tableView)
        switch MenuViewControllerSection(rawValue: section)! {
        case .settings:
            return MenuViewControllerSettingsRow.count.rawValue
        case .links:
            return MenuViewControllerLinksRow.count.rawValue
        case .count:
            assertionFailure()
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        assert(tableView == self.tableView)

        let cell = UITableViewCell()
        cell.contentView.superview?.backgroundColor = .sCellContentBackground
        cell.textLabel?.textColor = .sDarkText
        let cellBackgroundView = UIView()
        cellBackgroundView.backgroundColor = .sCellBackground
        cell.selectedBackgroundView = cellBackgroundView

        switch MenuViewControllerSection(rawValue: indexPath.section)! {
        case .settings:
            switch MenuViewControllerSettingsRow(rawValue: indexPath.row)! {
            case .unitsToggle:
                let switchView = UISwitch()
                switchView.onTintColor = .sSwitchTint
                switchView.isOn = Settings.isMetric
                switchView.addTarget(self, action: #selector(self.unitsToggleTapped), for: .valueChanged)
                cell.textLabel?.text = LocalizedString.menuUnitsToggle
                cell.selectionStyle = .none
                cell.accessoryView = switchView
            case .count:
                assertionFailure()
            }
        case .links:
            switch MenuViewControllerLinksRow(rawValue: indexPath.row)! {
            case .webpage:
                cell.textLabel?.text = LocalizedString.menuWebpage
                cell.accessoryType = .disclosureIndicator
            case .sourceCode:
                cell.textLabel?.text = LocalizedString.menuCode
                cell.accessoryType = .disclosureIndicator
            case .contact:
                cell.textLabel?.text = LocalizedString.menuContact
                cell.accessoryType = .disclosureIndicator
            case .count:
                assertionFailure()
            }
        case .count:
            assertionFailure()
        }
        return cell
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true)
    }
    
    // MARK: Private
    
    private func webpageTapped() {
        let webVC = WebViewController()
        webVC.showPage(title: LocalizedString.menuWebpage, urlString: kWebpageAddress)
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    private func sourceCodeTapped() {
        let webVC = WebViewController()
        webVC.showPage(title: LocalizedString.menuCode, urlString: kCodeAddress)
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    private func contactTapped() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([kContactEmail])
            // Not localized to imply that the recipient will speak English.
            mail.setSubject("A question about Scale")
            present(mail, animated: true)
        } else {
            let alertVC = UIAlertController(title: LocalizedString.mailErrorTitle,
                                            message: LocalizedString.genericErrorDescription,
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: LocalizedString.alertOkButton,
                                            style: .default,
                                            handler: nil))
            present(alertVC, animated: true)
            alertVC.view.tintColor = .sAlertTint
        }
    }
}
