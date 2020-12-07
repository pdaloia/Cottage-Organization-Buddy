//
//  AttendeesView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-06.
//

import UIKit

class AttendeesView: UITableView {
    
    var attendeesList: [Attendee]?

    var attendeeTableView = UITableView()

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AttendeesView: UITableViewDelegate, UITableViewDataSource {
    
    //UITable data source methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return attendeesList!.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentCell = UITableViewCell()
        var currentAttendee: Attendee!
        
        switch indexPath.section {
        case 0:
            currentAttendee = attendeesList![indexPath.row]
        default:
            break;
        }
        
        currentCell.textLabel?.text = currentAttendee.name
        
        return currentCell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch(section) {
        case 0:
            return "Attendees"
        default:
            return ""
        }
        
    }
    
}
