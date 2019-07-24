import UIKit

/** The duration of the fade in/fade out animation */
private let kAnimationDuration = 0.2

/**
 The root controller of the Scale app. Responsible for controlling navigation and
 creating the top bar.
 */
class NavigationController: UINavigationController {
    
    // MARK: Initialization
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        initialize()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        assertionFailure()
        return nil
    }

    // MARK: UINavigationController
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        addTransition(animated: animated)
        super.pushViewController(viewController, animated: false)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        addTransition(animated: animated)
        return super.popViewController(animated: false)
    }
    
    override func popToViewController(_ viewController: UIViewController,
                                      animated: Bool) -> [UIViewController]? {
        addTransition(animated: animated)
        return super.popToViewController(viewController, animated: false)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        addTransition(animated: animated)
        return super.popToRootViewController(animated: false)
    }
    
    // MARK: Private
    
    private func initialize() {
        navigationBar.tintColor = .sNavigationBarTint
        navigationBar.barTintColor = .sNavigationBarBackground
        navigationBar.titleTextAttributes = [.foregroundColor : UIColor.sDarkText]
        interactivePopGestureRecognizer?.isEnabled = false
    }

    private func addTransition(animated: Bool) {
        if !animated {
            return
        }
        let transition = CATransition()
        transition.duration = kAnimationDuration
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        view.layer.add(transition, forKey: nil)
    }
}
