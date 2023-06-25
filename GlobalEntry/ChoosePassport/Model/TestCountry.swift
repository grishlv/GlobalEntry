//
//  TestCountry.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 22.06.23.
//

import Foundation
import RealmSwift

class Country: Object, Decodable {
    @objc dynamic var passport: String = ""
    let features = List<Feature>()
}

class Feature: Object, Decodable {
    @objc dynamic var destination: String = ""
    @objc dynamic var requirement: String = ""
}

