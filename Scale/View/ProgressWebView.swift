import UIKit
import WebKit

/**
 A `UIWebView` that shows a spinning `UIActivityIndicatorView` in the center of the screen
 while loading a webpage.
 */
class ProgressWebView: WKWebView {
    
    // MARK: Properties
    
    /** The `UIActivityIndicatorView` displayed when this `ProgressWebView` is loading a page. */
    let progressView = UIActivityIndicatorView(style: .whiteLarge)
    
    // MARK: Initialization
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        backgroundColor = .sAppBackground
        
        progressView.hidesWhenStopped = true
        progressView.accessibilityLabel = LocalizedString.loadingLabel
        progressView.color = .sProgressSpinner
        addSubview(progressView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        assertionFailure()
        return nil
    }
    
    // MARK: Functions
    
    override func layoutSubviews() {
        progressView.center = center
    }
}
