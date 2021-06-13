
import UIKit

class MainModuleVM: MainModuleDelegate {
    
    private var actions: [Action]
    private var actionsSpeech: [Action]
    private var filter: String
    private var selectedDateForRange: Date?
    
    private var dateFormatterDay: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()

    private var dateFormatterMonth: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()

    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
    
    private var params: [String: Any] = {
        let fields = "id,title,label,image,date_from,date_to,kind,free,tags,spheres,types,text"
        let per_page = "20"
        let sort = "occurrences.date_to,-occurrences.date_from"
        let expand = "tags,spheres,types"
        let params = ["expand": expand, "fields": fields, "per-page": per_page, "sort": sort]
        return params
    }()
    
    private var numberForDisplay: Int = {
        if UIScreen.main.bounds.height < 600 {
            return 3
        }
        if UIScreen.main.bounds.height < 800 {
            return 4
        }
        
        return 5
    }()
    
    init() {
                
        self.actions = [Action]()
        self.actionsSpeech = [Action]()
        
        let today = Date()
        let startDay = self.dateFormatter.string(from: today.startOfDay)
        let endDay = self.dateFormatter.string(from: today.endOfDay)
        self.filter = "{\">=occurrences.date_from\":\"\(startDay)\",\"<=occurrences.date_to\":\"\(endDay)\"}"
        
        self.actions.append(self.generateAction(title: "Научиться чему-то новому и интересному", params: self.params))
        self.actions.append(self.generateAction(title: "Насладиться культурным досугом", params: self.params))
        self.actions.append(self.generateAction(title: "Отдохнуть от суеты на свежем воздухе", params: self.params))
        self.actions.append(self.generateAction(title: "Поднять настроение активным отдыхом", params: self.params))
        self.actions.append(self.generateAction(title: "Провести поэтический вечер с семьей", params: self.params))
        self.actions.append(self.generateAction(title: "Покататься на велосипедах с детьми", params: self.params))
        self.actions.append(self.generateAction(title: "Сходить на пикник с друзьями", params: self.params))
        self.actions.append(self.generateAction(title: "Потренироваться в парке", params: self.params))
        self.actions.append(self.generateAction(title: "Попробовать себя в марафоне", params: self.params))
        self.actions.append(self.generateAction(title: "Провести время с пользой для здоровья", params: self.params))
        self.actions.append(self.generateAction(title: "Посетить спектакль", params: self.params))
        self.actions.append(self.generateAction(title: "Прикоснуться к истории", params: self.params))
        self.actions.append(self.generateAction(title: "Познакомиться с музейными экспонатами", params: self.params))
        self.actions.append(self.generateAction(title: "Посетить популярные достопримечательности", params: self.params))

        NotificationCenter.default.addObserver(forName: .updateRecognizedText, object: nil, queue: .main) {[weak self] (notification) in
            guard let self = self else {return}
            if let userInfo = notification.userInfo, let text = userInfo["text"] as? String {
                if var first = self.actionsSpeech.first {
                    first.title = text
                    self.actionsSpeech[0] = first
                }
            }
        }
        
    }
    
    func shuffleActions() {
        self.actions = self.actions.shuffled()
    }
    
    func getCountAction() -> Int {
        if self.actions.count > numberForDisplay {
            return self.actions.prefix(numberForDisplay).count
        }
        return self.actions.count
    }
    
    func getCountActionsSpeech() -> Int {
        return self.actionsSpeech.count
    }
    
    func getItem(_ index: Int) -> Action {
        return self.actions[index]
    }
    
    func getItemSpeech(_ index: Int) -> Action {
        return self.actionsSpeech[index]
    }
    
    func removeItemSpeech(_ index: Int) {
        self.actionsSpeech.remove(at: index)
    }
    
    func setRange(_ index: Int) {
        
        var startDay = ""
        var endDay = ""
        if index == 0 {
            let today = Date()
            self.selectedDateForRange = today
            startDay = self.dateFormatter.string(from: today.startOfDay)
            endDay = self.dateFormatter.string(from: today.endOfDay)
            self.filter = "{\">=occurrences.date_from\":\"\(startDay)\",\"<=occurrences.date_to\":\"\(endDay)\"}"
            //print("сегодня")
        }
        if index == 1 {
            let tomorrow = Calendar.current.dayAfter(Date(), days: 1)
            self.selectedDateForRange = tomorrow
            startDay = self.dateFormatter.string(from: tomorrow.startOfDay)
            endDay = self.dateFormatter.string(from: tomorrow.endOfDay)
            self.filter = "{\">=occurrences.date_from\":\"\(startDay)\",\"<=occurrences.date_to\":\"\(endDay)\"}"
            //print("завтра")
        }
        
                
    }
    
    func setDateFoRange(_ value: Date) {
        let startDay = self.dateFormatter.string(from: value.startOfDay)
        let endDay = self.dateFormatter.string(from: value.endOfDay)
        print("startDay: \(startDay), endDay: \(endDay)")
        self.selectedDateForRange = value
        self.filter = "{\">=occurrences.date_from\":\"\(startDay)\",\"<=occurrences.date_to\":\"\(endDay)\"}"

    }
    
    func getDaysForChoose() -> [Day] {
        var result = [Day]()
        
        for i in 2 ... 30 {
            let date = Calendar.current.dayAfter(Date(), days: i)
            let monthString = dateFormatterMonth.string(from: date)
            let dayString = dateFormatterDay.string(from: date)
            let day = Day(title: dayString, subtitle: monthString, date: date)
            result.append(day)
        }
        
        return result
    }
    
    func getDayFoRange() -> Day? {
        if let selectedDateForRange = self.selectedDateForRange {
            let monthString = dateFormatterMonth.string(from: selectedDateForRange)
            let dayString = dateFormatterDay.string(from: selectedDateForRange)
            let day = Day(title: dayString, subtitle: monthString, date: selectedDateForRange)
            return day

        }
        return nil
    }
    
    func startSpeech() {
        self.actionsSpeech.removeAll()
        let action = Action(title: "", params: self.params)
        self.actionsSpeech.append(action)
    }
    
    func getFilter() -> String {
        return self.filter
    }
    
    func recognizeHandler() {
        //print("recognizeHandler")
        if var first = self.actionsSpeech.first {
            first.params["spheres"] = self.getSpheresFilter(first.title)
            first.params["types"] = self.getTypesFilter(first.title)
            first.params["places"] = self.getPlacesFilter(first.title)
            self.actionsSpeech[0] = first
        }
    }
    
    //MARK: - Private
    private func generateAction(title: String, params: [String: Any]) -> Action {
        
        var action = Action(title: title, params: params)
        action.params["spheres"] = self.getSpheresFilter(title)
        action.params["types"] = self.getTypesFilter(title)
        action.params["places"] = self.getPlacesFilter(title)
        return action
    }
    
    private func getSpheresFilter(_ text: String) -> String {
        //print("getSpheresFilter=\(text)")
        let words = text.components(separatedBy: " ")
        var result = [String]()
        let spheres = Array(CommonDictionary.sphere.keys)
        
        for word in words {
            if word.count < 3 {
                continue
            }
            for sphere in spheres {
                if word.lowercased().contains(sphere) {
                    if let sphereValue = CommonDictionary.sphere[sphere] {
                        result.append(sphereValue)
                    }
                }
            }
        }
        
        if let first = result.first {
            //print("spheres=\(first)")
            return first
        }
        
        return ""
    }

    private func getTypesFilter(_ text: String) -> String {
        
        //print("getTypesFilter=\(text)")
        let words = text.components(separatedBy: " ")
        var result = [String]()
        let types = Array(CommonDictionary.types.keys)
        
        for word in words {
            if word.count < 3 {
                continue
            }
            for type in types {
                if word.lowercased().contains(type) {
                    if let typeValue = CommonDictionary.types[type] {
                        result.append(typeValue)
                    }
                }
            }
        }
        
        if let first = result.first {
            //print("types=\(first)")
            return first
        }
        
        return ""
    }

    private func getPlacesFilter(_ text: String) -> String {
        
        //print("getPlacesFilter=\(text)")
        let words = text.components(separatedBy: " ")
        var result = [String]()
        let places = Array(CommonDictionary.places.keys)
        
        for word in words {
            if word.count < 3 {
                continue
            }
            for place in places {
                if word.lowercased().contains(place) {
                    if let placeValue = CommonDictionary.types[place] {
                        result.append(placeValue)
                    }
                }
            }
        }
        //print("places=\(result.joined(separator: ","))")
        return result.joined(separator: ",")
    }

}
