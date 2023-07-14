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

        cell.configureCell(with: feature, image: nil)
        
        cell.heartImageView.isHidden = true
        cell.filledHeartImageView.isHidden = false
        
        let tapGestureFilled = UITapGestureRecognizer(target: self, action: #selector(heartIconTapped))
        cell.filledHeartImageView.addGestureRecognizer(tapGestureFilled)
        cell.filledHeartImageView.tag = indexPath.section

        return cell
    }
    
    @objc func heartIconTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        let feature = favoriteFeatures[index]

        // Access the shared instance or global variable of the Realm object
        let realm = try! Realm()

        // Update the "isFavorite" property of the selected feature
        try? realm.write {
            feature.isFavorite = false
        }

        // Reload the table view to reflect the updated favorite status
        tableView.reloadData()
    }
}



