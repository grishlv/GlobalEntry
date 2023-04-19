//
//  ChoosePassportViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 13.04.23.
//

import Foundation
import UIKit

class ChoosePassportViewController: UIViewController {
    
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Choose your passport"
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.font = UIFont(name: "Inter-Bold", size: 26)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        setupLabelHeader()
    }
    
    //MARK: - label header
    private func setupLabelHeader() {
        
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(75)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(220)
            make.height.equalTo(35)
        })
    }
}
