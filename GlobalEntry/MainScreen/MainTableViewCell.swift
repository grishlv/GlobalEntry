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
    
    let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .white
        return imageView
    }()
    
    let filledHeartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Text configurations
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
        contentView.addSubview(heartImageView)
        contentView.addSubview(filledHeartImageView)
        
        roundedImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(110)
        }
        
        heartImageView.snp.makeConstraints { make in
            make.top.equalTo(roundedImageView.snp.top).offset(10)
            make.trailing.equalTo(roundedImageView.snp.trailing).offset(-10)
            make.width.height.equalTo(25)
        }

        filledHeartImageView.snp.makeConstraints { make in
            make.edges.equalTo(heartImageView)
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
    
    func configureCell(feature: Feature, destination: String, requirement: String) {
        let fullText = "\(destination)\nStaying: \(requirement)"
        
        let isFavorite = feature.isFavorite
        heartImageView.isHidden = isFavorite
        filledHeartImageView.isHidden = !isFavorite
        
        // Handle the tap on the heart icon
        heartImageView.isUserInteractionEnabled = true
        filledHeartImageView.isUserInteractionEnabled = true
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Define the attributes for the whole text
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1),
            .font: UIFont(name: "Inter-Bold", size: 18)!
        ]
        
        // Apply the attributes to the whole text
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: fullText.count))
        
        // Define the attributes for the "Staying: requirement" part
        let requirementAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 99/255, green: 99/255, blue: 102/255, alpha: 1),
            .font: UIFont(name: "Inter-Bold", size: 14)!
        ]
        
        // Apply the attributes to the "Staying: requirement" part
        attributedString.addAttributes(requirementAttributes, range: (fullText as NSString).range(of: "Staying: \(requirement)"))
        
        // Define paragraph style with custom spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 5
        
        // Apply paragraph style to the attributed string
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        
        // Set the attributed string to the textLabel
        textLabel?.attributedText = attributedString
        
        roundedImageView.kf.cancelDownloadTask()
        roundedImageView.image = UIImage(named: "placeholderImage")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.roundedImageView.kf.cancelDownloadTask()
        self.roundedImageView.image = UIImage(named: "placeholderImage")
    }
}
