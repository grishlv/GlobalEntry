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
import Combine

final class FavouritesViewController: UIViewController {
    
    var viewModel = FavouritesViewModel()
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
        
        viewModel.$favouriteFeatures
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
    
    public func loadFavoriteFeatures() {
        viewModel.loadFavoriteFeatures()
    }
    
    public func observeDatabaseChanges() {
        do {
            let realm = try Realm()
            notificationToken = realm.observe { [weak self] _, _ in
                self?.viewModel.loadFavoriteFeatures()
                self?.tableView.reloadData()
            }
        } catch {
            print("Failed to open Realm: \(error.localizedDescription)")
        }
    }
    
    deinit {
        notificationToken?.invalidate()
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
    
    init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.favouriteFeatures.count
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let feature = viewModel.favouriteFeatures[indexPath.section]
        let tapGestureFilled = UITapGestureRecognizer(target: self, action: #selector(heartIconTapped))
        
        cell.favouriteId = feature.id
        cell.filledHeartImageView.addGestureRecognizer(tapGestureFilled)
        cell.filledHeartImageView.tag = indexPath.section
        
        DispatchQueue.main.async {
            cell.configureCell(feature: feature, destination: feature.destination, requirement: feature.requirement)

        }
        
        viewModel.getImage(for: feature, favouriteId: feature.id) { [weak cell] (id, image) in
            DispatchQueue.main.async {
                if cell?.favouriteId == id {
                    cell?.updateImage(image: image)
                }
            }
        }
        return cell
    }
    
    @objc func heartIconTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        let feature = viewModel.favouriteFeatures[index]
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()

        do {
            let realm = try Realm()
            try realm.write {
                feature.isFavorite = !feature.isFavorite
            }
        } catch {
            print("Failed to update favorite status or open Realm: \(error.localizedDescription)")
        }
        NotificationCenter.default.post(name: NSNotification.Name("FavouriteStatusChanged"), object: nil)
        
        // refresh the cell views
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: 0, section: index)], with: .none)
        tableView.endUpdates()
    }
}
