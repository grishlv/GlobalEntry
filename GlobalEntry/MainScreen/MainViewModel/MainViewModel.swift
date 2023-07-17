//
//  MainViewModel.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 08.07.23.
//

import Foundation
import RealmSwift
import Combine

class CountryViewModel: ObservableObject {
    @Published var features: [Feature] = []
    @Published var filteredFeatures: [Feature] = []

    private var cancellables = Set<AnyCancellable>()

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
