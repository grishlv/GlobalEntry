//
//  MainViewModel.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 08.07.23.
//

import Foundation
import UIKit
import FirebaseStorage
import Kingfisher
import RealmSwift
import Combine

class MainViewModel: ObservableObject {
    @Published var features: [Feature] = []
    @Published var filteredFeatures: [Feature] = []

    var cancellables = Set<AnyCancellable>()
    
    func getImage(for feature: Feature, uniqueId: String, completion: @escaping (String, UIImage?) -> Void) {
        guard !feature.imageURL.isEmpty else {
            completion(uniqueId, nil)
            return
        }

        let storageRef = Storage.storage().reference().child("images/\(feature.imageURL).jpg")
        storageRef.downloadURL { url, error in
            guard let imageURL = url, error == nil else {
                print("Failed to get image URL: \(error?.localizedDescription ?? "")")
                completion(uniqueId, nil)
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
                    completion(uniqueId, value.image)
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                    completion(uniqueId, nil)
                }
            }
        }
    }

    func loadCountryData(_ passportCountry: String) {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Feature.className()) { oldObject, newObject in
                        newObject?["isFavorite"] = false
                    }
                }
            }
        )
        
        let realm = try! Realm(configuration: config)
        if let country = realm.objects(Country.self).filter("passport == %@", passportCountry).first {
            self.features = Array(country.features)
            self.filteredFeatures = self.features
        }
    }

    func updateFavoriteStatus(of feature: Feature) {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Feature.className()) { oldObject, newObject in
                        newObject?["isFavorite"] = false
                    }
                }
            }
        )
        
        let realm = try! Realm(configuration: config)
        
        try? realm.write {
            feature.isFavorite = !feature.isFavorite
        }
    }
    
    func filterFeatures(with text: String) {
        if text.isEmpty {
            filteredFeatures = features
        } else {
            filteredFeatures = features.filter { $0.destination.lowercased().starts(with: text.lowercased()) }
        }
    }
}
