//
//  FavouritesViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 02.07.23.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift
import Kingfisher
import FirebaseStorage

final class FavouritesViewController: UIViewController {
    
    var favoriteFeatures: Results<Feature>!
    var notificationToken: NotificationToken?
    
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
        
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupLabelHeader()
        setupTableView()
        loadFavoriteFeatures()
        observeDatabaseChanges()
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
    
    //MARK: - setup table view
    private func setupTableView() {
        
        //constraints
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
    
    private func loadFavoriteFeatures() {
        let realm = try! Realm()
        favoriteFeatures = realm.objects(Feature.self).filter("isFavorite == true")
    }
    
    private func observeDatabaseChanges() {
        let realm = try! Realm()
        notificationToken = realm.observe { [weak self] _, _ in
            self?.loadFavoriteFeatures()
            self?.tableView.reloadData()
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return favoriteFeatures.count
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
        let feature = favoriteFeatures[indexPath.section]
        let fullText = "\(feature.destination)\nStaying: \(feature.requirement)"
        let tapGestureFilled = UITapGestureRecognizer(target: self, action: #selector(heartIconTapped))
        
        cell.configureCell(feature: feature, destination: feature.destination, requirement: feature.requirement)
        cell.filledHeartImageView.addGestureRecognizer(tapGestureFilled)
        cell.filledHeartImageView.tag = indexPath.section

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
    
    @objc func heartIconTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        let feature = favoriteFeatures[index]
        
        // Access the shared instance or global variable of the Realm object
        let realm = try! Realm()
        
        // Update the "isFavorite" property of the selected feature
        try? realm.write {
            feature.isFavorite = !feature.isFavorite
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("FavouriteStatusChanged"), object: nil)

        // Reload the table view to reflect the updated favorite status
        tableView.reloadData()
    }
}
