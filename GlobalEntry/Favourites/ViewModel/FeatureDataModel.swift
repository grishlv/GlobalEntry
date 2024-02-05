import Foundation
import Combine
import RealmSwift

final class FeatureDataModels: ObservableObject {
    
    @Published var favoriteFeatures: [Feature] = []
    
    //MARK: - add to Realm favourite items
    func toggleFavorite(for featureId: String, completion: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            if let feature = realm.objects(Feature.self).filter("id == %@", featureId).first {
                try realm.write {
                    feature.isFavorite.toggle()
                    completion(feature.isFavorite)
                }
                updateFavoriteStatus()
            }
        } catch {
            print("Error toggling favorite status: \(error)")
            completion(false)
        }
    }
    
    //MARK: - update favorite status
    func updateFavoriteStatus() {
        do {
            let realm = try Realm()
            let favorites = realm.objects(Feature.self).filter("isFavorite == true")
            self.favoriteFeatures = Array(favorites)
        } catch {
            print("Error updating favorite features: \(error)")
        }
    }
        
    //MARK: - clear favorites items
    func clearFavorites() {
        do {
            let realm = try Realm()
            try realm.write {
                let favorites = realm.objects(Feature.self).filter("isFavorite == true")
                for feature in favorites {
                    feature.isFavorite = false
                }
            }
        } catch {
            print("Failed to clear favorites: \(error.localizedDescription)")
        }
        favoriteFeatures = []
    }
}
