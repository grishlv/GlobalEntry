import Foundation
import UIKit
import SnapKit
import Combine

final class MainViewController: UIViewController {
    
    var viewModel: MainViewModel
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Your country list"
        labelHeader.font = UIFont(name: "Inter-Bold", size: 30)
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - search bar
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        setupCustomSearchBar(searchBar)
        searchBar.barTintColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        searchBar.searchTextField.backgroundColor = UIColor(red: 238/255, green: 239/255, blue: 244/255, alpha: 1)
        searchBar.tintColor = UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 1)
        searchBar.backgroundImage = UIImage()
        searchBar.setImage(UIImage(named: "ic_clear"), for: .clear, state: .normal)
        view.addSubview(searchBar)
        return searchBar
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
    
    //MARK: - filter button
    private lazy var filterButton: UIButton = {
        let filterButton = UIButton()
        filterButton.setImage(UIImage(named: "filter"), for: .normal)
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        filterButton.tintColor = UIColor.black
        view.addSubview(filterButton)
        return filterButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        //Should refactor this!
//        NotificationCenter.default.addObserver(self, selector: #selector(updateFilter), name: NSNotification.Name("FiltersApplied"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("passportSelectionChanged"), object: nil)
    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        bindViewModel()
        loadContryData()
        setupTableView()
        setupLabelHeader()
        setupSearchBar()
        setupFilterButton()
        hideKeyboardWhenTappedAround()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.$filteredFeatures
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    //MARK: - upload data for the first time
    private func loadContryData() {
        if let passportCountry = UserDefaults.standard.string(forKey: "passportCountry") {
            viewModel.loadCountryData(passportCountry)
        }
    }
    
    //MARK: - reload data when user changes his passport
    @objc func reloadData(notification: NSNotification) {
        if let passportCountry = notification.object as? String {
            viewModel.loadCountryData(passportCountry)
            tableView.reloadData()
        }
    }
    
    //MARK: - apply filters
    @objc func updateFilter(notification: NSNotification) {
        if let filters = notification.userInfo?["filters"] as? Filter {
            viewModel.applyFilters(filters)
        }
    }
    
    //MARK: - setup table view
    private func setupTableView() {
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(searchBar.safeAreaLayoutGuide.snp.bottomMargin)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        })
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
    
    //MARK: - setup search bar
    private func setupSearchBar() {
        searchBar.snp.makeConstraints({ make in
            make.top.equalTo(labelHeader.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - setup filter button
    private func setupFilterButton() {
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(30)
        }
    }
    
    @objc func filterButtonTapped() {
        let filterVC = FilterViewController()
        filterVC.filters = viewModel.filters
        navigationController?.present(filterVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.filteredFeatures.count
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
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let feature = viewModel.filteredFeatures[indexPath.section]
        let tapGestureEmpty = UITapGestureRecognizer(target: self, action: #selector(heartIconTapped))
        let tapGestureFilled = UITapGestureRecognizer(target: self, action: #selector(heartIconTapped))
        
        cell.configureCell(feature: feature, destination: feature.destination, requirement: feature.requirement)
        cell.uniqueId = feature.id
        cell.heartImageView.addGestureRecognizer(tapGestureEmpty)
        cell.filledHeartImageView.addGestureRecognizer(tapGestureFilled)
        cell.heartImageView.tag = indexPath.section
        cell.filledHeartImageView.tag = indexPath.section
        
        viewModel.imageService.getImage(for: feature, uniqueId: feature.id) { [weak cell] (id, image) in
            DispatchQueue.main.async {
                if cell?.uniqueId == id {
                    cell?.updateImage(image: image)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let feature = viewModel.filteredFeatures[indexPath.section]
        let cardVM = CardViewModel(imageURL: feature.imageURL)
        let cardVC = CardViewController(viewModel: cardVM, destinationText: feature.destination, requirementText: feature.requirement, englishSkills: feature.english)
        navigationController?.pushViewController(cardVC, animated: true)
    }
    
    @objc func heartIconTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        
        // Notify ViewModel to toggle favorite status
        viewModel.toggleFavorite(at: index)

        // Update UI for the heart icon in the cell
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: index)) as? MainTableViewCell {
            let feature = viewModel.filteredFeatures[index]
            cell.heartImageView.isHidden = feature.isFavorite
            cell.filledHeartImageView.isHidden = !feature.isFavorite
        }
        
        // Haptic feedback
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterFeatures(with: searchText)
    }
}

//MARK: - setup custom UI to search bar
extension MainViewController {
    
    func setupCustomSearchBar(_ searchBar: UISearchBar) {
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            
            //setup color to search icon
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 1)
            }
            
            //setup color to clear button
            if let clearButton = textfield.value(forKey: "clearButton") as? UIButton {
                clearButton.setImage(clearButton.currentImage?.withRenderingMode(.alwaysTemplate), for: .normal)
                clearButton.tintColor = UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 0.5)
            }
            
            //setup color and font conf to text
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 1),
                .font: UIFont(name: "Inter-Medium", size: 16) ?? 0
            ]
            textfield.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
            textfield.textColor = UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 1)
        }
    }
}

//MARK: - hide keyboard on tap everywhere
extension MainViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
