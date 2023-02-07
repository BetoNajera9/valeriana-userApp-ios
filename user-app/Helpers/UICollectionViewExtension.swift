//
//  UICollectionViewExtension.swift
//  user-app
//
//

import UIKit

extension UICollectionView{
    func bindTo(view: UICollectionViewDelegate & UICollectionViewDataSource, reusableCell: IdentifiableCell.Type, scrollDirection: UICollectionView.ScrollDirection = .horizontal) {
        self.delegate = view
        self.dataSource = view
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        
        self.collectionViewLayout = layout
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .clear
        self.register(reusableCell.nib, forCellWithReuseIdentifier: reusableCell.reuseIdentifier)
    }
}
