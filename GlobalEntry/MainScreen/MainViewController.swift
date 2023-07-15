//
//  MainScreenViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 25.06.23.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import FirebaseStorage
import Kingfisher
import RealmSwift

final class MainViewController: UIViewController {
    
    var labelCountry: String?
    var features: [Feature] = []
    var filteredFeatures: [Feature] = []
    
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
    
    //MARK: - slider filter
    private lazy var filterSlider: UIImageView = {
        let filterSlider = UIImageView()
        filterSlider.image = UIImage(named: "filter")
        view.addSubview(filterSlider)
        return filterSlider
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
        tableView.rowHeight = 110.0
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelHeader()
        setupSearchBar()
        setupTableView()
        setupFilterSlider()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        filteredFeatures = features
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData), name: NSNotification.Name("FavouriteStatusChanged"), object: nil)
    }
    
    // Method to reload table view
    @objc func reloadTableData() {
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("FavouriteStatusChanged"), object: nil)
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
            make.top.equalTo(labelHeader.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(10)
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - setup table view
    private func setupTableView() {
        
        //constraints
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(searchBar.safeAreaLayoutGuide.snp.bottomMargin)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
    
    //MARK: - setup filter slider
    private func setupFilterSlider() {
        
        //constraints
        filterSlider.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(90)
            make.trailing.equalTo(tableView.snp.trailing)
            make.width.equalTo(filterSlider)
            make.height.equalTo(filterSlider)
        })
    }
    
    init(features: [Feature]) {
        self.features = features
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFeatures.count
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let feature = filteredFeatures[indexPath.section]
        let tapGestureEmpty = UITapGestureRecognizer(target: self, action: #selector(heartIconTapped))
        let tapGestureFilled = UITapGestureRecognizer(target: self, action: #selector(heartIconTapped))
        
        cell.uniqueId = feature.id
        cell.configureCell(feature: feature, destination: feature.destination, requirement: feature.requirement)
        cell.heartImageView.addGestureRecognizer(tapGestureEmpty)
        cell.filledHeartImageView.addGestureRecognizer(tapGestureFilled)
        cell.heartImageView.tag = indexPath.section
        cell.filledHeartImageView.tag = indexPath.section

        // If the image URL is not empty, download the image.
        if !feature.imageURL.isEmpty {
            let storageRef = Storage.storage().reference().child("images/\(feature.imageURL).jpg")
            storageRef.downloadURL { [weak cell] url, error in
                guard let imageURL = url, let strongCell = cell, error == nil else {
                    print("Failed to get image URL: \(error?.localizedDescription ?? "")")
                    return
                }
                KingfisherManager.shared.retrieveImage(with: imageURL, options: [
                    .processor(DownsamplingImageProcessor(size: CGSize(width: 140, height: 110))),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]) { [weak cell] result in
                    guard let cell = cell else { return }
                    switch result {
                    case .success(let value):
                        // Check if the cell is still meant to display this image
                        if cell.uniqueId == feature.id {
                            DispatchQueue.main.async {
                                cell.imageView?.image = value.image
                                cell.setNeedsLayout()
                            }
                        }
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            cell.imageView?.isHidden = true
        }
        return cell
    }
    
    @objc func heartIconTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        let feature = filteredFeatures[index]
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
        
        // Access the shared instance or global variable of the Realm object
        let realm = try! Realm()
        
        // Update the "isFavorite" property of the selected feature
        try? realm.write {
            feature.isFavorite = !feature.isFavorite
        }
        
        // Get the cell associated with the tapped button
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: index)) as? MainTableViewCell else {
            return
        }
        
        // Update the icon based on the "isFavorite" property
        cell.heartImageView.isHidden = feature.isFavorite
        cell.filledHeartImageView.isHidden = !feature.isFavorite
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let feature = features[section]
        return feature.destination
    }
}

extension MainViewController: UISearchBarDelegate {
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredFeatures = features
        } else {
            filteredFeatures = features.filter { $0.destination.lowercased().starts(with: searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}

//MARK: - setup custom UI to search bar
extension MainViewController {
    
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
