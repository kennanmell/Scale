import UIKit

extension UIColor {
    
    // MARK: Properties
    
    private static let sDark = UIColor(hex: 0x202124)
    private static let sOrange = UIColor(hex: 0xf29900)
    private static let sLight = UIColor(hex: 0xf8f9fa)
    private static let sGray = UIColor(hex: 0xbdc1c6)
    
    static let sAppBackground = UIColor.white
    static let sDarkText = UIColor.sDark
    static let sNeutralText = UIColor(hex: 0x3c4043)
    static let sLightText = UIColor(hex: 0x5f6368)
    static let sRedText = UIColor(hex: 0xea4335)
    static let sNavigationBarTint = UIColor.sOrange
    static let sNavigationBarBackground = UIColor.sLight
    static let sTableSeparator = UIColor.sGray
    static let sProgressSpinner = UIColor.sDark
    static let sAlertTint = UIColor.sOrange
    static let sSwitchTint = UIColor.sOrange
    static let sCellContentBackground = UIColor.sLight
    static let sCellBackground = UIColor.sGray
    
    // MARK: Functions
    
    /**
     Initializes a UIColor with a specified rgb hex color code and alpha.
     For example, `0xffffff` will initialize a white color.
     - parameters:
     - hex: The hex color code representing the color as an Int.
     Must be between 0x000000 and 0xffffff (inclusive).
     - alpha: The alpha value of the color. Must be between 0.0 and 1.0 (inclusive).
     */
    private convenience init(hex: Int, alpha: CGFloat = 1.0) {
        guard hex >= 0 && hex <= 0xffffff else {
            assertionFailure("color hex out of range (" + String(hex) + ")")
            self.init(white: 0.0, alpha: 1.0)
            return
        }
        
        guard alpha >= 0.0 && alpha <= 1.0 else {
            assertionFailure("alpha out of range (" + alpha.description + ")")
            self.init(white: 0.0, alpha: 1.0)
            return
        }
        
        self.init(red: CGFloat((hex >> 16) & 0x0000ff) / 255.0,
                  green: CGFloat((hex >> 8) & 0x0000ff) / 255.0,
                  blue: CGFloat(hex & 0x0000ff) / 255.0,
                  alpha: alpha)
    }
}
