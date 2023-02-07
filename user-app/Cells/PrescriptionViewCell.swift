//
//  PrescriptionViewCell.swift
//  user-app
//
//

import UIKit


class PrescriptionViewCell: UICollectionViewCell, IdentifiableCell {
    
    private static let nibName = String(describing: PrescriptionViewCell.self)
    static let reuseIdentifier = nibName
    static let nib = UINib(nibName: nibName, bundle: nil)
    
    @IBOutlet weak var lblMedicine: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblFrequency: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var prescription: Prescription! {
        didSet {
            let line = prescription.prescription.first!
            
            let times = line.times <= 1 ? "\(line.times) vez" : "\(line.times) veces"
            let days = line.days <= 1 ? "\(line.days) dia" : "\(line.days) dias"

            lblMedicine.text = line.name
            lblFrequency.text = "\(times) por \(days)"
            lblQuantity.text = "\(line.quantity) mg"
            lblDescription.text = line.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
