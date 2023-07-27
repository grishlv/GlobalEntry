//
//  ThirdFAQViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 27.07.23.
//

import Foundation
import UIKit
import SnapKit

final class ThirdFAQViewController: UIViewController {
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "What should I do if I find inaccuracy?"
        labelHeader.font = UIFont(name: "Inter-Bold", size: 24)
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.numberOfLines = 0
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - text view
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Inter-Regular", size: 15)
        textView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        textView.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        
        let regularFont = UIFont(name: "Inter-Regular", size: 15)!
        let attributedText = NSMutableAttributedString(string: "If you find something wrong, please contact us via email at ", attributes: [NSAttributedString.Key.font: regularFont])
        
        let mailAttributes: [NSAttributedString.Key: Any] = [
            .font: regularFont,
            .link: NSURL(string: "mailto:g.shilyaev28@gmail.com")!,
            .foregroundColor: UIColor.blue
        ]
        
        let mailAttributedString = NSMutableAttributedString(string: "g.shilyaev28@gmail.com", attributes: mailAttributes)
        attributedText.append(mailAttributedString)
        
        let restText = NSMutableAttributedString(string: ". We are appreciate feedback!", attributes: [NSAttributedString.Key.font: regularFont])
        attributedText.append(restText)
        
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        
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
    private func setupLabelHeader() {
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(90)
            make.leading.trailing.equalToSuperview().inset(20)
        })
    }

    //MARK: - setup text view
    private func setupTextView() {
        //constraints
        textView.snp.makeConstraints({ make in
            make.top.equalTo(labelHeader.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
        })
    }
    
    private func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "mailto" {
            if UIApplication.shared.canOpenURL(URL) {
                UIApplication.shared.open(URL, options: [:], completionHandler: nil)
                return false
            }
        }
        return true
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
