//
//  HomeViewController.swift
//  user-app
//
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cvPrescriptions: UICollectionView!
    @IBOutlet weak var cvDoctors: UICollectionView!
    
    var prescriptions: [Prescription] = [] {
        didSet {
            cvPrescriptions.reloadData()
        }
    }
    
    var doctors = [Doctor]() {
        didSet {
            cvDoctors.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvPrescriptions.bindTo(view: self, reusableCell: PrescriptionViewCell.self, scrollDirection: .vertical)
        
        cvDoctors.bindTo(view: self, reusableCell: DoctorViewCell.self, scrollDirection: .vertical)
        
        self.prescriptions = DataProvider.shared.randomPrescriptions(min: 2,max: 5)
        self.doctors = DataProvider.shared.randomDoctors(min: 2,max: 5)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DoctorDetailViewController {
            vc.doctor = (sender as! Doctor)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView == cvDoctors ? 132.0 : 140.0
        return CGSize(width: self.view.frame.width * 0.8, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == cvDoctors ? doctors.count : prescriptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cvDoctors {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorViewCell.reuseIdentifier, for: indexPath) as! DoctorViewCell
            cell.doctor = self.doctors[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrescriptionViewCell.reuseIdentifier, for: indexPath) as! PrescriptionViewCell
            cell.prescription = self.prescriptions[indexPath.row]
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout
                               collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != cvDoctors { return }
        let doctor = doctors[indexPath.item]
        performSegue(withIdentifier: "doctorDetailSegue", sender: doctor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}
