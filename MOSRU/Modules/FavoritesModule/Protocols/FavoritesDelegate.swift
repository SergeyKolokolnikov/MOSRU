
import Foundation

protocol FavoritesDelegate {
    func getEnevts(_ completion: @escaping ([Event]) -> Void)
    func getCountAction() -> Int
    func getItem(_ index: Int) -> Event
}
