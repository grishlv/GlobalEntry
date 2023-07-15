//
//  MapViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 02.07.23.
//

import Foundation
import UIKit
import SnapKit

final class MapViewController: UIViewController {
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Map visualization 🌍"
        labelHeader.font = UIFont(name: "Inter-Bold", size: 30)
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelHeader()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    }
    
    //MARK: - setup label header
    private func setupLabelHeader() {
        
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(75)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
}
