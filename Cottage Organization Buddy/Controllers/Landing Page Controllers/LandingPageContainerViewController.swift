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
    var signOutProtocol: SignOutProtocol?
    
    var isExpanded: Bool = false
    
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
        
        if sideMenuVC == nil {
            sideMenuVC = SideMenuViewController()
            sideMenuVC.sideMenuDelegate = self
            self.view.insertSubview(sideMenuVC.view, at: 0)
            self.addChild(sideMenuVC)
            sideMenuVC.didMove(toParent: self)
            print("Configuring side menu")
        }
        
    }
    
    func animateSideMenuViewController(shouldExpand: Bool, menuOption: SideMenuOption?) {
        
        if isExpanded {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerVC.view.frame.origin.x = self.centerVC.view.frame.width - 80
            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerVC.view.frame.origin.x = 0
            }, completion: { _ in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            })
        }
        
    }
    
    func didSelectMenuOption(menuOption: SideMenuOption) {
        
        switch menuOption {
        case .Profile:
            print("Show Profile")
        case .SelectCottage:
            print("Go To Landing Page")
        case .Settings:
            print("Show Settings")
        case .Logout:
            print("Logging out")
            signOutProtocol?.signOutCurrentUser()
        }
        
    }
    
}

extension LandingPageContainerViewController: SideMenuButtonDelegate {
    
    func handleMenuToggle(forMenuOption menuOption: SideMenuOption?) {
        
        if !isExpanded {
            configureSideMenuViewController()
        }
        
        self.isExpanded.toggle()
        animateSideMenuViewController(shouldExpand: self.isExpanded, menuOption: menuOption)
        
    }
    
}
