import UIKit
import SnapKit
import Combine

final class FavoritesViewController: UIViewController {
    
    var viewModel: FavoritesViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Your favourite list"
        labelHeader.font = UIFont(name: "Inter-Bold", size: 30)
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - table view
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 110.0
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        bindViewModel()
        setupLabelHeader()
        setupTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.dataModel.$favoriteFeatures
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
       
    //MARK: - setup label header
    private func setupLabelHeader() {
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(90)
            make.leading.equalToSuperview().inset(20)
            make.trailing.lessThanOrEqualToSuperview().inset(20)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - setup table view
    private func setupTableView() {
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(labelHeader.safeAreaLayoutGuide.snp.bottomMargin)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataModel.favoriteFeatures.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    @objc func heartIconTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
//        viewModel.toggleFavorite(at: index)
        let indexPath = IndexPath(row: 0, section: index)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let feature = viewModel.dataModel.favoriteFeatures[indexPath.section]
        let tapGestureFilled = UITapGestureRecognizer(target: self, action: #selector(heartIconTapped))
        
        cell.configureCell(feature: feature, destination: feature.destination, requirement: feature.requirement)
        cell.selectionStyle = .none
        cell.favoriteId = feature.id
        cell.filledHeartImageView.addGestureRecognizer(tapGestureFilled)
        cell.filledHeartImageView.tag = indexPath.section
        
        viewModel.imageService.getImage(for: feature, uniqueId: feature.id) { [weak cell] (id, image) in
            DispatchQueue.main.async {
                if cell?.favoriteId == id {
                    cell?.updateImage(image: image)
                }
            }
        }
        return cell
    }
}
