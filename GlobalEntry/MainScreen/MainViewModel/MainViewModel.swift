import Foundation
import UIKit
import RealmSwift
import Combine

final class MainViewModel: ObservableObject {
    
    @Published var filteredFeatures: [Feature] = []
    var features: [Feature] = []
    var cancellables = Set<AnyCancellable>()
    
    var filters = Filter()
    let dataModel: FeatureDataModels
    let imageService: ImageServiceProtocol
    let visaFreeTypes = ["visa free", "90", "30", "180", "120", "21", "14", "360", "60", "15", "42", "45", "28", "240", "10", "7", "31"]
    
    init(dataModel: FeatureDataModels, imageService: ImageServiceProtocol) {
        self.dataModel = dataModel
        self.imageService = imageService
    }
}

extension MainViewModel {
    
    //MARK: - load country data
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
}

extension MainViewModel {
    
    //MARK: - setup filter feature
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
}

extension MainViewModel {
    
    //MARK: - setup search feature
    func filterFeatures(with text: String) {
        if text.isEmpty {
            filteredFeatures = features
        } else {
            filteredFeatures = features.filter { $0.destination.lowercased().starts(with: text.lowercased()) }
        }
    }
}

extension MainViewModel {
    
    //MARK: - setup favorite status functions
//    func toggleFavorite(at index: Int) {
//        guard index < features.count else { return }
//        let featureId = features[index].id
//        dataModel.toggleFavorite(for: featureId)
//    }
    
    func toggleFavorite(at index: Int) {
        guard index < features.count else { return }
        let featureId = features[index].id
        dataModel.toggleFavorite(for: featureId) { [weak self] isFavoriteNow in
            if let idx = self?.filteredFeatures.firstIndex(where: { $0.id == featureId }) {
                // Update the isFavorite status of the feature in filteredFeatures
                self?.filteredFeatures[idx].isFavorite = isFavoriteNow
            }
        }
    }
}
