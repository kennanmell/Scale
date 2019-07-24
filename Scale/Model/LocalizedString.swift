import UIKit

struct LocalizedString {
    
    // MARK: Messages
    
    static let instructionsMessage =
        NSLocalizedString("message_instructions",
                          comment: "Message shown when the user first opens the app.")
    
    static let disabledMessage =
        NSLocalizedString("message_disabled",
                          comment: "Message shown when force touch is disabled.")
    
    static let maxedMessage =
        NSLocalizedString("message_maxed",
                          comment: "Message shown when the maximum weight is" +
                                   " reached or exceeded.")
    
    static let multiTouchMessage =
        NSLocalizedString("message_multi_touch",
                          comment: "Message shown when there are multiple touch events.")
    
    // MARK: Units
    
    static let metricUnitsSingular =
        NSLocalizedString("metric_units_singular",
                          comment: "Metric units of the weight 1.")
    
    static let metricUnitsPlural =
        NSLocalizedString("metric_units_plural",
                          comment: "Metric units of a non-1 weight.")
    
    static let imperialUnitsSingular =
        NSLocalizedString("imperial_units_singular",
                          comment: "Imperial units of the weight 1.")
    
    static let imperialUnitsPlural =
        NSLocalizedString("imperial_units_plural",
                          comment: "Imperial units of a non-1 weight.")
    
    // MARK: Weights
    
    static let invalidWeight =
        NSLocalizedString("invalid_weight",
                          comment: "Measurement shown when the force is too great.")
    
    // MARK: Navigation
    
    static let navigationTitle =
        NSLocalizedString("navigation_title",
                          comment: "Title of the navigation bar on the home page")
    
    static let navigationTare = NSLocalizedString("navigation_tare", comment: "Tare button title")
    
    static let navigationMenu = NSLocalizedString("navigation_menu", comment: "Menu title")
    
    static let navigationDone = NSLocalizedString("navigation_done", comment: "Done button title")
    
    // MARK: Menu
    
    static let menuUnitsToggle = NSLocalizedString("menu_units_toggle", comment: "Units toggle switch")
    
    static let menuContact = NSLocalizedString("menu_contact", comment: "Contact me button")
    
    static let menuWebpage = NSLocalizedString("menu_webpage", comment: "Webpage button")
    
    static let menuCode = NSLocalizedString("menu_code", comment: "Source code button")
    
    // MARK: Web View
    
    static let loadingLabel =
        NSLocalizedString("loading_label",
                          comment: "Accessibility label for webpage loading progress indicator")
    
    // MARK: Alerts
    
    static let alertOkButton = NSLocalizedString("alert_ok_button", comment: "Ok button on alert")
    
    static let genericErrorDescription =
        NSLocalizedString("generic_error_description",
                          comment: "Generic message displayed when an error occurs")
    
    static let mailErrorTitle =
        NSLocalizedString("mail_error_title",
                          comment: "Error message when mail compose failed")
    
    static let webpageLoadErrorTitle =
        NSLocalizedString("webpage_load_error_title",
                          comment: "Error message when webpage load failed")
    
    // MARK: Functions
    
    /**
     Creates a localized and internationalized `String` to represent a `CGFloat`.
     Rounds to one decimal place to optimize for display.
     - parameter float: The `CGFloat` to represent as a `String`.
     - returns: A `String` representing the given `CGFloat`.
     */
    static func from(float: CGFloat) -> String {
        var float = float
        if (float > -0.05 && float < 0) {
            // Prevents a bug in NumberFormatter that outputs "-0.0"
            // when rounding a number close to 0.
            float = 0
        }
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.minimumIntegerDigits = 1
        return formatter.string(from: NSNumber(floatLiteral: Double(float)))!
    }
}
