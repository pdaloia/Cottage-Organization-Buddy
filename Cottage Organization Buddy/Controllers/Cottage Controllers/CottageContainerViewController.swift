//
//  CottageContainerViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-19.
//

import UIKit

class CottageContainerViewController: UIViewController {
    
    //MARK: - Properties

    var sideMenuController: SideMenuViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    var cottageModel: CottageTrip?
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Handlers
    
    func configureCottageTabsController() {
        
        let cottageTabsController = CottageTabsController()
        cottageTabsController.cottageModel = self.cottageModel!
        cottageTabsController.menuButtonDelegate = self
        cottageTabsController.loadViewControllersIntoTabBarController()
        centerController = cottageTabsController
        
        view.addSubview(centerController.view)
        self.addChild(centerController)
        centerController.didMove(toParent: self)
        
    }
    
    func configureSideMenuController() {
        
        if sideMenuController == nil {
            sideMenuController = SideMenuViewController()
            sideMenuController.sideMenuDelegate = self
            view.insertSubview(sideMenuController.view, at: 0)
            self.addChild(sideMenuController)
            sideMenuController.didMove(toParent: self)
            print("Did add side menu controller")
        }
        
    }
    
    func animateSideMenuController(shouldExpand: Bool, menuOption: SideMenuOption?) {
        
        if shouldExpand {
            
            //show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
            
        }
        else {
            
            //hide menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
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
            ToastMessageDisplayer.showToast(controller: self, message: "Profile not implemented yet, sorry :(", seconds: 2)
        case .SelectCottage:
            print("Go To Landing Page")
            self.dismiss(animated: true, completion: nil)
        case .Settings:
            print("Show Settings")
            ToastMessageDisplayer.showToast(controller: self, message: "Settings not implemented yet, sorry :(", seconds: 2)
        case .Logout:
            print("Logging out")
        }
        
    }

}

extension CottageContainerViewController: SideMenuButtonDelegate {
    
    func handleMenuToggle(forMenuOption menuOption: SideMenuOption?) {
        
        if !isExpanded {
            configureSideMenuController()
        }
        
        self.isExpanded.toggle()
        animateSideMenuController(shouldExpand: self.isExpanded, menuOption: menuOption)
        
    }
    
}
