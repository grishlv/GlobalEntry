//
//  PrivacyViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 28.07.23.
//

import Foundation
import UIKit
import SnapKit

class PrivacyViewController: UIViewController {
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Privacy policy"
        labelHeader.font = UIFont(name: "Inter-Bold", size: 30)
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - text view
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Inter-Regular", size: 15)
        textView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        textView.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        
        // Privacy Policy Text
        let privacyPolicyText = """
        Last Updated: July 28, 2023
        
        Introduction
        
        Welcome to our mobile application "Global Entry". This Privacy Policy is meant to help you understand what information we do not collect, why we do not collect it, and how you can update, manage or delete your information.
        
        By using our App, you are agreeing to the terms of this Privacy Policy.
        
        What Information Do We NOT Collect?
        
        We do not collect any type of personal data. The App has been designed with the intent of providing a service without the need to gather or process any of your personal data.
        
        Here are the categories of data we do not collect:
        
        - Personal Identifiers: We do not collect information such as your name, address, phone number, email address, or other similar identifiers.
        
        - Customer Records: We do not collect personal information or other information that identifies, relates to, describes, or is capable of being associated with a particular individual.
        
        - Commercial Information: We do not collect records of personal property, products or services purchased, obtained, or considered, or other purchasing or consuming histories or tendencies.
        
        - Internet Activity: We do not collect information regarding a consumer’s interaction with an internet website, application, or advertisement.
        
        - Geolocation Data: We do not collect precise geographic location information about a particular individual or device.
        
        Changes To This Privacy Policy
        
        This Privacy Policy is effective as of July 28, 2023 and will remain in effect except with respect to any changes in its provisions in the future, which will be in effect immediately after being posted on this page.
        
        We reserve the right to update or change our Privacy Policy at any time and you should check this Privacy Policy periodically. Your continued use of the App after we post any modifications to the Privacy Policy on this page will constitute your acknowledgment of the modifications and your consent to abide and be bound by the modified Privacy Policy.
        
        Contact information
        
        If you have any questions or concerns about this Privacy Policy, please feel free to contact us at g.shilyaev28@gmail.com.
        """
        
        let attributedText = NSMutableAttributedString(string: privacyPolicyText, attributes: [NSAttributedString.Key.font: UIFont(name: "Inter-Regular", size: 15)!])
        
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = true //allowing scroll as the text might be long
        
        view.addSubview(textView)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelHeader()
        setupTextView()
        setupSwipeByGestureBack()
        
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    }
    
    //MARK: - setup label header
    func setupLabelHeader() {
        
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(90)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - setup text view
    func setupTextView() {
        //constraints
        textView.snp.makeConstraints({ make in
            make.top.equalTo(labelHeader.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20) //ensure the text view is bounded at the bottom
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


