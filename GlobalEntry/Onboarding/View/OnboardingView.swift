//
//  OnboardingView.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 04.09.23.
//

import UIKit
import SnapKit

final class OnboardingView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        label.font = UIFont(name: "Inter-Bold", size: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(descriptionLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.trailing.leading.equalToSuperview()
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.7)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(20)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(350)
            make.height.equalTo(65)
        }
    }
    
    func configure(with item: OnboardingItem) {
        imageView.image = item.image
        descriptionLabel.text = item.description
    }
}
