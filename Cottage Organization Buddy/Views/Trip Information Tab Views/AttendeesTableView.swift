//
//  AttendeesView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-06.
//

import UIKit

class AttendeesTableView: UITableView {
    
    var attendeesList: [Attendee]?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor(named: "Cottage Green Tertiary")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AttendeesTableView: UITableViewDelegate, UITableViewDataSource {
    
    //UITable data source methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return attendeesList!.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentCell = UITableViewCell()
        var currentAttendee = Attendee(name: "", firebaseUserID: "")
        
        switch indexPath.section {
        case 0:
            currentAttendee = attendeesList![indexPath.row]
        default:
            break;
        }
        
        currentCell.textLabel?.text = currentAttendee.name
        currentCell.backgroundColor = UIColor(named: "Cottage Green Tertiary")
        
        return currentCell
        
    }
    
}
