//
//  ScheduleViewController.swift
//  user-app
//
//

import UIKit

class ScheduleViewController: UIViewController {
    @IBOutlet weak var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendar()
    }
    
    func setupCalendar() {
        let calendarView = UICalendarView()
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.tintColor = UIColor(named: "accentColor")
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            calendarView.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
