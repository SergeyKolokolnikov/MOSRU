
import UIKit
import AVFoundation
import Speech

class MainModuleVC: UIViewController {
    
    private var viewModel: MainModuleDelegate?
    private var speechRec = SpeechRec()
    private var showCalendar = false
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: .valueChanged)
        return refreshControl
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Я хочу"
        textField.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        textField.isEnabled = false
        return textField
    }()

    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setTitle("нажми, чтобы обновить список", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return button
    }()

    private lazy var microphoneButton: SpeechButton = {
        let button = SpeechButton()
        let image = UIImage(named: "microphoneIcon")
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 28/255, green: 134/255, blue: 254/255, alpha: 1)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = 0.5
        label.text = "нажми, чтобы обновить список"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.rowHeight = 71
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ActionTVCell.self, forCellReuseIdentifier: ActionTVCell.identifier)
        tableView.register(SpeechTVCell.self, forCellReuseIdentifier: SpeechTVCell.identifier)
        tableView.register(CalendarTVCell.self, forCellReuseIdentifier: CalendarTVCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Сегодня", "Завтра", "Позднее"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.layer.cornerRadius = 5
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangeValue(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    convenience init(viewModel: MainModuleDelegate) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Чего тебе хочется?"
        
        if CacheService.shared.favorites.count > 0 {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Избранное", style: .plain, target: self, action: #selector(favoritesTapped(_:)))
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        
        self.refreshButton.addTarget(self, action: #selector(refreshButtonTapped(_ :)), for: .touchUpInside)
        self.microphoneButton.addTarget(self, action: #selector(microphoneButtonDown(_ :)), for: .touchDown)
        self.microphoneButton.addTarget(self, action: #selector(microphoneButtonUp(_ :)), for: .touchUpInside)
        
        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        tableFooterView.addSubview(self.refreshButton)
        self.tableView.tableFooterView = tableFooterView

        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        tableHeaderView.addSubview(self.segmentedControl)
        self.tableView.tableHeaderView = tableHeaderView

        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.segmentedControl.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 16).isActive = true
        self.segmentedControl.leftAnchor.constraint(equalTo: tableHeaderView.leftAnchor, constant: 16).isActive = true
        self.segmentedControl.rightAnchor.constraint(equalTo: tableHeaderView.rightAnchor, constant: -16).isActive = true
        self.segmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true

        self.refreshButton.translatesAutoresizingMaskIntoConstraints = false
        self.refreshButton.topAnchor.constraint(equalTo: tableFooterView.topAnchor, constant: 0).isActive = true
        self.refreshButton.leftAnchor.constraint(equalTo: tableFooterView.leftAnchor, constant: 16).isActive = true
        self.refreshButton.rightAnchor.constraint(equalTo: tableFooterView.rightAnchor, constant: -16).isActive = true
        self.refreshButton.heightAnchor.constraint(equalToConstant: 32).isActive = true

        //self.view.backgroundColor = UIColor.white
        //self.view.addSubview(segmentedControl)
        //self.view.addSubview(titleLabel)
        self.view.addSubview(tableView)
        self.view.addSubview(microphoneButton)
        
        //self.tableView.addSubview(self.refreshControl)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

        self.microphoneButton.translatesAutoresizingMaskIntoConstraints = false
        self.microphoneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.microphoneButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -64).isActive = true
        self.microphoneButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.microphoneButton.widthAnchor.constraint(equalToConstant: 80).isActive = true

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -5 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else if velocity > 5 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
    }
    
    // MARK: - Action
    @objc func segmentedControlChangeValue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 2 {
            self.showCalendar = true
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        } else {
            self.showCalendar = false
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            self.viewModel?.setRange(sender.selectedSegmentIndex)
        }
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }

    @objc func refreshButtonTapped(_ sender: UIButton) {
        self.viewModel?.shuffleActions()
        self.tableView.reloadData()
    }

    @objc func microphoneButtonUp(_ sender: UIButton) {
        if self.speechRec.recognizedText.isEmpty {
            self.viewModel?.removeItemSpeech(0)
            self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
        if self.speechRec.isRunning {
            self.speechRec.stop()
        }
        self.viewModel?.recognizeHandler()
    }

    @objc func microphoneButtonDown(_ sender: UIButton) {
        self.checkPermissions()
        self.viewModel?.startSpeech()
        self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        if !self.speechRec.isRunning {
            self.speechRec.start()
        }
    }
    
    @objc func favoritesTapped(_ sender: UIBarButtonItem) {
        let vm = FavoritesVM()
        let vc = FavoritesVC(viewModel: vm)
        vc.title = "Избранное"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func checkPermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    break
                case .denied:
                    self.microphoneButton.isSelected = false
                    let alert = UIAlertController(title: "Доступ запрещен", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    break
                case .restricted:
                    self.microphoneButton.isSelected = false
                    let alert = UIAlertController(title: "Доступ ограничен", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    break
                case .notDetermined:
                    self.microphoneButton.isSelected = false
                    let alert = UIAlertController(title: "Устройство не найдено", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    break
                @unknown default:
                    print("default")
                }
            }
        }
    }
}

// MARK: -
extension MainModuleVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 && self.showCalendar {
            return 1
        }

        if section == 1 {
            return self.viewModel?.getCountActionsSpeech() ?? 0
        }
        
        if section == 2 {
            return self.viewModel?.getCountAction() ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = CalendarTVCell()
            if let selectedDay = self.viewModel?.getDayFoRange() {
                cell.updateSelectedDate(day: selectedDay)
            }
            
            if let days = self.viewModel?.getDaysForChoose() {
                cell.update(days: days)
            }
            
            cell.сalendarCVC.completionHandler = { [weak self] date in
                guard let self = self else { return }
                self.viewModel?.setDateFoRange(date)
                //self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
            return cell
        }

        if indexPath.section == 1 {
            let cell = SpeechTVCell()
            return cell
        }

        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ActionTVCell.identifier, for: indexPath) as! ActionTVCell
            guard let action = self.viewModel?.getItem(indexPath.row) else { return UITableViewCell() }
            cell.prepare(action)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            if let action = self.viewModel?.getItemSpeech(indexPath.row) {
                let filter = self.viewModel?.getFilter() ?? ""
                let vm = FeedEventVM(action: action, filter: filter)
                let vc = FeedEventVC(viewModel: vm)
                vc.title = action.title
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        if indexPath.section == 2 {
            if let action = self.viewModel?.getItem(indexPath.row) {
                let filter = self.viewModel?.getFilter() ?? ""
                let vm = FeedEventVM(action: action, filter: filter)
                let vc = FeedEventVC(viewModel: vm)
                vc.title = action.title
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if editingStyle == .delete {
                self.viewModel?.removeItemSpeech(indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                
            }
        }
    }
    
}

// MARK: -
extension MainModuleVC: SpeechRecDelegate {
    func recognizedTextDidChange(speechRec: SpeechRec, text: String) {
        print(text)
    }
}
