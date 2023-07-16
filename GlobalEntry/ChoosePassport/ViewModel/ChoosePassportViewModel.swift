//
//  ChoosePassportViewModel.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 26.06.23.
//

import Foundation
import RealmSwift

protocol ChoosePassportViewModelDelegate: AnyObject {
    func didSelectCountry(_ passportName: String)
}

final class ChoosePassportViewModel {
    
    weak var delegate: ChoosePassportViewModelDelegate?
    public var passports: Results<Country>?
    public var filtered: Results<Country>?
    
    //MARK: - fetch data
    
    public func fetchData() {
        guard let filePath = Bundle.main.path(forResource: "jsonFileNew", ofType: "json") else {
            return
        }
        
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
        
        do {
            let fileURL = URL(fileURLWithPath: filePath)
            let jsonData = try Data(contentsOf: fileURL)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            if let jsonDict = json as? [String: Any], let jsonArray = jsonDict["country"] as? [[String: Any]] {
                let realm = try Realm(configuration: config)
                
                try realm.write {
                    
                    realm.deleteAll()
                    
                    for countryDict in jsonArray {
                        let country = Country()
                        country.passport = countryDict["passport"] as? String ?? ""
                        
                        if let featuresArray = countryDict["features"] as? [[String: Any]] {
                            for featureDict in featuresArray {
                                let feature = Feature()
                                feature.destination = featureDict["destination"] as? String ?? ""
                                feature.requirement = featureDict["requirement"] as? String ?? ""
                                feature.imageURL = featureDict["imageURL"] as? String ?? ""
                                feature.isFavorite = featureDict["isFavorite"] as? Bool ?? false
                                feature.id = featureDict["id"] as? String ?? ""
                                
                                country.features.append(feature)
                            }
                        }
                        realm.add(country)
                    }
                }
                passports = realm.objects(Country.self)
                filtered = passports
            }
        } catch {
            print("Error:", error)
        }
    }
    
    //MARK: - perform search
    public func performSearch(with searchText: String) {
        
        if searchText.isEmpty {
            filtered = passports
        } else {
            let predicate = NSPredicate(format: "passport BEGINSWITH[cd] %@", searchText)
            filtered = passports?.filter(predicate).sorted(byKeyPath: "passport", ascending: true)
            
            let filteredResults = try? Realm().objects(Country.self).filter(predicate)
            let uniquePassports = filteredResults?
                .sorted(byKeyPath: "passport", ascending: true)
                .distinct(by: ["passport"])
            
            filtered = uniquePassports
        }
    }
}
