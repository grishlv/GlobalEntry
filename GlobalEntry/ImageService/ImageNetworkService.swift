import FirebaseStorage
import UIKit
import Kingfisher

protocol ImageServiceProtocol {
    func getImage(for feature: Feature, uniqueId: String, completion: @escaping (String, UIImage?) -> Void)
}

final class ImageService: ImageServiceProtocol {

    func getImage(for feature: Feature, uniqueId: String, completion: @escaping (String, UIImage?) -> Void) {
        guard !feature.imageURL.isEmpty else {
            print("Image URL is empty:")
            completion(uniqueId, UIImage(named: "placeholderImage"))
            return
        }
        
        let storageRef = Storage.storage().reference().child("images/\(feature.imageURL).jpg")
        storageRef.downloadURL { url, error in
            guard let imageURL = url, error == nil else {
                print("Failed to get image URL: \(error?.localizedDescription ?? "")")
                completion(uniqueId, UIImage(named: "placholderImage"))
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
                    print("Failed to retrieve image: \(error.localizedDescription)")
                    completion(uniqueId, UIImage(named: "placeholderImage"))
                }
            }
        }
    }
}
