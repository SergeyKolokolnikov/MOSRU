import UIKit

class CalendarTVCell: UITableViewCell {

    static let identifier = "CalendarTVCell"
    
    var сalendarCVC = CalendarCVC()
    
    // MARK: - Lyfecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        self.selectionStyle = .none
        self.contentView.addSubview(сalendarCVC.view!)
        
        сalendarCVC.view!.translatesAutoresizingMaskIntoConstraints = false
        сalendarCVC.view!.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        сalendarCVC.view!.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0).isActive = true
        сalendarCVC.view!.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0).isActive = true
        сalendarCVC.view!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        сalendarCVC.view!.heightAnchor.constraint(equalToConstant: 64).isActive = true

    }
    
    func update(days: [Day]) {
        self.сalendarCVC.update(days: days)
    }

    func updateSelectedDate(day: Day) {
        self.сalendarCVC.updateSelectedDate(day: day)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
