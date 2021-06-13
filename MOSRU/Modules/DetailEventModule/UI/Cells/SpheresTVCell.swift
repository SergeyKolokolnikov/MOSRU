
import UIKit

class SpheresTVCell: UITableViewCell {
    
    static let identifier = "SpheresTVCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.text = "Сферы"
        return label
    }()

    private lazy var spheresLabel: UILabel = {
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
        self.contentView.addSubview(spheresLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true

        spheresLabel.translatesAutoresizingMaskIntoConstraints = false
        spheresLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        spheresLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        spheresLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
        spheresLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.spheresLabel.text = ""
    }
    
    func prepare(_ spheres: [Sphere]) {
        var sphereTitlesArray = [String]()
        for item in spheres {
            sphereTitlesArray.append(item.title)
        }

        self.spheresLabel.text = sphereTitlesArray.joined(separator: ", ")
    }
    
}
