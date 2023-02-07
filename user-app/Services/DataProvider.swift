//
//  DoctorProvider.swift
//  user-app
//
//

import Foundation

let doctorsFile = "doctors"
let prescriptionsFile = "prescriptions"
let opinionsFile = "opinions"

class DataProvider {
    static var shared: DataProvider = DataProvider()
    
    var doctors: [Doctor]!
    var prescriptions: [Prescription]!
    var opinions: [Opinion]!
    
    func randomPrescriptions(min: Int = 1, max: Int = 10) -> [Prescription] {
        var randomPrescriptions: [Prescription] = []
        
        let total = DataProvider.shared.prescriptions.count
        let maxCount = Int.random(in: (min < 1 ? 1 : min) ..< (max < min ? min : max))
        
        for _ in 1...maxCount {
            let index = Int.random(in: 0 ..< total)
            randomPrescriptions.append(DataProvider.shared.prescriptions[index])
        }
        
        return randomPrescriptions;
    }
    
    func randomDoctors(min: Int = 1, max: Int = 10) -> [Doctor] {
        var randomDoctors: [Doctor] = []
        
        let total = DataProvider.shared.doctors.count
        let maxCount = Int.random(in: (min < 1 ? 1 : min) ..< (max < min ? min : max))

        for _ in 1...maxCount {
            let index = Int.random(in: 0 ..< total)
            randomDoctors.append(DataProvider.shared.doctors[index])
        }
        
        return randomDoctors;
    }
    
    func randomOpinions(min: Int = 1, max: Int = 10) -> [Opinion] {
        var randomOpinions: [Opinion] = []
        
        let total = DataProvider.shared.opinions.count
        let maxCount = Int.random(in: (min < 1 ? 1 : min) ..< (max < min ? min : max))

        for _ in 1...maxCount {
            let index = Int.random(in: 0 ..< total)
            randomOpinions.append(DataProvider.shared.opinions[index])
        }
        
        return randomOpinions;
    }
    
    init() {
        
        do {
            let doctorsData = DataProvider.readLocalFile(forName: doctorsFile);
            doctors = try JSONDecoder().decode([Doctor].self, from: doctorsData!)
            
            let prescriptionsData = DataProvider.readLocalFile(forName: prescriptionsFile);
            prescriptions = try JSONDecoder().decode([Prescription].self, from: prescriptionsData!)
            
            let opinionsData = DataProvider.readLocalFile(forName: opinionsFile);
            opinions = try JSONDecoder().decode([Opinion].self, from: opinionsData!)
        } catch {
            debugPrint(error)
        }
    }
    
    private static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            debugPrint(error)
        }
        
        return nil
    }
}
