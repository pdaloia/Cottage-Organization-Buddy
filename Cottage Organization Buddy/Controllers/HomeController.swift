//
//  ViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import UIKit

class HomeController: UIViewController {

    //Action when clicking the button to enter the next UIViewController application from the HomeController
    @IBAction func enterCottageBuddyApp(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "CottageTabs", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CottageTabsView") as! CottageTabsController
        nextViewController.modalPresentationStyle = .fullScreen
        
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

