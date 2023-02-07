//
//  DoctorViewCell.swift
//  user-app
//
//

import UIKit
import Kingfisher

class DoctorViewCell: UICollectionViewCell, IdentifiableCell {
    
    private static let nibName = String(describing: DoctorViewCell.self)
    static let reuseIdentifier = nibName
    static let nib = UINib(nibName: nibName, bundle: nil)
    
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSpecialty: CustomPaddingLabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblRank: UILabel!

    var doctor: Doctor! {
        didSet {
            if let avatar = doctor.avatar {
                let source = ImageResource(downloadURL: avatar)
                self.ivAvatar.kf.setImage(with: .network(source))
            }
            
            lblName.text = doctor.fullName;
            lblSpecialty.text = doctor.job;

            lblPopularity.text = String(doctor.rank);
            lblRank.text = String(doctor.popularity);
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
