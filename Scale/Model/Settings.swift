import Foundation

class Settings {
    
    // MARK: Properties
    
    private static let defaults = UserDefaults.standard
    private static let isInitializedKey = "Settings.isInitialized"
    private static let isMetricKey = "Settings.isMetric"
    
    private static var isInitialized = defaults.bool(forKey: Settings.isInitializedKey) {
        didSet {
            UserDefaults.standard.set(isInitialized, forKey: Settings.isInitializedKey)
        }
    }

    static var isMetric = defaults.bool(forKey: Settings.isMetricKey) {
        didSet {
            UserDefaults.standard.set(isMetric, forKey: Settings.isMetricKey)
        }
    }
    
    // MARK: Functions
    
    static func initialize() {
        if !isInitialized {
            isInitialized = true
            isMetric = true
        }
    }
}
