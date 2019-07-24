import Foundation

/**
 The states the Scale app can have. The state impacts whether or not
 a weight can be displayed, and what supplemental text (if any) is
 displayed with the weight.
 
 If more than one state applies simultaneously, the first one defined
 takes priority.
 */
enum ScaleState {
    /** Force touch is disabled or unavailable. */
    case disabled
    /** The maximum weight is reached or exceeded by at least one touch. */
    case maxed
    /** There is more than one simultaneous touch. */
    case multiTouch
    /** The user hasn't weighed anything during this launch of the app. */
    case instructions
    /** No other states apply. */
    case regular
}
