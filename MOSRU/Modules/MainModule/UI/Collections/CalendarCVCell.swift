
import UIKit

class CalendarCVCell: UICollectionViewCell {
    
    static let identifier = "CalendarCVCell"
    
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
        
    private lazy var coverView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(white: 1, alpha: 1)
        view.clipsToBounds = true

        return view
    }()
    
    private lazy var shadowView: RoundShadowView = {
        let view = RoundShadowView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        return label
    }()

    // MARK: - lifecycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = .white
        coverView.layer.cornerRadius = 8
        coverView.clipsToBounds = true
        
        self.addSubview(shadowView)
        self.addSubview(coverView)
        coverView.addSubview(titleLabel)
        coverView.addSubview(subtitleLabel)

        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        shadowView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //shadowView.heightAnchor.constraint(equalToConstant: 64).isActive = true

        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        coverView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        coverView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        coverView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //coverView.heightAnchor.constraint(equalToConstant: 64).isActive = true

//        coverView.translatesAutoresizingMaskIntoConstraints = false
//        coverView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        coverView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        coverView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        coverView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: coverView.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: coverView.rightAnchor, constant: -8).isActive = true

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 8).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: coverView.rightAnchor, constant: -8).isActive = true

     }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.subtitleLabel.text = ""
        self.titleLabel.textColor = .black
        self.subtitleLabel.textColor = .black
    }
    
    func prepare(title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
    
    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.6, delay: 0, options: .allowUserInteraction, animations: {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } else {
                self.transform = .identity
            }
        }) { (success) in
            
        }
    }
    
    func setSelected(_ value: Bool) {
        if value {
            self.titleLabel.textColor = .systemRed
            self.subtitleLabel.textColor = .systemRed
        } else {
            self.titleLabel.textColor = .black
            self.subtitleLabel.textColor = .black
        }
    }

}
