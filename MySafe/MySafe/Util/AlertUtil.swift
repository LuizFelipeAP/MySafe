//
//  AlertUtil.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class AlertUtil {

    private init() { }
    
    static func showInfo(title: String, message: String, from viewController: UIViewController, completion: ((UIAlertAction) -> ())? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showConfirmation(title: String, message: String, from viewController: UIViewController, confirmCompletion: ((UIAlertAction) -> ())? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Confirm", style: .default, handler: confirmCompletion)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
