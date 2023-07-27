//
//  SecondFAQViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 27.07.23.
//

import Foundation
import UIKit
import SnapKit

final class SecondFAQViewController: UIViewController {
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "What do visa types mean?"
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
        let boldFont = UIFont(name: "Inter-Bold", size: 15)!
        
        let attributedText = NSMutableAttributedString(string: "For visa-free regimes, the number of days is specified whenever available. When not available, visa free code is used (for example, in the EU countries with the freedom of movement days are not limited).\n\n", attributes: [NSAttributedString.Key.font: regularFont])
        
        let boldStrings = ["1. 7-360", "2. Visa free", "3. Visa on arrival", "4. E-visa", "5. Visa required", "6. Covid ban", "7. No admission", "8. Hayya Entry Permit", "9. Your country"]
        
        let descriptions = [" - number of visa-free days, where available.\n",
                            " - visa-free travel (where number of days is unknown or not applicable, such as freedom of movement), including tourist registration requirement for Seychelles.\n",
                            " - destinations that grant visa on arrival, basically visa-free.\n",
                            " - includes ESTA (Electronic System for Travel Authorization for the USA) and eTA (Electronic Travel Authorization for Canada), eVisas, eVisitors in Australia, eTourist cards for Suriname, pre-enrollment for Ivory Coast, and UK's electronic visa waivers.\n",
                            " - obtaining a visa is required for travel. Includes Cuba's tourist cards.\n",
                            " - travelling is banned for most people.\n",
                            " - includes rare tricky situations, such as war conflicts.\n",
                            " - fan ID for the FIFA World Cup 2022 to enter Qatar in Nov-Dec 2022.\n",
                            " - it’s your passport ;)"]
        
        for i in 0..<boldStrings.count {
            let boldPart = NSAttributedString(string: boldStrings[i], attributes: [NSAttributedString.Key.font: boldFont])
            let normalPart = NSAttributedString(string: descriptions[i], attributes: [NSAttributedString.Key.font: regularFont])
            
            attributedText.append(boldPart)
            attributedText.append(normalPart)
        }
        
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

