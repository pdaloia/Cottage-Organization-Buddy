//
//  LandingPageViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-28.
//

import UIKit

class LandingPageViewController: UIViewController {
    
    var userCottages: [CottageInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        initializeView()
    }
    
    func initializeView() {
        
        let landingPageView = LandingPageView()
        landingPageView.userCottages = userCottages!
        landingPageView.initializeCollectionView()
        landingPageView.landingPageViewDelegate = self
        
        self.view.addSubview(landingPageView)
        landingPageView.translatesAutoresizingMaskIntoConstraints = false
        landingPageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        landingPageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        landingPageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        landingPageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}

extension LandingPageViewController: LandingPageViewDelegate {
    
    func cottageCellPressed(for cottageID: String) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "CottageTabs", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CottageTabsView") as! CottageTabsController
        nextViewController.modalPresentationStyle = .fullScreen
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        let service = FirestoreServices()
        service.get(cottage: "test123456789") { model in
            
            nextViewController.cottageModel = model!
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        
    }
    
    func newCottageCellPressed() {
        print("new cottage pressed")
    }
    
}
