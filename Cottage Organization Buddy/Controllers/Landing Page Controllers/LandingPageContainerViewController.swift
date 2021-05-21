//
//  LandingPageContainerViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-21.
//

import UIKit

class LandingPageContainerViewController: UIViewController {

    //MARK: - Properties
    
    var sideMenuVC: SideMenuViewController!
    var centerVC: UIViewController!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions

    func configureLandingPageViewController(with cottageInfos: [CottageInfo]) {
        
        let landingPageVC = LandingPageViewController()
        landingPageVC.userCottages = cottageInfos
        landingPageVC.sideMenuButtonDelegate = self
        
        centerVC = UINavigationController(rootViewController: landingPageVC)
        self.view.addSubview(centerVC.view)
        self.addChild(centerVC)
        centerVC.didMove(toParent: self)
        
    }
    
    func configureSideMenuViewController() {
        
        //configure
        
    }
    
}

extension LandingPageContainerViewController: SideMenuButtonDelegate {
    
    func handleMenuToggle(forMenuOption menuOption: SideMenuOption?) {
        
        print("Menu toggle...")
        
    }
    
}
