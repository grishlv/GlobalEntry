////
////  MainTableViewCell.swift
////  GlobalEntry
////
////  Created by Grigoriy Shilyaev on 11.07.23.
////

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    let roundedImageView: RoundedImageView = {
        let imageView = RoundedImageView(cornerRadius: 10)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Text configurations
//        textLabel?.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
//        textLabel?.font = UIFont(name: "Inter-Bold", size: 18)
        textLabel?.numberOfLines = 0
        
        // Cell background configurations
        backgroundColor = .white
        layer.cornerRadius = 10
        
        // Selected background view configurations
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        selectedBackgroundView.layer.cornerRadius = 10
        self.selectedBackgroundView = selectedBackgroundView
        
        contentView.addSubview(roundedImageView)
        
        roundedImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(110)
        }
        
        textLabel?.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.leading.equalToSuperview().offset(13)
            make.trailing.lessThanOrEqualTo(roundedImageView.snp.leading).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with feature: Feature, image: UIImage?) {
        textLabel?.text = "\(feature.destination): \(feature.requirement)"
        roundedImageView.image = image ?? UIImage(named: "placeholderImage")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.roundedImageView.kf.cancelDownloadTask()
        self.roundedImageView.image = UIImage(named: "placeholderImage")
    }
}
