//
//  Doctor.swift
//  user-app
//
//

import Foundation

class Doctor: Decodable {
    let id: Int
    let first_name: String
    let last_name: String
    let email: String
    let photo: String
    let popularity: Int
    let rank: Int
    let patients: Int
    let job: String
    let phone: String
    let office: String
    let price_1: Double
    let price_2: Double
    let price_3: Double
    let price_4: Double
    let price_5: Double
    let price_6: Double
    
    var avatar: URL? {
        get {
            return URL(string: photo)
        }
    }
    
    
    var fullName: String {
        get { "\(first_name) \(last_name)" }
    }
    
    var prices: [Double] {
        get { [price_1, price_2, price_3, price_4, price_5, price_6] }
    }
}
