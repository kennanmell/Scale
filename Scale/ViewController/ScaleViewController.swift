import UIKit

/**
 Controls the main view of the Scale app. Responsible for converting touch events
 to weight measurements.
 */
class ScaleViewController: UIViewController, MenuViewControllerDelegate {
    
    // MARK: Properties

    /** The `ScaleView` the `ScaleViewController` manages. */
    private var scaleView: ScaleView {
        return view as! ScaleView
    }
    
    /** The model that tracks the current weight and tare. */
    private var scale = Scale()

    /** The `UITouch` events contributing to the current weight measurement. */
    private var touches = Set<UITouch>()
    
    /** If false, the `ScaleState` should be `instructions` when possible. */
    private var didShowInstructions = false
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = ScaleView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedString.navigationTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: LocalizedString.navigationTare,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(self.tareTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizedString.navigationMenu,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(self.menuTapped))
        scale.isMetric = Settings.isMetric
        scaleView.isMultipleTouchEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Possible changes to Settings or other values may require a reload.
        reloadView()
    }
    
    // MARK: Callbacks
    
    @objc func tareTapped() {
        switch scaleView.state {
        case .disabled, .maxed: return
        case .instructions, .multiTouch, .regular: break
        }
        scale.tare += scale.weight
        reloadView()
    }
    
    @objc func menuTapped() {
        // TODO: cancel current touches
        let menuVC = MenuViewController()
        menuVC.delegate = self
        navigationController?.pushViewController(menuVC, animated: true)
    }

    // MARK: UIResponder
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touches.insert(touch)
        }
        reloadView()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        reloadView()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touches.remove(touch)
        }
        reloadView()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touches.remove(touch)
        }
        reloadView()
    }
    
    // MARK: MenuViewControllerDelegate
    
    func menuViewControllerDidToggleUnits(_ menuViewController: MenuViewController) {
        scale.isMetric = Settings.isMetric
        reloadView()
    }
    
    // MARK: Private
    
    /** Recomputes the weight and state, and updates the `ScaleView` accordingly. */
    private func reloadView() {
        guard traitCollection.forceTouchCapability == .available else {
            scaleView.state = .disabled
            return
        }

        // Compute the new weight and state.
        var scaleState: ScaleState
        if touches.count > 1 {
            scaleState = .multiTouch
        } else if !didShowInstructions {
            scaleState = .instructions
        } else {
            scaleState = .regular
        }
        var force: CGFloat = 0
        for touch in touches {
            if touch.force >= touch.maximumPossibleForce {
                scaleState = .maxed
                break
            } else {
                force += abs(touch.force / touch.maximumPossibleForce)
            }
        }
        scale.updateWeight(force: force)
        let weight = scale.weight
        
        // Set the weight and units text.
        let weightText: String
        let unitsText: String
        if scaleState == .maxed {
            weightText = LocalizedString.invalidWeight
        } else {
            weightText = LocalizedString.from(float: weight)
        }
        
        switch scale.units {
        case .metricSingular: unitsText = LocalizedString.metricUnitsSingular
        case .metricPlural: unitsText = LocalizedString.metricUnitsPlural
        case .imperialSingular: unitsText = LocalizedString.imperialUnitsSingular
        case .imperialPlural: unitsText = LocalizedString.imperialUnitsPlural
        }
        
        if scaleState == .instructions {
            didShowInstructions = true
        }
        scaleView.state = scaleState
        scaleView.weightLabel.text = weightText
        scaleView.unitsLabel.text = unitsText
    }
}
