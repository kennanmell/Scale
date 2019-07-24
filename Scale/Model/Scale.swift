import UIKit

/** The ratio of weight (grams) to force. */
private let kForceMultiplierMetric: CGFloat = 385
/** The ratio of weight (ounces) to force. */
private let kForceMultiplierImperial: CGFloat = 13.58049

/** The units of a `Scale`. */
enum ScaleUnits {
    case metricSingular, metricPlural, imperialSingular, imperialPlural
}

/** A `Scale` computes and stores a weight based on a force, tare, and measurement system. */
class Scale {
    
    // MARK: Properties
    
    /** The current weight on the scale. */
    private(set) var weight: CGFloat = 0
    
    /** The tare used to compute the weight. */
    var tare: CGFloat = 0
    
    /** If true, the weight is in grams. Otherwise, it's in ounces. */
    var isMetric: Bool = true {
        didSet {
            if oldValue == isMetric {
                return
            }
            
            let multiplier: CGFloat
            if isMetric {
                multiplier = kForceMultiplierMetric / kForceMultiplierImperial
            } else {
                multiplier = kForceMultiplierImperial / kForceMultiplierMetric
            }
            
            weight *= multiplier
            tare *= multiplier
        }
    }
    
    /** The `ScaleUnits` of the current weight. */
    var units: ScaleUnits {
        let isSingular = weight == 1
        if isMetric {
            return isSingular ? .metricSingular : .metricPlural
        } else {
            return isSingular ? .imperialSingular : .imperialPlural
        }
    }
    
    // MARK: Functions
    
    /** Computes and sets the `weight` given a force.  */
    func updateWeight(force: CGFloat) {
        let forceMultiplier = Settings.isMetric ? kForceMultiplierMetric : kForceMultiplierImperial
        weight = force * forceMultiplier - tare
    }
}
