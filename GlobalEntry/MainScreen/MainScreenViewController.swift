//
//  MainScreenViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 25.06.23.
//

import Foundation
import UIKit
import SnapKit

final class MainScreenViewController: UIViewController {
    
    var labelCountry: String?
    var viewModel: ChoosePassportViewModel
    private var features: [Feature] = []
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Your country list"
        labelHeader.font = UIFont(name: "Inter-Bold", size: 28)
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        return labelHeader
    }()

    //MARK: - search bar
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        //custom UI
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
        tableView.rowHeight = 60.0
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelHeader()
        setupLabelCountry()
        setupSearchBar()
        setupTableView()
        
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        
        if let passport = labelCountry {
            if let country = viewModel.passports?.filter("passport == %@", passport).first {
                features = Array(country.features)
            }
            tableView.reloadData()
        }
    }
    
    //MARK: - setup label header
    private func setupLabelHeader() {
        
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(75)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - setup search bar
    private func setupSearchBar() {
        
        //constraints
        searchBar.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(120)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - setup label country
    private func setupLabelCountry() {
        
        if let passportName = labelCountry {
            let label = UILabel()
            label.text = passportName
            label.textColor = .black
            label.textAlignment = .center
            label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
            label.center = view.center
            view.addSubview(label)
            
            //constraints
            label.snp.makeConstraints({ make in
                make.top.equalToSuperview().inset(160)
                make.leading.equalToSuperview().inset(20)
                make.width.equalTo(345)
                make.height.equalTo(48)
            })
        }
    }
    
    //MARK: - setup table view
    private func setupTableView() {
        
        //constraints
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(searchBar.snp.bottom).inset(-20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.width.equalTo(345)
            make.height.equalTo(700)
        })
    }
    
    func tabBarSetup() {
        
        let tabBarController = TabController()
        
        // Create your view controllers for the tab bar
        let firstVC = MainScreenViewController(viewModel: ChoosePassportViewModel.init())
        let secondVC = FavouritesViewController()
        let thirdVC = MapViewController()
        let fourthVC = ProfileViewController()

        tabBarController.viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
    }
    
    // Initialize the view controller with the view model
    init(viewModel: ChoosePassportViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return features.count
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let feature = features[indexPath.section]
        
        cell.textLabel?.text = "\(feature.destination): \(feature.requirement)"
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = UIFont(name: "Inter-Medium", size: 18)
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell.clipsToBounds = true
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let feature = features[section]
        return feature.destination
    }
}


//MARK: - setup custom UI to search bar
extension MainScreenViewController {
    
    func setupCustomSearchBar(_ searchBar: UISearchBar) {
        //setup custom UI
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
                .font: UIFont(name: "Inter-Medium", size: 16)
            ]
            textfield.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
            textfield.textColor = UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 1)
        }
    }
}

//MARK: - hide keyboard on tap everywhere
extension MainScreenViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChoosePassportViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
