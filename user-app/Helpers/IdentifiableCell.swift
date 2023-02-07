//
//  IdentifiableViewCell.swift
//  user-app
//
//

import UIKit

protocol IdentifiableCell {
    static var nib: UINib { get }
    static var reuseIdentifier: String { get }
}
