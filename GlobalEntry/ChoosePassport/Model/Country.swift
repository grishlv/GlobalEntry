import Foundation
import RealmSwift

class Country: Object {
    @objc dynamic var passport: String = ""
    let features = List<Feature>()
}

class Feature: Object {
    @objc dynamic var destination: String = ""
    @objc dynamic var requirement: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var id: String = ""
    @objc dynamic var continent: String = ""
    @objc dynamic var english: String = ""
}
