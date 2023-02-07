//
//  RecipesViewController.swift
//  user-app
//
//

import UIKit

class PrescriptionsViewController: UIViewController {
    
    @IBOutlet weak var cvPrescriptions: UICollectionView!

    var prescriptions: [Prescription] = [] {
        didSet {
            cvPrescriptions.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvPrescriptions.bindTo(view: self, reusableCell: PrescriptionViewCell.self, scrollDirection: .vertical)
        
        self.prescriptions = DataProvider.shared.randomPrescriptions()
    }
}

extension PrescriptionsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.8, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prescriptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrescriptionViewCell.reuseIdentifier, for: indexPath) as! PrescriptionViewCell
        
        cell.prescription = self.prescriptions[indexPath.row]
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout
                               collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}
