//
//  LandingPageViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-28.
//

import UIKit
import FirebaseAuth

class LandingPageViewController: UIViewController {
    
    var userCottages: [CottageInfo]?
    
    var landingPageView: LandingPageView?
    var sideMenuButtonDelegate: SideMenuButtonDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cottages"
        self.view.backgroundColor = UIColor(named: "Cottage Green Tertiary")
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Cottage Beige")

        initializeView()
    }
    
    func initializeView() {
        
        //initializing the landing page view
        landingPageView = LandingPageView()
        landingPageView!.userCottages = userCottages!
        landingPageView!.initializeView()
        landingPageView!.landingPageViewDelegate = self
        
        self.view.addSubview(landingPageView!)
        landingPageView!.translatesAutoresizingMaskIntoConstraints = false
        landingPageView!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        landingPageView!.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        landingPageView!.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        landingPageView!.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        //creating the nav bar button
        let invitesBarButton = UIBarButtonItem(title: "Invites", style: .plain, target: self, action: #selector(invitesBarButtonPressed))
        self.navigationItem.rightBarButtonItem = invitesBarButton
        let sideMenuBarButton = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(sideMenuButtonPressed))
        self.navigationItem.leftBarButtonItem = sideMenuBarButton
        
    }
    
    @objc func invitesBarButtonPressed() {
        
        self.landingPageView?.startAnimatingActivityIndicator()
        
        let firestoreService = FirestoreServices()
        
        firestoreService.getInvitedCottages(for: Auth.auth().currentUser!.uid) { invitedCottages in
            
            let inviteInboxVC = CottageInviteInboxViewController()
            inviteInboxVC.invitedCottages = invitedCottages
            inviteInboxVC.cottageInviteInboxVCDelegate = self
            inviteInboxVC.modalPresentationStyle = .fullScreen
            
            self.landingPageView?.stopAnimatingActivityIndicator()
            
            self.navigationController!.pushViewController(inviteInboxVC, animated: true)
            
        }
        
    }
    
    @objc func sideMenuButtonPressed() {
        
        if let delegate = sideMenuButtonDelegate {
            delegate.handleMenuToggle(forMenuOption: nil)
        }
        
    }

}

extension LandingPageViewController: LandingPageViewDelegate {
    
    func cottageCellPressed(for cottageID: String) {
        
        self.landingPageView?.startAnimatingActivityIndicator()
        
        let nextViewController = CottageContainerViewController()
        nextViewController.modalPresentationStyle = .fullScreen
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        let service = FirestoreServices()
        service.get(cottage: cottageID) { model in
            
            nextViewController.cottageModel = model!
            nextViewController.configureCottageTabsController()
            self.landingPageView?.stopAnimatingActivityIndicator()
            
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        
    }

    func newCottageCellPressed() {
        
        let createCottageVC = CreateCottageViewController()
        createCottageVC.createCottageDelegate = self
        
        self.navigationController?.pushViewController(createCottageVC, animated: true)
        
    }
    
}

extension LandingPageViewController: CottageInviteInboxVCDelegate {
    
    func accepted(invite: CottageInfo) {
        
        self.userCottages!.append(invite)
        self.landingPageView!.userCottages!.append(invite)
        self.landingPageView!.cottageCollectionView!.userCottages!.append(invite)
        self.landingPageView!.cottageCollectionView!.reloadData()
        
    }
    
}

extension LandingPageViewController: CreateCottageVCDelegate {
    
    func created(cottage: CottageTrip) {
        
        let cottageInfoToAdd = CottageInfo(cottageID: cottage.cottageID, cottageName: cottage.tripName, cottageOrganiser: cottage.tripOrganiser)
        
        self.userCottages!.append(cottageInfoToAdd)
        self.landingPageView!.userCottages!.append(cottageInfoToAdd)
        self.landingPageView!.cottageCollectionView!.userCottages!.append(cottageInfoToAdd)
        self.landingPageView!.cottageCollectionView!.reloadData()
        
        //create the view controller to display the newly created cottage
        let nextViewController = CottageContainerViewController()
        nextViewController.modalPresentationStyle = .fullScreen
        nextViewController.cottageModel = cottage
        nextViewController.configureCottageTabsController()
        self.present(nextViewController, animated: true, completion: nil)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
