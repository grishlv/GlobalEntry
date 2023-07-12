//
//  Country.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 28.05.23.

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
}