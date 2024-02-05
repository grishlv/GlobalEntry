import Foundation
import UIKit
import Combine
import RealmSwift

final class FavoritesViewModel: ObservableObject {
    
    let dataModel: FeatureDataModels
    let imageService: ImageServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(dataModel: FeatureDataModels, imageService: ImageServiceProtocol) {
        self.dataModel = dataModel
        self.imageService = imageService
    }
    //MARK: - fetch images from Network Service
    func fetchImage(for feature: Feature, uniqueId: String, completion: @escaping (String, UIImage?) -> Void) {
        imageService.getImage(for: feature, uniqueId: uniqueId, completion: completion)
    }
}
//    func toggleFavorite(at index: Int) {
//        guard index < dataModel.favoriteFeatures.count else { return }
//        let feature = dataModel.favoriteFeatures[index]
//        dataModel.toggleFavorite(for: feature.id)
//    }

