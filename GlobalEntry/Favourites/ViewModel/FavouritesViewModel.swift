//
//  FavouritesViewModel.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 18.07.23.
//

import Foundation
import UIKit
import FirebaseStorage
import Kingfisher
import RealmSwift
import Combine

class FavouritesViewModel {
    
    @Published var favouriteFeatures: [Feature] = []
    var notificationToken: NotificationToken?
    var cancellables = Set<AnyCancellable>()
    
    func getImage(for feature: Feature, favouriteId: String, completion: @escaping (String, UIImage?) -> Void) {
        guard !feature.imageURL.isEmpty else {
            print("Failed to get image URL")
            return
        }
        
        let storageRef = Storage.storage().reference().child("images/\(feature.imageURL).jpg")
        storageRef.downloadURL { url, error in
            guard let imageURL = url, error == nil else {
                print("Failed to get image URL: \(error?.localizedDescription ?? "")")
                return
            }
            KingfisherManager.shared.retrieveImage(with: imageURL, options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 140, height: 110))),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]) { result in
                switch result {
                case .success(let value):
                    completion(favouriteId, value.image)
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadFavoriteFeatures() {
        do {
            let realm = try Realm()
            let favoriteFeatures = realm.objects(Feature.self).filter("isFavorite == true")
            self.favouriteFeatures = Array(favoriteFeatures)
        } catch {
            print("Failed to update favorite status or open Realm: \(error.localizedDescription)")
        }
    }
    
    func clearFavourites() {
        // Use Realm to remove all favourite features
        do {
            let realm = try Realm()
            try realm.write {
                // Filter the features where isFavorite is true and update them
                let favouriteFeatures = realm.objects(Feature.self).filter("isFavorite == true")
                for feature in favouriteFeatures {
                    feature.isFavorite = false
                }
            }
        } catch {
            print("Failed to clear favourites: \(error.localizedDescription)")
        }
        // Clear the local copy of favourite features
        favouriteFeatures = []
    }
}
