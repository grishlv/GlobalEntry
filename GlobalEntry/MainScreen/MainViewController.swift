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

final class MainViewController: UIViewController {
    
    var labelCountry: String?
    var features: [Feature] = []
    var loadedImages: [String: UIImage] = [:]
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        cell.textLabel?.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.font = UIFont(name: "Inter-Bold", size: 18)
        
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        
        let imageURL = feature.imageURL
        
        //Check if the image is already loaded from cache
        if let loadedImage = loadedImages[imageURL] {
            cell.imageView?.image = loadedImage
        } else {
            //The image is not in cache, show the grey view
            let greyView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 110))
            greyView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            let cornerRadius: CGFloat = 10
            let maskPath = UIBezierPath(roundedRect: greyView.bounds,
                                        byRoundingCorners: [.topRight, .bottomRight],
                                        cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath
            greyView.layer.mask = maskLayer
            
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
            selectedBackgroundView.layer.cornerRadius = 10
            cell.selectedBackgroundView = selectedBackgroundView
            
            cell.contentView.addSubview(greyView)
            greyView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview()
                make.width.equalTo(140)
                make.height.equalTo(110)
            }
            
            // Download the image asynchronously
            let storageRef = Storage.storage().reference().child("images/\(imageURL).jpg")
            storageRef.downloadURL { [weak self] url, error in
                if let imageURL = url {
                    let session = URLSession.shared
                    let task = session.dataTask(with: imageURL) { [weak self] (data, response, error) in
                        if let error = error {
                            print("error: \(error)")
                        } else if let data = data, let image = UIImage(data: data) {
                            // Store the loaded image in cache
                            self?.loadedImages[imageURL.absoluteString] = image
                            
                            DispatchQueue.main.async {
                                // Check if the cell is still visible at this indexPath
                                if let currentCell = tableView.cellForRow(at: indexPath) {
                                    greyView.removeFromSuperview()
                                    
                                    let imageView = RoundedImageView(image: image)
                                    imageView.cornerRadius = 10
                                    currentCell.imageView?.image = image
                                    currentCell.contentView.addSubview(imageView)
                                    
                                    imageView.snp.makeConstraints { make in
                                        make.centerY.equalToSuperview()
                                        make.trailing.equalToSuperview()
                                        make.width.equalTo(140)
                                        make.height.equalTo(110)
                                    }
                                    currentCell.imageView?.image = nil
                                    currentCell.imageView?.isHidden = true
                                    currentCell.setNeedsLayout()
                                }
                            }
                        }
                    }
                    task.resume()
                } else {
                    print("errorHard")
                }
            }
        }
        return cell
    }
    
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ImageTableViewCell
    //
    //        let feature = features[indexPath.section]
    //        cell.textLabel?.text = "\(feature.destination): \(feature.requirement)"
    //        // Configure other properties of the cell
    //
    //        let imageURL = feature.imageURL
    //
    //        // Check if the image is already loaded from cache
    //        if let cachedImage = ImageCache.shared.image(forKey: imageURL) {
    //            cell.imageView?.image = cachedImage
    //        } else {
    //            // The image is not in cache, show the grey view
    //            let greyView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 110))
    //            greyView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    //            let cornerRadius: CGFloat = 10
    //            let maskPath = UIBezierPath(roundedRect: greyView.bounds,
    //                                        byRoundingCorners: [.topRight, .bottomRight],
    //                                        cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
    //            let maskLayer = CAShapeLayer()
    //            maskLayer.path = maskPath.cgPath
    //            greyView.layer.mask = maskLayer
    //
    //            let selectedBackgroundView = UIView()
    //            selectedBackgroundView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    //            selectedBackgroundView.layer.cornerRadius = 10
    //            cell.selectedBackgroundView = selectedBackgroundView
    //
    //            cell.contentView.addSubview(greyView)
    //            greyView.snp.makeConstraints { make in
    //                make.centerY.equalToSuperview()
    //                make.trailing.equalToSuperview()
    //                make.width.equalTo(140)
    //                make.height.equalTo(110)
    //            }
    //
    //            // Download the image asynchronously
    //            let storageRef = Storage.storage().reference().child("images/\(imageURL).jpg")
    //            let placeholderImage = UIImage(named: "placeholder") // Placeholder image while loading
    //            cell.imageView?.image = placeholderImage
    //
    //            storageRef.downloadURL { url, error in
    //                if let imageURL = url {
    //                    let session = URLSession.shared
    //                    let task = session.dataTask(with: imageURL) { (data, response, error) in
    //                        if let error = error {
    //                            print("error: \(error)")
    //                        } else if let data = data, let image = UIImage(data: data) {
    //                            // Store the loaded image in cache
    //                            ImageCache.shared.storeImage(image, forKey: imageURL.absoluteString)
    //
    //                            DispatchQueue.main.async {
    //                                // Check if the cell is still visible at this indexPath
    //                                if let currentCell = tableView.cellForRow(at: indexPath), currentCell.imageView?.image == placeholderImage {
    //                                    greyView.removeFromSuperview()
    //
    //                                    cell.imageView?.image = image
    //                                    cell.setNeedsLayout()
    //                                }
    //                            }
    //                        }
    //                    }
    //                    task.resume()
    //                } else {
    //                    print("errorHard")
    //                }
    //            }
    //        }
    //
    //        return cell
    //    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let feature = features[section]
        return feature.destination
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
