//
//  ImageTableViewCell.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 10.07.23.
//

import UIKit

//class ImageTableViewCell: UITableViewCell {
//    // Your cell implementation
//    
//    private var imageURL: String?
//    
//    func configure(with image: UIImage, imageURL: String) {
//        self.imageURL = imageURL
//        
//        // Store the loaded image in cache
//        ImageCache.shared.storeImage(image, forKey: imageURL)
//        
//        // Configure the cell with the image
//        imageView?.image = image
//    }
//}
//
//class ImageCache {
//    static let shared = ImageCache()
//    
//    private let cache = NSCache<NSString, UIImage>()
//    
//    func storeImage(_ image: UIImage, forKey key: String) {
//        cache.setObject(image, forKey: key as NSString)
//    }
//    
//    func image(forKey key: String) -> UIImage? {
//        return cache.object(forKey: key as NSString)
//    }
//}
