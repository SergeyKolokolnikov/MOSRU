
import UIKit

class DetailEventVC: UIViewController {
    
    private var viewModel: DetailEventDelegate?

    private var expands: [IndexPath] = {
        var indexPaths = [IndexPath]()
        //indexPaths.append(IndexPath(row: 0, section: 0))
        return indexPaths
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.rowHeight = 71
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailDescriptionTVCell.self, forCellReuseIdentifier: DetailDescriptionTVCell.identifier)
        tableView.register(TagsTVCell.self, forCellReuseIdentifier: TagsTVCell.identifier)
        tableView.register(SpheresTVCell.self, forCellReuseIdentifier: SpheresTVCell.identifier)

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    private lazy var priceView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.isHidden = true
        return view
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.frame.origin.x = 0
        backButton.frame.origin.y = 0
        backButton.frame.size.width = 100
        backButton.frame.size.height = 50
        backButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        backButton.contentMode = .left
        backButton.contentHorizontalAlignment = .left

        backButton.imageView?.contentMode = .scaleAspectFit

        backButton.setImage(UIImage(named: "backButtonWhite"), for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        return backButton
    }()

    private lazy var bookmarButton = BookmarkButton()

    private var headerView: HeaderView!
    
    convenience init(viewModel: DetailEventDelegate) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
    }

    // MARK: - Setups
    private func setupView() {
        guard let event = self.viewModel?.getEvent() else {return}
        
        let previewImageString = self.viewModel?.getPreviewImage() ?? ""
        let headerFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 264)
        if !previewImageString.isEmpty {
            headerView = HeaderView(frame: headerFrame, imageUrl: previewImageString)
        }
        self.priceView.isHidden = !event.free
        if event.free {
            self.priceLabel.text = "Бесплатно"
        }
        bookmarButton.setInformation(id: event.id)
        tableView.tableHeaderView = headerView
    }
    
    private func setupConstraint() {
    
        backButton.frame = CGRect(x: 20, y: 44, width: 100, height: 44)
        bookmarButton.frame = CGRect(x: UIScreen.main.bounds.width - 60, y: 44, width: 44, height: 44)
        view.addSubview(tableView)
        view.addSubview(backButton)
        view.addSubview(bookmarButton)
        
        headerView.addSubview(priceView)
        priceView.addSubview(priceLabel)

        priceView.translatesAutoresizingMaskIntoConstraints = false
        priceView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12).isActive = true
        priceView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20).isActive = true
        priceView.heightAnchor.constraint(equalToConstant: 32).isActive = true

        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 2).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: priceView.leftAnchor, constant: 16).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: priceView.rightAnchor, constant: -16).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -2).isActive = true

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

    }

    @objc func backAction(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }

    func expand(_ indexPath: IndexPath) {
        
        if expands.contains(indexPath) {
            expands.removeAll { (index) -> Bool in
                index == indexPath
            }
        } else {
            expands.append(indexPath)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: -
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.keyboardDismissMode = .onDrag
        if headerView != nil {
            headerView.scrollViewDidScroll(scrollView: scrollView)
        }
        self.backButton.isHidden = scrollView.contentOffset.y > 0
        self.bookmarButton.isHidden = scrollView.contentOffset.y > 0
    }

}

// MARK: -
extension DetailEventVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailDescriptionTVCell.identifier, for: indexPath) as! DetailDescriptionTVCell
            guard let event = self.viewModel?.getEvent() else {return UITableViewCell()}

            cell.prepare(title: event.title, subtitle: event.text, expand: expands.contains(indexPath))
            cell.handler = {
                self.expand(indexPath)
            }

            return cell
        }

        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TagsTVCell.identifier, for: indexPath) as! TagsTVCell
            guard let event = self.viewModel?.getEvent() else {return UITableViewCell()}
            cell.prepare(event.tags)
            return cell
        }

        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SpheresTVCell.identifier, for: indexPath) as! SpheresTVCell
            guard let event = self.viewModel?.getEvent() else {return UITableViewCell()}
            cell.prepare(event.spheres)
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            self.expand(indexPath)
        }
    }

}
