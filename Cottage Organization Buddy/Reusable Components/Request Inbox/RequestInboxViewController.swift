//
//  RequestInboxViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-01-31.
//

import UIKit

class RequestInboxViewController: UIViewController {
    
    var requestCollectionView: RequestCollectionView?
    var requestList: [RequestProtocol]
    
    //delegates
    var requestInboxDelegate: RequestInboxDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Requests"
        self.view.backgroundColor = UIColor(named: "Cottage Green Tertiary")
        
        setupRequestViewController()

        // Do any additional setup after loading the view.
    }
    
    init(requests: [RequestProtocol]) {
        
        self.requestList = requests
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRequestViewController() {
        
        //create the flow layout for the request collection view
        let requestFlowLayout = UICollectionViewFlowLayout()
        requestFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        
        //create the request collection view for the inbox
        self.requestCollectionView = RequestCollectionView(frame: self.view.frame, collectionViewLayout: requestFlowLayout)
        self.requestCollectionView?.requestCollectionDelegate = self
        self.requestCollectionView?.requestList = self.requestList
        
        //register the cells for the request collection view
        self.requestCollectionView?.register(RequestCell.self, forCellWithReuseIdentifier: "RequestCell")
        
        //set its flow layout delegate and data source as itself (implemented by it already)
        self.requestCollectionView?.dataSource = self.requestCollectionView
        self.requestCollectionView?.delegate = self.requestCollectionView
        
        //add the collection view to the controller's view
        self.requestCollectionView?.backgroundColor = .clear
        self.view.addSubview(self.requestCollectionView!)
        
        //set its auto layout constraints
        self.requestCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.requestCollectionView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.requestCollectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.requestCollectionView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.requestCollectionView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
    
}

extension RequestInboxViewController: RequestCollectionViewDelegate {
    
    func accept(request: RequestProtocol) {
        
        let acceptRequestConfirmation = UIAlertController(title: "Confirm Accept", message: "Accept " + request.requester.name + "'s request?", preferredStyle: .alert)
        acceptRequestConfirmation.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
            //do nothing
        }))
        acceptRequestConfirmation.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.requestInboxDelegate?.accept(request: request)
        }))
        
        present(acceptRequestConfirmation, animated: true, completion: nil)
        
    }
    
    func decline(request: RequestProtocol) {
        
        let declineRequestConfirmation = UIAlertController(title: "Confirm Decline", message: "Decline " + request.requester.name + "'s request'?", preferredStyle: .alert)
        declineRequestConfirmation.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
            //do nothing
        }))
        declineRequestConfirmation.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.requestInboxDelegate?.decline(request: request)
        }))
        
        present(declineRequestConfirmation, animated: true, completion: nil)
        
    }
    
}

protocol RequestInboxDelegate {
    
    func accept(request: RequestProtocol)
    
    func decline(request: RequestProtocol)
    
}
