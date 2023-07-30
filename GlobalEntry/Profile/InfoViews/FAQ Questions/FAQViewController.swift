//
//  FAQViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 26.07.23.
//

import Foundation
import UIKit
import SnapKit

final class FAQViewController: UIViewController {
    
    var questions = ["Which source do we use?",
                     "What do visa types mean?",
                     "What should I do if I find inaccuracy?",
                     "Is GlobalEntry available in another language?",
                     "Does the app have a Dark Theme?"
    ]
    
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "FAQ"
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
        tableView.rowHeight = 44.0
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
        tableView.separatorColor = UIColor(red: 222/255, green: 222/255, blue: 228/255, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelHeader()
        setupTableView()
        setupSwipeByGestureBack()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    }
    
    //MARK: - setup label header
    private func setupLabelHeader() {
        
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(90)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - setup line separator
    private func setupTableView() {
        
        //constraints
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(labelHeader.snp.bottom).inset(-25)
            make.leading.trailing.equalTo(view.safeAreaInsets)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
    
    //MARK: - go back by gesture recognizer
    func setupSwipeByGestureBack() {
        let goBack = UISwipeGestureRecognizer(target: self, action: #selector(swipeFuncBack(gesture:)))
        goBack.direction = .right
        view.addGestureRecognizer(goBack)
    }
    
    @objc func swipeFuncBack(gesture: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}

extension FAQViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell.textLabel?.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        cell.textLabel?.font = UIFont(name: "Inter-Medium", size: 15)
        cell.textLabel?.text = questions[indexPath.row]
        
        
        let image = UIImage(systemName: "chevron.right")
        let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!))
        accessory.image = image
        
        // set the color here
        accessory.tintColor = UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1)
        cell.accessoryView = accessory
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let rowTitle = questions[indexPath.row]
        
        if rowTitle == "Which source do we use?" {
            let firstVC = FirstFAQViewController()
            navigationController?.pushViewController(firstVC, animated: true)
        } else if rowTitle == "What do visa types mean?" {
            let secondVC = SecondFAQViewController()
            navigationController?.pushViewController(secondVC, animated: true)
        } else if rowTitle == "What should I do if I find inaccuracy?" {
            let thirdVC = ThirdFAQViewController()
            navigationController?.pushViewController(thirdVC, animated: true)
        } else if rowTitle == "Is GlobalEntry available in another language?" {
            let fourthVC = FourthFAQViewController()
            navigationController?.pushViewController(fourthVC, animated: true)
        } else if rowTitle == "Does the app have a Dark Theme?" {
            let fifthVC = FifthFAQViewController()
            navigationController?.pushViewController(fifthVC, animated: true)
        }
    }
}
