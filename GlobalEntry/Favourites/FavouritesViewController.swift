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
            make.trailing.lessThanOrEqualToSuperview().inset(20)
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
    
    public func loadFavoriteFeatures() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Feature.className()) { oldObject, newObject in
                        newObject?["isFavorite"] = false
                    }
                }
            }
        )

        let realm = try! Realm(configuration: config)
        favoriteFeatures = realm.objects(Feature.self).filter("isFavorite == true")
    }

    
    public func observeDatabaseChanges() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Feature.className()) { oldObject, newObject in
                        newObject?["isFavorite"] = false
                    }
                }
            }
        )
        
        let realm = try! Realm(configuration: config)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Reset the navigation bar appearance
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let feature = favoriteFeatures[indexPath.section]
        let tapGestureFilled = UITapGestureRecognizer(target: self, action: #selector(heartIconTapped))
        
        cell.configureCell(feature: feature, destination: feature.destination, requirement: feature.requirement)
        cell.filledHeartImageView.addGestureRecognizer(tapGestureFilled)
        cell.filledHeartImageView.tag = indexPath.section
        
        if !feature.imageURL.isEmpty {
            let storageRef = Storage.storage().reference().child("images/\(feature.imageURL).jpg")
            storageRef.downloadURL { [weak cell] url, error in
                guard let imageURL = url, error == nil else {
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
                        DispatchQueue.main.async {
                            cell.imageView?.image = value.image
                            cell.setNeedsLayout()
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
        let feature = favoriteFeatures[index]
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
        
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Feature.className()) { oldObject, newObject in
                        newObject?["isFavorite"] = false
                    }
                }
            }
        )

        let realm = try! Realm(configuration: config)
        
        do {
            try realm.write {
                feature.isFavorite = !feature.isFavorite
            }
        } catch {
            print("Failed to update favorite status: \(error.localizedDescription)")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("FavouriteStatusChanged"), object: nil)
        
        // refresh the cell views
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: 0, section: index)], with: .none)
        tableView.endUpdates()
    }
}
