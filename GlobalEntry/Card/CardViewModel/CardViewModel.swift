//
//  CardViewModel.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 08.08.23.
//

import Foundation
import UIKit
import FirebaseStorage
import Kingfisher
import RealmSwift

class CardViewModel: ObservableObject {
    
    @Published var image: UIImage?
    private var imageURL: String?
    
    init(imageURL: String?) {
        self.imageURL = imageURL
    }
    
    func loadImage() {
        guard let imageURL = self.imageURL, !imageURL.isEmpty else {
            self.image = UIImage(named: "placeholder")
            return
        }
                
        let storageRef = Storage.storage().reference().child("imagesHigh/\(imageURL).jpg")
        storageRef.downloadURL { url, error in
            guard let imageURL = url, error == nil else {
                print("Failed to get image URL: \(error?.localizedDescription ?? "")")
                DispatchQueue.main.async {
                    self.image = UIImage(named: "placeholder")
                }
                return
            }
            
            KingfisherManager.shared.retrieveImage(with: imageURL, options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 350, height: 170))),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]) { result in
                switch result {
                case .success(let value):
                    DispatchQueue.main.async {
                        self.image = value.image
                    }
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.image = UIImage(named: "placeholder")
                    }
                }
            }
        }
    }
}

