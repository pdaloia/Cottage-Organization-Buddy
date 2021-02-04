//
//  RequestCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-01-31.
//

import UIKit

class RequestCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .green
        setupRequestCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupRequestCell() {
        
        //add a dummy label
        let testLabel = UILabel()
        testLabel.text = "request"
        
        self.contentView.addSubview(testLabel)
        
    }
    
}
