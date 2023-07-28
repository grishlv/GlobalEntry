//
//  FourthFAQViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 27.07.23.
//

import Foundation
import UIKit
import SnapKit

final class FourthFAQViewController: UIViewController {
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Is GlobalEntry available in another language?"
        labelHeader.font = UIFont(name: "Inter-Bold", size: 24)
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.numberOfLines = 0
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - text view
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        textView.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        let attributedText = NSMutableAttributedString(string: "Unfortunately the app is available only in English. Because we’re a small team with limited resources we haven’t been able to add support for other languages. But we’re open to cooperation!", attributes: [NSAttributedString.Key.font: UIFont(name: "Inter-Regular", size: 15)!])
        
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isSelectable = true
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
