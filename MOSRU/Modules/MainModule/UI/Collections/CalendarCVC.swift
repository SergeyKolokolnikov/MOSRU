
import UIKit

class CalendarCVC: UICollectionViewController {
    
    var completionHandler: ((Date) -> Void)?
    var days: [Day] = [Day]()
    var daySelected: Day?
    
    override func loadView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 48, height: 48)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.isPrefetchingEnabled = true
        collectionView.isDirectionalLockEnabled = false
        collectionView.scrollsToTop = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CalendarCVCell.self, forCellWithReuseIdentifier: CalendarCVCell.identifier)
        collectionView.register(CalendarIconCVCell.self, forCellWithReuseIdentifier: CalendarIconCVCell.identifier)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func update(days: [Day]) {
        self.days = days
        self.collectionView.reloadData()
    }
    
    func updateSelectedDate(day: Day) {
        self.daySelected = day
        for (index, item) in self.days.enumerated() {
            if item.date == day.date {
                self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.days.count
        }
        return 0
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCVCell.identifier, for: indexPath) as? CalendarCVCell {
                let day = days[indexPath.row]
                cell.prepare(title: day.title, subtitle: day.subtitle)
                if let daySelected = self.daySelected {
                    cell.setSelected(daySelected.date == day.date)
                }

                return cell
            }
            
        }
        return UICollectionViewCell()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let day = days[indexPath.row]
            self.daySelected = day
            for (index, _) in self.days.enumerated() {
                self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            }

            self.completionHandler?(day.date)
        }
    }
    
}
