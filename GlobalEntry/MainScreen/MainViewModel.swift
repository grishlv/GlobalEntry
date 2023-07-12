//
//  MainViewModel.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 08.07.23.
//

import UIKit
import Combine
import Firebase
import FirebaseStorage
import Kingfisher

//protocol MainViewModelProtocol {
//    var features: CurrentValueSubject<[Feature], Never> { get }
//    func fetchImageURL(for feature: Feature)
//}
//
//final class MainViewModel: MainViewModelProtocol {
//    var features = CurrentValueSubject<[Feature], Never>([])
//    var cancellables = Set<AnyCancellable>()
//    
//    func fetchImageURL(for feature: Feature) {
//        let storageRef = Storage.storage().reference().child("images/\(feature.imageURL).jpg")
//        storageRef.downloadURL { [weak self] url, error in
//            if let imageURL = url {
//                self?.didFetchImageURL(imageURL, for: feature)
//            } else {
//                print("Failed to get image URL: \(error?.localizedDescription ?? "")")
//            }
//        }
//    }
//    
//    func didFetchImageURL(_ imageURL: URL, for feature: Feature) {
//        features.modify { [weak self] currentFeatures in
//            guard let index = currentFeatures.firstIndex(of: feature) else { return }
//            currentFeatures[index].imageURL = imageURL.absoluteString
//        }
//    }
//    
//    func loadImage(fromURL url: URL, into imageView: UIImageView) {
//        let placeholderImage = UIImage(named: "placeholderImage")
//        imageView.kf.indicatorType = .activity
//        imageView.kf.setImage(
//            with: url,
//            placeholder: placeholderImage,
//            options: [
//                .processor(DownsamplingImageProcessor(size: CGSize(width: 140, height: 110))),
//                .scaleFactor(UIScreen.main.scale),
//                .transition(.fade(0.2)),
//                .cacheOriginalImage
//            ]) { result in
//            switch result {
//            case .success(let value):
//                print("Task done for: \(value.source.url?.absoluteString ?? "")")
//                imageView.setNeedsLayout()
//            case .failure(let error):
//                print("Job failed: \(error.localizedDescription)")
//            }
//        }
//    }
//
//}
