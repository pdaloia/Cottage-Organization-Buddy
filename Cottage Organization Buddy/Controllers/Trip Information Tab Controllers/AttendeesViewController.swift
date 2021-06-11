//
//  AttendeesViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-27.
//

import UIKit

class AttendeesViewController: UIViewController {
    
    var attendeesDataSource: AttendeesViewDataSource?
    
    var attendeesTableView: AttendeesTableView?
    var attendeesToDisplay: [Attendee]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Attendees"
        self.view.backgroundColor = UIColor(named: "Cottage Green Tertiary")
        
        if let dataSource = self.attendeesDataSource {
            self.attendeesToDisplay = dataSource.setAttendees()
        }
        
        initializeAttendeesView()
    }
    
    func initializeAttendeesView() {
        
        attendeesTableView = AttendeesTableView()
        attendeesTableView!.attendeesList = self.attendeesToDisplay!
        
        self.view.addSubview(attendeesTableView!)
        attendeesTableView!.translatesAutoresizingMaskIntoConstraints = false
        attendeesTableView!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        attendeesTableView!.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        attendeesTableView!.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        attendeesTableView!.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}

protocol AttendeesViewDataSource: class {
    
    func setAttendees() -> [Attendee]
    
}
