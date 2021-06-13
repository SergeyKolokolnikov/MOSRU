
import UIKit

class TagsTVCell: UITableViewCell {
    
    static let identifier = "TagsTVCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.text = "Тэги"
        return label
    }()

    private lazy var tagsLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
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
        self.accessoryType = .none
        self.selectionStyle = .none
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(tagsLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true

        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        tagsLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        tagsLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        tagsLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
        tagsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.tagsLabel.text = ""
    }
    
    func prepare(_ tags: [Tag]) {
        var tagTitlesArray = [String]()
        for tag in tags {
            tagTitlesArray.append(tag.title)
        }

        self.tagsLabel.text = tagTitlesArray.joined(separator: ", ")
    }
    
}
