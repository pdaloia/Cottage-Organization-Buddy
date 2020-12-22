//
//  ToastMessageDisplayer.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-22.
//

import UIKit

class ToastMessageDisplayer {
    
    static func showToast(controller: UIViewController, message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
        
    }
    
}
