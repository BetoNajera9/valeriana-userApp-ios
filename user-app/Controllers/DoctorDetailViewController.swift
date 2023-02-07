//
//  DoctorDetailViewController.swift
//  user-app
//
//

import UIKit
import Kingfisher

class DoctorDetailViewController: UIViewController {
    
    @IBOutlet weak var ivBack: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSpecialty: CustomPaddingLabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblRank: UILabel!
    
    @IBOutlet weak var ivPhone: UIImageView!
    @IBOutlet weak var ivMessage: UIImageView!
    @IBOutlet weak var ivSchedule: UIImageView!
    
    @IBOutlet var labelsMenu: [UILabel]!
    @IBOutlet var svSections: [UIStackView]!

    @IBOutlet weak var lblOfficeAddress: UILabel!
    @IBOutlet weak var lblPrices: UILabel!
    
    @IBOutlet weak var lblOpinions: UILabel!
    
    
    @IBOutlet weak var cvOpinions: UICollectionView!
    
    var doctor: Doctor!
    var opinions: [Opinion] = [] {
        didSet {
            cvOpinions.reloadData()
            lblOpinions.text = "\(opinions.count) Opiniones"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvOpinions.bindTo(view: self, reusableCell: OpinionCollectionViewCell.self, scrollDirection: .vertical)
        
        registerGestures(view: ivBack, action: #selector(close(_:)))
        
        registerGestures(view: ivPhone, action: #selector(phoneCall(_:)))
        registerGestures(view: ivMessage, action: #selector(sendMessage(_:)))
        registerGestures(view: ivSchedule, action: #selector(schedule(_:)))
        
        labelsMenu.enumerated().forEach { (index, label) in
            label.tag = index
            registerGestures(view: label, action: #selector(changeSection(_:)))
        }
        
        svSections.enumerated().forEach { (index, stackView) in
            stackView.tag = index
        }
        
        updateDoctorInfo()
        updateSectionView(section: 0)
    }
    
    func updateDoctorInfo() {
        if let avatar = doctor.avatar {
            let source = ImageResource(downloadURL: avatar)
            self.ivAvatar.kf.setImage(with: .network(source))
        }
        
        lblTitle.text = doctor.fullName
        lblName.text = doctor.fullName
        lblSpecialty.text = doctor.job
        
        lblPopularity.text = String(doctor.rank)
        lblRank.text = String(doctor.popularity)
        
        lblOfficeAddress.text = doctor.office
        
        lblPrices.text = doctor.prices.map { "Servicio : $" + String($0) }.joined(separator: "\n")
        
        opinions = DataProvider.shared.randomOpinions(min: 3, max: 25)
    }
    
    func updateSectionView(section: Int) {
        labelsMenu.forEach { label in
            let attributedString = NSMutableAttributedString.init(string: label.text!)
            let range = NSRange.init(location: 0, length: attributedString.length)
            
            if label.tag == section {
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: range);
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
            } else {
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "disabled")!, range: range)
            }
            
            label.attributedText = attributedString
        }
        
        svSections.forEach { stackView in
            stackView.isHidden = stackView.tag != section
        }
    }
    
    @objc func changeSection(_ sender: UITapGestureRecognizer) {
        updateSectionView(section: sender.view!.tag)
    }
    
    @objc func phoneCall(_ sender: Any?) {
        self.view.makeToast("Llamando... \(doctor.phone)")
    }
    
    @objc func sendMessage(_ sender: Any?) {
        self.view.makeToast("Enviando mensaje... \(doctor.email)")
    }
    
    @objc func schedule(_ sender: Any?) {
        self.view.makeToast("Por el momento no hay citas disponibles")
    }
    
    func registerGestures(view: UIView, action: Selector) {
        let gesture = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(gesture)
    }
    
    @objc func close(_ sender: Any?) {
        self.dismiss(animated: true)
    }
}

extension DoctorDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.8, height: 142)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return opinions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OpinionCollectionViewCell.reuseIdentifier, for: indexPath) as! OpinionCollectionViewCell
        
        cell.opinion = self.opinions[indexPath.row]
        
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
