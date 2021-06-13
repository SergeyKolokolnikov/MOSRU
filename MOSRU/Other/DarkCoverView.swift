
import UIKit

class DarkCoverView: UIView {

    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(white: 0, alpha: 0).cgColor, UIColor(white: 0, alpha: 0.7).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        return gradient
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.insertSublayer(gradient, at: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradient.frame = self.frame
    }

}
