//
//  SearchViewController.swift
//  user-app
//
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var cvSearch: UICollectionView!
    
    var allDoctors = [Doctor](){
        didSet {
            doctors = allDoctors;
        }
    }
    
    var doctors = [Doctor]() {
        didSet {
            cvSearch.reloadData()
        }
    }
    
    var filter = "" {
        didSet {
            doctors = filter == "" ? allDoctors : allDoctors.filter { doctor in doctor.job.lowercased().contains(filter) }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvSearch.bindTo(view: self, reusableCell: DoctorViewCell.self, scrollDirection: .vertical)
        
        fetchDoctors()
        
        tfSearch.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
    }
    
    func fetchDoctors() {
        self.allDoctors = DataProvider.shared.doctors
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        filter = textField.text!.lowercased()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DoctorDetailViewController {
            vc.doctor = (sender as! Doctor)
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.8, height: 132)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorViewCell.reuseIdentifier, for: indexPath) as! DoctorViewCell
        
        cell.doctor = self.doctors[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let doctor = doctors[indexPath.item]
        performSegue(withIdentifier: "doctorDetailSegue", sender: doctor)
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

