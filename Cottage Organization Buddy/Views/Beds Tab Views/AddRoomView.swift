//
//  AddRoomView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-21.
//

import UIKit

class AddRoomView: UIView {
    
    let labelStackView = UIStackView()
    let inputStackView = UIStackView()
    
    let kingInput = UITextField()
    let queenInput = UITextField()
    let doubleInput = UITextField()
    let singleInput = UITextField()
    
    var addRoomDelegate: AddRoomDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createLabels()
        createNumberInputs()
        createLowerSection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLabels() {
        
        let kingLabel = UILabel()
        kingLabel.text = "Number of kings"
        
        let queenLabel = UILabel()
        queenLabel.text = "Number of queens"
        
        let doubleLabel = UILabel()
        doubleLabel.text = "Number of doubles"
        
        let singleLabel = UILabel()
        singleLabel.text = "Number of singles"
        
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalSpacing
        labelStackView.alignment = .center
        labelStackView.addArrangedSubview(kingLabel)
        labelStackView.addArrangedSubview(queenLabel)
        labelStackView.addArrangedSubview(doubleLabel)
        labelStackView.addArrangedSubview(singleLabel)
        
        self.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        labelStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3).isActive = true
        labelStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        
    }
    
    func createNumberInputs() {
        
        kingInput.backgroundColor = UIColor(named: "Cottage Green")
        kingInput.placeholder = "Kings"
        kingInput.keyboardType = .numberPad
        
        queenInput.backgroundColor = UIColor(named: "Cottage Green")
        queenInput.placeholder = "Queens"
        queenInput.keyboardType = .numberPad

        doubleInput.backgroundColor = UIColor(named: "Cottage Green")
        doubleInput.placeholder = "Doubles"
        doubleInput.keyboardType = .numberPad

        singleInput.backgroundColor = UIColor(named: "Cottage Green")
        singleInput.placeholder = "Singles"
        singleInput.keyboardType = .numberPad
        
        inputStackView.axis = .vertical
        inputStackView.distribution = .equalSpacing
        inputStackView.alignment = .fill
        
        inputStackView.addArrangedSubview(kingInput)
        inputStackView.addArrangedSubview(queenInput)
        inputStackView.addArrangedSubview(doubleInput)
        inputStackView.addArrangedSubview(singleInput)
        
        self.addSubview(inputStackView)
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        inputStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        inputStackView.leadingAnchor.constraint(equalTo: labelStackView.trailingAnchor).isActive = true
        inputStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/6).isActive = true
        inputStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        
    }
    
    func createLowerSection() {
        
        let addButton = UIButton()
        addButton.setTitleColor(.blue, for: .normal)
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        self.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 20).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    @objc func addButtonPressed() {
        
        let numberOfKings: Int = Int(kingInput.text!) ?? 0
        let numberOfQueens: Int = Int(queenInput.text!) ?? 0
        let numbersOfDoubles: Int = Int(doubleInput.text!) ?? 0
        let numberOfSingles: Int = Int(singleInput.text!) ?? 0
        
        if let addRoomDelegate = self.addRoomDelegate {
            addRoomDelegate.addRoom(kings: numberOfKings, queens: numberOfQueens, doubles: numbersOfDoubles, singles: numberOfSingles)
        }
        
    }
    
}

protocol AddRoomDelegate {
    
    func addRoom(kings: Int, queens: Int, doubles: Int, singles: Int)
    
}
