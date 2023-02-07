//
//  OpinionCollectionViewCell.swift
//  user-app
//
//

import UIKit

class OpinionCollectionViewCell: UICollectionViewCell, IdentifiableCell {
    
    private static let nibName = String(describing: OpinionCollectionViewCell.self)
    static let reuseIdentifier = nibName
    static let nib = UINib(nibName: nibName, bundle: nil)
    
    @IBOutlet weak var lblOpinion: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTag1: UILabel!
    @IBOutlet weak var lblTag2: UILabel!
    @IBOutlet weak var lblRank: UILabel!

    var opinion: Opinion! {
        didSet {
            lblOpinion.text = opinion.opinion
            lblName.text = opinion.name
            
            if let tag = opinion.tags_1 {
                lblTag1.text = tag
                lblTag1.isHidden = false
            }
            
            if let tag = opinion.tags_2 {
                lblTag2.text = tag
                lblTag2.isHidden = false
            }
            
            lblRank.text = String(opinion.rank)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
