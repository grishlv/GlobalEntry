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
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        filteredFeatures = features
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
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
        let destination = feature.destination
        let requirement = feature.requirement

        let fullText = "\(destination)\nStaying: \(requirement)"

        let attributedString = NSMutableAttributedString(string: fullText)

        // Define the attributes for the whole text
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1),
            .font: UIFont(name: "Inter-Bold", size: 18)!
        ]

        // Apply the attributes to the whole text
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: fullText.count))

        // Define the attributes for the "Staying: requirement" part
        let requirementAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 99/255, green: 99/255, blue: 102/255, alpha: 1),
            .font: UIFont(name: "Inter-Bold", size: 14)!
        ]

        // Apply the attributes to the "Staying: requirement" part
        attributedString.addAttributes(requirementAttributes, range: (fullText as NSString).range(of: "Staying: \(requirement)"))

        // Define paragraph style with custom spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 5

        // Apply paragraph style to the attributed string
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        
        // Set the attributed string to the textLabel
        cell.textLabel?.attributedText = attributedString

        cell.roundedImageView.kf.cancelDownloadTask()
        cell.roundedImageView.image = UIImage(named: "placeholderImage")

        // If the image URL is not empty, download the image.
        if !feature.imageURL.isEmpty {
            let storageRef = Storage.storage().reference().child("images/\(feature.imageURL).jpg")

            // Download the image URL.
            DispatchQueue.global(qos: .background).async {
                storageRef.downloadURL { [weak cell] url, error in
                    guard let imageURL = url, let strongCell = cell else {
                        print("Failed to get image URL: \(error?.localizedDescription ?? "")")
                        return
                    }

                    DispatchQueue.main.async {
                        strongCell.roundedImageView.kf.indicatorType = .activity
                        strongCell.roundedImageView.kf.setImage(
                            with: imageURL,
                            placeholder: UIImage(named: "placeholderImage"),
                            options: [
                                .processor(DownsamplingImageProcessor(size: CGSize(width: 140, height: 110))),
                                .scaleFactor(UIScreen.main.scale),
                                .transition(.fade(0.2)),
                                .cacheOriginalImage
                            ])
                        { result in
                            switch result {
                            case .success(let value):
                                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                                strongCell.setNeedsLayout()
                            case .failure(let error):
                                print("Job failed: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        } else {
            // If the image URL is empty, hide the image view.
            cell.roundedImageView.isHidden = true
        }

        return cell
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

