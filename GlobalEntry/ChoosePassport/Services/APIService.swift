//
//  APIService.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 23.05.23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase

//final class APIService {
//
//    static let shared = APIService()
//    private init() {}
//    var country = [Country]()
//    var ref: DatabaseReference!
//
//    func getCountries() {
//
//        ref = Database.database().reference().child("Country")
//        ref.observeSingleEvent(of: .value, with: { snapshot in
//            guard let json = snapshot.value as? [[String: Any]] else { return }
//
//            for passportJson in json {
//                guard let Passport = passportJson["Passport"] as? String else { continue }
//
//                let country = Country(Passport: Passport)
//                self.country.append(country)
//            }
//        })
//    }
//}
    //    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
    //
    //                var ref: DatabaseReference!
    //                ref = Database.database().reference().child("Passport")
    //
    //        let urlString = "https://globalentry-fcda0-default-rtdb.firebaseio.com"
    //        let url = URL(string: urlString)!
    //
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            if let error = error {
    //                completion(.failure(error))
    //                return
    //            }
    //            guard let data = data else {
    //                fatalError("Data can not be found")
    //            }
    //
    //            do {
    //                let country = try JSONDecoder().decode([Country].self, from: data)
    //                completion(.success(country))
    //            } catch(let error) {
    //                completion(.failure(error))
    //            }
    //        }.resume()
    //    }

