
import UIKit

class RoundShadowView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 8
    private var fillColor: UIColor = .white
  
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 1)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 4
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }

    private func gradient(size: CGSize, color: [UIColor]) -> UIImage? {
        let colors = color.map{$0.cgColor}
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        defer {UIGraphicsEndImageContext()}
        let locations:[CGFloat] = [0.0, 1.0]
        guard let gredient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as NSArray as CFArray, locations: locations) else {
            return nil
        }
        context.drawLinearGradient(gredient, start: CGPoint(x: 0.0, y: size.height), end: CGPoint(x: size.width, y: size.height), options: [])
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    private func gradient(start: CGPoint, end:  CGPoint, color: [UIColor]) -> UIImage? {
        let colors = color.map{$0.cgColor}
        UIGraphicsBeginImageContextWithOptions(frame.size, true, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        defer {UIGraphicsEndImageContext()}
        let locations: [CGFloat] = [0.0, 1.0]
        guard let gredient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as NSArray as CFArray, locations: locations) else {
            return nil
        }
        context.drawLinearGradient(gredient, start: start, end: end, options: [])
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
}
