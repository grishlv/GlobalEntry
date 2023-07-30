//
//  ChooseTableViewCell.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 16.07.23.
//

import UIKit

final class ChooseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        textLabel?.font = UIFont(name: "Inter-Medium", size: 18)
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        selectedBackgroundView.layer.cornerRadius = 10
        self.selectedBackgroundView = selectedBackgroundView
        
        layer.cornerRadius = 10
        backgroundColor = .white
        clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
