//
//  LoginViewController.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passcodeTextField: UITextField!
    
    //MARK: - Properties
    var loginManager: LoginManager!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindManagers()
        self.bindUI()
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
        
        if self.loginManager.authenticateUser() {
            
            let aStoryboard = UIStoryboard(name: "Accounts", bundle: nil)
            guard let accountsVC = aStoryboard.instantiateInitialViewController() as? UINavigationController else { return }
            
            self.present(accountsVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func didPressSignup(button: UIButton) {
        
        let sStoryboard = UIStoryboard(name: "Signup", bundle: nil)
        guard let signupVC = sStoryboard.instantiateInitialViewController() as? SignupViewController else { return }
        
        self.present(signupVC, animated: true, completion: nil)
    }
}

//**************************************************************************************
//
// MARK: - Methods Extension
//
//**************************************************************************************
extension LoginViewController {
    
    func bindManagers() {
        let loginManager = LoginManager()
        self.bind(loginManager: loginManager)
    }
    
    func bind(loginManager: LoginManager) {
        self.loginManager = loginManager
    }
    
    func bindUI() {
        self.usernameTextField.rx
            .text
            .orEmpty
            .bind(to: self.loginManager.username)
            .disposed(by: self.disposeBag)
        
        self.passcodeTextField.rx
            .text
            .orEmpty
            .bind(to: self.loginManager.passcode)
            .disposed(by: self.disposeBag)
        
    }
}







