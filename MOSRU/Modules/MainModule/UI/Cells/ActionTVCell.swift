
import UIKit

class ActionTVCell: UITableViewCell {
    
    static let identifier = "ActionTVCell"
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.backgroundColor = UIColor(red: 28/255, green: 134/255, blue: 254/255, alpha: 1)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        //label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - lifecycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .default
        
        self.contentView.addSubview(previewImageView)
        self.contentView.addSubview(titleLabel)
        
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        previewImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
        previewImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        previewImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        previewImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: previewImageView.rightAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.previewImageView.image = nil
    }
    
    func prepare(_ action: Action) {
        self.titleLabel.text = action.title
    }
    
}
