//
//  AboutViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 28.07.23.
//

import Foundation
import UIKit
import SnapKit

class AboutViewContoller: UIViewController {
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "About the app"
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
        
        let attributedText = NSMutableAttributedString(string: "The \"GlobalEntry\" app was launched in 2023, born out of our personal desire for such a resource. It soon became clear that we weren't alone in this need.\n\nIn the near future, we plan to introduce features that will provide in-depth information about each country. This will help our users gain better awareness before their visits, enhancing their travel experience.\n\nCurrently, \"GlobalEntry\" is completely free to use. We are committed to keeping it accessible for all, as we have managed to sustain the app without incurring high expenses.", attributes: [NSAttributedString.Key.font: UIFont(name: "Inter-Regular", size: 15)!])
                
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = false
        
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
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(345)
            make.height.equalTo(48)
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
