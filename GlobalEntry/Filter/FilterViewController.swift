//
//  FilterViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 19.07.23.
//

import Foundation
import UIKit

class FilterViewController: UIViewController {
    
    var data = [
        "Continent": ["Africa", "Asia", "Europe", "North America", "South America", "Oceania"],
        "Visa Types": ["visa free", "e-visa", "visa on arrival", "visa required"]
    ]
    
    var sectionTitles = ["Continent", "Visa Types"]
    var filters: Filter!
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Filters"
        labelHeader.font = UIFont(name: "Inter-Bold", size: 16)
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - button close
    private lazy var buttonClose: UIButton = {
        let buttonClose = UIButton()
        buttonClose.setImage(UIImage(named: "closeButton"), for: .normal)
        buttonClose.tintColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        view.addSubview(buttonClose)
        return buttonClose
    }()
    
    //MARK: - line separator
    private lazy var lineSeparator: UIView = {
        let lineSeparator = UIView()
        lineSeparator.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        view.addSubview(lineSeparator)
        return lineSeparator
    }()
    
    //MARK: - table view
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        tableView.isScrollEnabled = false
        tableView.separatorColor = UIColor(red: 222/255, green: 222/255, blue: 228/255, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        return tableView
    }()
    
    //MARK: - button apply
    private lazy var buttonApply: UIButton = {
        let buttonApply = UIButton()
        buttonApply.setTitle("Apply filters", for: .normal)
        buttonApply.layer.cornerRadius = 10
        buttonApply.backgroundColor = UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1)
        view.addSubview(buttonApply)
        return buttonApply
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelHeader()
        setupButtonClose()
        setupLineSeparator()
        setupTableView()
        setupButtonApply()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    }
    
    //MARK: - setup label header
    private func setupLabelHeader() {
        
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(labelHeader)
        })
    }
    
    //MARK: - setup button close
    private func setupButtonClose() {
        
        //constraints
        buttonClose.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        })
        buttonClose.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - setup line separator
    private func setupLineSeparator() {
        
        //constraints
        lineSeparator.snp.makeConstraints({ make in
            make.top.equalTo(buttonClose.snp.bottom).inset(-15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1)
        })
    }
    
    //MARK: - setup line separator
    private func setupTableView() {
        
        //constraints
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(lineSeparator.snp.bottom).inset(-35)
            make.leading.trailing.equalTo(view.safeAreaInsets)
            make.bottom.equalTo(view.safeAreaInsets)
        })
    }
    
    //MARK: - setup button apply
    private func setupButtonApply() {
        
        //constraints
        buttonApply.snp.makeConstraints({ make in
            make.bottom.equalTo(view.safeAreaInsets).inset(45)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        })
        buttonApply.addTarget(self, action: #selector(applyFiltersButtonTapped), for: .touchUpInside)
    }
    
    @objc func applyFiltersButtonTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("FiltersApplied"), object: nil, userInfo: ["filters": filters!])
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionTitles[section]
        if let rows = data[key] {
            return rows.count
        }
        return 0
    }
    
    // Section title
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let headerLabel = UILabel()
        headerLabel.text = sectionTitles[section]
        headerLabel.font = UIFont(name: "Inter-Bold", size: 15)
        headerLabel.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(headerLabel)
        
        // Set constraints for the header label
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    // Cell for row at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        cell.textLabel?.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)

        let switchView = UISwitch(frame: .zero)
        let uniqueTag = indexPath.section * 1000 + indexPath.row
        switchView.tag = uniqueTag

        let key = sectionTitles[indexPath.section]
        if let item = data[key]?[indexPath.row] {
            cell.textLabel?.text = item

            if key == "Continent" {
                switchView.setOn(filters.continents.contains(item), animated: false)
            } else if key == "Visa Types" {
                switchView.setOn(filters.visaTypes.contains(item), animated: false)
            }
        }
        
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1) // Set your color here
        cell.selectedBackgroundView = selectedBackgroundView

        return cell
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        let section = sender.tag / 1000
        let row = sender.tag % 1000
        let sectionTitle = sectionTitles[section]
        let item = data[sectionTitle]?[row]
        let _ = String(section * 1000 + row)

        if sender.isOn {
            if sectionTitle == "Continent" {
                filters.continents.append(item ?? "")
            } else if sectionTitle == "Visa Types" {
                filters.visaTypes.append(item ?? "")
            }
        } else {
            if sectionTitle == "Continent", let index = filters.continents.firstIndex(of: item ?? "") {
                filters.continents.remove(at: index)
            } else if sectionTitle == "Visa Types", let index = filters.visaTypes.firstIndex(of: item ?? "") {
                filters.visaTypes.remove(at: index)
            }
        }
    }
}
