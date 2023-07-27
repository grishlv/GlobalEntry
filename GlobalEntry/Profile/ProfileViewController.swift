//
//  ProfileViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 02.07.23.
//

import Foundation
import UIKit
import SnapKit
import MessageUI

final class ProfileViewController: UIViewController {
    
    var data = [
        "Current passport": [],
        "Information": ["FAQ", "Contact us", "About the app", "Privacy policy"]
    ]
    
    var sectionTitles = ["Current passport", "Information"]

    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Your profile"
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
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Fetch the selected passport
        if let passportCountry = UserDefaults.standard.string(forKey: "passportCountry") {
            data["Current passport"] = [passportCountry]
        }
        tableView.reloadData()
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
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        headerView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)

        let headerLabel = UILabel()
        headerLabel.text = sectionTitles[section]
        headerLabel.font = UIFont(name: "Inter-Bold", size: 15)
        headerLabel.textColor = UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1)
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
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell.textLabel?.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        cell.textLabel?.font = UIFont(name: "Inter-Medium", size: 15)
        
        let key = sectionTitles[indexPath.section]
        if let item = data[key]?[indexPath.row] {
            cell.textLabel?.text = item
        }
        
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
        
        let sectionTitle = sectionTitles[indexPath.section]
        let rowTitle = data[sectionTitle]?[indexPath.row]
        
        if sectionTitle == "Current passport" {
            let viewModel = ChoosePassportViewModel()
            let choosePassportViewController = ChoosePassportViewController(viewModel: viewModel, tabBar: TabController())
            choosePassportViewController.delegate = self
            navigationController?.pushViewController(choosePassportViewController, animated: true)
            
        } else if sectionTitle == "Information", rowTitle == "Contact us" {
            
            let recipientEmail = "g.shilyaev28@gmail.com"
            let subject = "GlobalEntry feedback"
            let body = ""
            
            if MFMailComposeViewController.canSendMail() {
                let mailComposerVC = MFMailComposeViewController()
                mailComposerVC.mailComposeDelegate = self
                mailComposerVC.setToRecipients([recipientEmail])
                mailComposerVC.setSubject(subject)
                mailComposerVC.setMessageBody(body, isHTML: false)
                present(mailComposerVC, animated: true)
                
            } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
                UIApplication.shared.open(emailUrl)
            }
        }
    }
}

extension ProfileViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension ProfileViewController: ChoosePassportViewModelDelegate {

    func didSelectCountry(_ passportName: String) {
        data["Current passport"] = [passportName]
        tableView.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("passportSelectionChanged"), object: passportName)
        navigationController?.popViewController(animated: true)
    }
}
