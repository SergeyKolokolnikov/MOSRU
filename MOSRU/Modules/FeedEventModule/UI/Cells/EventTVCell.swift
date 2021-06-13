
import UIKit
import SDWebImage

class EventTVCell: UITableViewCell {

    static let identifier = "EventTVCell"

    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()

    private var dateFormatter2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()

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

    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.text = ""
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = ""
        label.numberOfLines = 2
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.text = ""
        return label
    }()
        
    private lazy var priceView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.isHidden = true
        return view
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private lazy var tagView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor(red: 28/255, green: 134/255, blue: 254/255, alpha: 1)
        return view
    }()

    private lazy var tagLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        //label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private lazy var bookmarButton = BookmarkButton()
    
    // MARK: - lifecycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(shadowView)
        self.contentView.addSubview(coverView)
        coverView.addSubview(previewImageView)
        coverView.addSubview(priceView)
        priceView.addSubview(priceLabel)
        coverView.addSubview(locationLabel)
        coverView.addSubview(titleLabel)
        coverView.addSubview(subtitleLabel)
        coverView.addSubview(tagView)
        coverView.addSubview(bookmarButton)
        tagView.addSubview(tagLabel)

        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        shadowView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
        shadowView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        coverView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
        coverView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        coverView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        coverView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.topAnchor.constraint(equalTo: coverView.topAnchor).isActive = true
        previewImageView.rightAnchor.constraint(equalTo: coverView.rightAnchor).isActive = true
        previewImageView.leftAnchor.constraint(equalTo: coverView.leftAnchor).isActive = true
        previewImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true

        priceView.translatesAutoresizingMaskIntoConstraints = false
        priceView.bottomAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: -8).isActive = true
        priceView.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 8).isActive = true
        priceView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 2).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: priceView.leftAnchor, constant: 6).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: priceView.rightAnchor, constant: -6).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -2).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: coverView.rightAnchor, constant: -16).isActive = true

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 16).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: coverView.rightAnchor, constant: -16).isActive = true

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 16).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: coverView.rightAnchor, constant: -16).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: coverView.bottomAnchor, constant: -16).isActive = true

        tagView.translatesAutoresizingMaskIntoConstraints = false
        tagView.topAnchor.constraint(equalTo: coverView.topAnchor, constant: 12).isActive = true
        tagView.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 12).isActive = true
        tagView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 2).isActive = true
        tagLabel.leftAnchor.constraint(equalTo: tagView.leftAnchor, constant: 6).isActive = true
        tagLabel.rightAnchor.constraint(equalTo: tagView.rightAnchor, constant: -6).isActive = true
        tagLabel.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -2).isActive = true

        bookmarButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarButton.topAnchor.constraint(equalTo: coverView.topAnchor, constant: 12).isActive = true
        bookmarButton.rightAnchor.constraint(equalTo: coverView.rightAnchor, constant: -12).isActive = true
        bookmarButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        bookmarButton.widthAnchor.constraint(equalToConstant: 44).isActive = true

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.subtitleLabel.text = ""
        self.locationLabel.text = ""
        self.priceLabel.text = ""
        self.tagLabel.text = ""
        self.priceView.isHidden = true
        self.previewImageView.image = nil
    }
    
    func prepare(_ event: Event) {
        self.bookmarButton.setInformation(id: event.id)
        self.titleLabel.text = event.title
        let imagePath = "\(NetworkService.shared.baseURL)/\(event.image.thumb.src)"
        let imageURL = URL(string: imagePath)
        self.previewImageView.sd_setImage(with: imageURL, completed: nil)
        
        if event.free {
            self.priceLabel.text = "Бесплатно"
            self.priceView.isHidden = false
        }
        
        if let date_to = self.dateFormatter.date(from: event.date_to) {
            let date_to2 = dateFormatter2.string(from: date_to)
            self.subtitleLabel.text = "Открыто до \(date_to2)"
        }
     
        if let first = event.tags.first {
            self.tagLabel.text = "\(first.title)"
        } else {
            self.tagView.isHidden = true
        }
        
    }
    
}
