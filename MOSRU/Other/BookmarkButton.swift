
import UIKit

class BookmarkButton: UIButton {
    
    private var id = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(bookmarButtonTapped(_:)), for: .touchUpInside)
        self.setImage(UIImage(named: "bookmarkBlackOff"), for: .normal)
        self.setImage(UIImage(named: "bookmarkOn"), for: .selected)
        self.backgroundColor = .white
        self.layer.cornerRadius = 22

        self.setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func bookmarButtonTapped(_ sender: UIButton) {
        self.isSelected = !self.isSelected
        self.updateFavorites(state: self.isSelected)
        NotificationCenter.default.post(name: .updateFavorites, object: self)
    }
    
    func setInformation(id: String) {
        if id.isEmpty {
            return
        }
        self.id = id
        self.updateState()
    }
    
    private func updateState() {
        self.isSelected = CacheService.shared.favorites.contains(self.id)
    }
    
    private func updateFavorites(state: Bool) {
        var favorites = CacheService.shared.favorites
        
        if state {
            favorites.append(self.id)
        } else {
            for (index, item) in favorites.enumerated().reversed() {
                if item == self.id {
                    favorites.remove(at: index)
                }
            }
        }
        
        CacheService.shared.favorites = favorites
    }
    
    private func setupObservers() {
        
        NotificationCenter.default.addObserver(forName: .updateFavorites, object: nil, queue: .main) {[weak self] (notification) in
            guard let self = self else {return}
            self.updateState()
        }
        
    }

    
}
