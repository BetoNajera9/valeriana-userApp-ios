//
//  Prescription.swift
//  user-app
//
//

import Foundation

class Prescription: Decodable {
    let id: Int
    let prescription: [PrescriptionLine]
}

class PrescriptionLine: Decodable {
    let name: String
    let times: Int
    let days: Int
    let quantity: Int
    let description: String
}
