//
//  RoundedImageView.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 10.07.23.
//

import UIKit

class RoundedImageView: UIImageView {

    var cornerRadius: CGFloat {
        didSet {
            setRoundedCorners()
        }
    }
    
    init(cornerRadius: CGFloat = 0) {
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        setRoundedCorners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setRoundedCorners()
    }
    
    private func setRoundedCorners() {
        // Apply corner radius to specific corners
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
