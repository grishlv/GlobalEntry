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
    
    var filters = Filter()
    var cancellables = Set<AnyCancellable>()
    let visaFreeTypes = ["visa free", "90", "30", "180", "120", "21", "14", "360", "60", "15", "42", "45", "28", "240", "10", "7", "31"]
    @Published var features: [Feature] = []
    @Published var filteredFeatures: [Feature] = []
    
    func getImage(for feature: Feature, uniqueId: String, completion: @escaping (String, UIImage?) -> Void) {
        guard !feature.imageURL.isEmpty else {
            completion(uniqueId, UIImage(named: "placeholderImage"))
            return
        }
        
        let storageRef = Storage.storage().reference().child("images/\(feature.imageURL).jpg")
        storageRef.downloadURL { url, error in
            guard let imageURL = url, error == nil else {
                print("Failed to get image URL: \(error?.localizedDescription ?? "")")
                completion(uniqueId, UIImage(named: "placeholderImage"))
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
                    completion(uniqueId, UIImage(named: "placeholderImage"))
                }
            }
        }
    }
    
    func loadCountryData(_ passportCountry: String) {
        do {
            let realm = try Realm()
            if let country = realm.objects(Country.self).filter("passport == %@", passportCountry).first {
                self.features = Array(country.features)
                self.filteredFeatures = self.features
            }
        } catch {
            print("Failed to update favorite status or open Realm: \(error.localizedDescription)")
        }
    }
    
    func applyFilters(_ filters: Filter) {
        self.filters = filters
        filteredFeatures = features.filter { feature in
            let continentMatches = (filters.continents.isEmpty || filters.continents.contains(feature.continent))

            if filters.visaTypes.isEmpty {
                return continentMatches
            } else if filters.visaTypes.contains("visa free") {
                return continentMatches && (filters.visaTypes.contains(feature.requirement) || visaFreeTypes.contains(feature.requirement))
            } else {
                return continentMatches && filters.visaTypes.contains(feature.requirement)
            }
        }
    }
    
    func updateFavoriteStatus(of feature: Feature) {
        do {
            let realm = try Realm()
            try? realm.write {
                feature.isFavorite = !feature.isFavorite
            }
        } catch {
            print("Failed to update favorite status or open Realm: \(error.localizedDescription)")
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
