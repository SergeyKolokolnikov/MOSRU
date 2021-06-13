
import UIKit

class FeedEventVC: UIViewController {

    private var viewModel: FeedEventDelegate?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.rowHeight = 71
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventTVCell.self, forCellReuseIdentifier: EventTVCell.identifier)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "По вашему запросу ничего не найдено 😔"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.isHidden = true
        return label
    }()

    convenience init(viewModel: FeedEventDelegate) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = " "
        self.viewModel?.getEnevts({ [weak self] (events) in
            guard let self = self else {return}
            self.tableView.reloadData()
            self.infoLabel.isHidden = events.count > 0
        })
        
        self.view.addSubview(tableView)
        self.view.addSubview(infoLabel)

        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        self.infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

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

}

// MARK: -
extension FeedEventVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getCountAction() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTVCell.identifier, for: indexPath) as! EventTVCell
        guard let event = self.viewModel?.getItem(indexPath.row) else { return UITableViewCell() }
        cell.prepare(event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let event = self.viewModel?.getItem(indexPath.row) else { return }
        let vm = DetailEventVM(event: event)
        let vc = DetailEventVC(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
 
    }

}
