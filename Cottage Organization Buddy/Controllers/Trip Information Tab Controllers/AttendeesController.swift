//
//  AttendeesController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-19.
//

import UIKit

class AttendeesController: UIViewController, TabBarItemControllerProtocol, UITableViewDataSource, UITableViewDelegate {
    
    var cottageModel: CottageTrip?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Attendees"
    }
    
    //UITable data source methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return cottageModel!.attendeesList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentCell = UITableViewCell()
        var currentAttendee: Attendee!
        
        switch indexPath.section {
        case 0:
            currentAttendee = cottageModel!.tripOrganiser
        case 1:
            currentAttendee = cottageModel!.attendeesList[indexPath.row]
        default:
            break;
        }
        
        currentCell.textLabel?.text = currentAttendee.name
        
        return currentCell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch(section) {
        case 0:
            return "Trip Organiser"
        case 1:
            return "Attendees"
        default:
            return ""
        }
        
    }

}
