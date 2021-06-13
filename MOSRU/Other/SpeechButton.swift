
import UIKit

class SpeechButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            self.shrink(down: isHighlighted)
        }
    }
    
    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .allowUserInteraction, animations: {
            if down {
                self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            } else {
                self.transform = .identity
            }
        }) { (success) in
            
        }
        
    }
}
