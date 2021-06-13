
import UIKit

class HeaderView: UIView {

    var heightLayoutConstraint = NSLayoutConstraint()
    var bottomLayoutConstraint = NSLayoutConstraint()

    var changeImageCompletionHandler: ((Int) -> Void) = {(Int) -> Void in}
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    var coverContainerView: DarkCoverView = {
        let view = DarkCoverView()
        return view
    }()

    private var scrollView: UIScrollView?

    var containerLayoutConstraint = NSLayoutConstraint()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: bounds)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.isOpaque = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    init(frame: CGRect, imageUrl: String) {
        super.init(frame: frame)
        self.setup(imageUrl: imageUrl)
    }
    
    private func setup(imageUrl: String) {
        self.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(containerView)
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[containerView]|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: ["containerView": containerView]))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[containerView]|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: ["containerView": containerView]))
        containerLayoutConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .height,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: 1.0,
            constant: 0.0)
        self.addConstraint(containerLayoutConstraint)
        
        containerLayoutConstraint.constant = 0

        containerView.addSubview(imageView)
        if let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url, completed: nil)
        }
        
        containerView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[imageView]|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: ["imageView": imageView]))
        bottomLayoutConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0)
        containerView.addConstraint(bottomLayoutConstraint)

        heightLayoutConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .height,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .height,
            multiplier: 1.0,
            constant: 0.0)
        containerView.addConstraint(heightLayoutConstraint)
        
        heightLayoutConstraint.constant = 0

        // ------- cover view
        imageView.addSubview(coverContainerView)

        coverContainerView.translatesAutoresizingMaskIntoConstraints = false
        coverContainerView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        coverContainerView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0).isActive = true
        coverContainerView.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        coverContainerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerLayoutConstraint.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }

    func setContentMode(_ mode: UIView.ContentMode) {
        self.imageView.contentMode = mode
    }
    
    func setSizeImageView(_ size: CGSize) {
        
    }

}
