//
//  RoundedImageView.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 10.07.23.
//

import UIKit

class RoundedImageView: UIImageView {
    var cornerRadius: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Apply corner radius to specific corners
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
