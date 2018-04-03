//
//  LoginViewController.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//**************************************************************************************
//
// MARK: - Actions Extension
//
//**************************************************************************************
extension LoginViewController {
    
    @IBAction func didPressLogin(button: UIButton) {
        
        let aStoryboard = UIStoryboard(name: "Accounts", bundle: nil)
        guard let accountsVC = aStoryboard.instantiateInitialViewController() as? AccountsViewController else { return }
        
        self.present(accountsVC, animated: true, completion: nil)
    }
    
    @IBAction func didPressSignup(button: UIButton) {
        
        let sStoryboard = UIStoryboard(name: "Signup", bundle: nil)
        guard let signupVC = sStoryboard.instantiateInitialViewController() as? SignupViewController else { return }
        
        self.present(signupVC, animated: true, completion: nil)
    }
    
}










