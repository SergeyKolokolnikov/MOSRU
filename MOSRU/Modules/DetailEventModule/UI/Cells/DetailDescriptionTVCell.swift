
import UIKit

class DetailDescriptionTVCell: UITableViewCell {

    static let identifier = "DetailDescriptionTVCell"
    var handler: (()->Void)?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setTitle("Читать полностью ", for: .normal)
        button.setTitle("Свернуть", for: .selected)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

        button.addTarget(self, action: #selector(moreButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   // MARK: - lifecycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        self.selectionStyle = .none

        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subtitleLabel)
        self.contentView.addSubview(moreButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true

        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: -14).isActive = true
        moreButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        moreButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true

    }
        
    private func checkNeedMoreButton(_ label: UILabel) {
        
        guard let text = label.text else {return}
        guard let font = label.font else {return}
        
        self.moreButton.isHidden = true

        let rect = CGSize(width: UIScreen.main.bounds.width - 32, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = text.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        let lines = Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
        if lines > 10 {
            self.moreButton.isHidden = false
        }

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.handler = nil
    }

    // MARK: - Public
    
    func prepare(title: String, subtitle: String, expand: Bool, subtitleAttributedString: NSAttributedString? = nil) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle.htmlToString
        self.moreButton.isSelected = expand
        self.subtitleLabel.numberOfLines = expand ? 0:10
        self.checkNeedMoreButton(subtitleLabel)

    }
    
    @objc func moreButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        handler?()
    }

}
