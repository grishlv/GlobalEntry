//
//  FilterViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 19.07.23.
//

import Foundation
import UIKit

class FilterViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        setupLabelHeader()
        setupButtonClose()
        setupLineSeparator()
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
    
    //MARK: - setup label header
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
    
}
