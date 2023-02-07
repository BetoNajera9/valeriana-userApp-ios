//
//  Opinion.swift
//  user-app
//
//

import Foundation

class Opinion: Decodable  {
    let id: Int
    let name: String
    let opinion: String
    let tags_1: String?
    let tags_2: String?
    let rank: Int
}
