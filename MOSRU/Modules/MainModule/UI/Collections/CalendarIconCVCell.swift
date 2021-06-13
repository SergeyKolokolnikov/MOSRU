
import UIKit

class CalendarIconCVCell: UICollectionViewCell {
    
    static let identifier = "CalendarIconCVCell"
    
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
    
    private lazy var coverView: RoundShadowView = {
        let view = RoundShadowView()
        return view
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "calendarIcon")
        return imageView
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
        
        self.addSubview(coverView)
        coverView.addSubview(titleLabel)
        coverView.addSubview(subtitleLabel)
        coverView.addSubview(previewImageView)

        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        coverView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        coverView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        coverView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.topAnchor.constraint(equalTo: self.coverView.topAnchor, constant: 16).isActive = true
        previewImageView.bottomAnchor.constraint(equalTo: self.coverView.bottomAnchor, constant: -16).isActive = true
        previewImageView.leftAnchor.constraint(equalTo: self.coverView.leftAnchor, constant: 16).isActive = true
        previewImageView.rightAnchor.constraint(equalTo: self.coverView.rightAnchor, constant: -16).isActive = true

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
        self.previewImageView.image = UIImage(named: "calendarIcon")
    }
    
    func prepare(title: String, subtitle: String) {
        self.previewImageView.isHidden = !title.isEmpty
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

}
