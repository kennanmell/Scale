import UIKit

/** The horizontal margin of the ScaleView. */
private let kHorizontalMargin: CGFloat = 10
/** The bottom margin of the ScaleView */
private let kBottomMargin: CGFloat = 50
/** The top margin of the ScaleView */
private let kTopMargin: CGFloat = 100
/** The vertical space between the weight label and units label. */
private let kLabelVerticalSpacing: CGFloat = 10

/** The main view in the Scale app. */
class ScaleView: UIView {
    
    // MARK: Properties
    
    /** May display a message, whose contents vary based on the `state` property. */
    let messageLabel = UILabel()
    /** The weight currently being measured. */
    let weightLabel = UILabel()
    /** The units of the weight currently being measured. */
    let unitsLabel = UILabel()
    
    /** The state of the scale. */
    var state: ScaleState = .instructions {
        didSet {
            switch state {
            case .instructions:
                messageLabel.textColor = .sLightText
                messageLabel.text = LocalizedString.instructionsMessage
            case .disabled:
                messageLabel.textColor = .sLightText
                messageLabel.text = LocalizedString.disabledMessage
            case .maxed:
                messageLabel.textColor = .sRedText
                messageLabel.text = LocalizedString.maxedMessage
            case .multiTouch:
                messageLabel.textColor = .sRedText
                messageLabel.text = LocalizedString.multiTouchMessage
            case .regular:
                break
            }
            messageLabel.isHidden = state == .regular
            weightLabel.isHidden = state == .disabled
            unitsLabel.isHidden = state == .disabled
            setNeedsLayout()
        }
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .sAppBackground
        
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)

        weightLabel.textAlignment = .center
        weightLabel.font = UIFont.systemFont(ofSize: 75, weight: .regular)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.textColor = .sDarkText
        addSubview(weightLabel)
        
        unitsLabel.textAlignment = .center
        unitsLabel.font = UIFont.systemFont(ofSize: 14)
        unitsLabel.translatesAutoresizingMaskIntoConstraints = false
        unitsLabel.textColor = .sNeutralText
        addSubview(unitsLabel)
        
        addConstraint(NSLayoutConstraint(item: messageLabel,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: kHorizontalMargin))
        addConstraint(NSLayoutConstraint(item: messageLabel,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .trailing,
                                         multiplier: 1,
                                         constant: -kHorizontalMargin))
        addConstraint(NSLayoutConstraint(item: messageLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .top,
                                         multiplier: 1,
                                         constant: kTopMargin))
        
        addConstraint(NSLayoutConstraint(item: unitsLabel,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: kHorizontalMargin))
        addConstraint(NSLayoutConstraint(item: unitsLabel,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .trailing,
                                         multiplier: 1,
                                         constant: -kHorizontalMargin))
        addConstraint(NSLayoutConstraint(item: unitsLabel,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: -kBottomMargin))

        addConstraint(NSLayoutConstraint(item: weightLabel,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: kHorizontalMargin))
        addConstraint(NSLayoutConstraint(item: weightLabel,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .trailing,
                                         multiplier: 1,
                                         constant: -kHorizontalMargin))
        addConstraint(NSLayoutConstraint(item: weightLabel,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: unitsLabel,
                                         attribute: .top,
                                         multiplier: 1,
                                         constant: -kLabelVerticalSpacing))
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        assertionFailure()
        return nil
    }
}
