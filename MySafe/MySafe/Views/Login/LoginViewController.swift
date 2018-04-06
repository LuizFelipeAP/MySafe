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
    var touchIDButton: UIButton!
    
    var loginManager: LoginManager!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindManagers()
        self.configureTouchIDButton()
        self.bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.usernameTextField.text = ""
        self.passcodeTextField.text = ""
        
        self.loginManager.loadAuthenticatedUsers()
        self.touchIDButton.isHidden = true
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
        
        self.loginManager.authenticateUser { isAuthenticated, message in
            
            if isAuthenticated {
            
                self.presentAccounts()
            } else {
                
                AlertUtil.showInfo(title: "Opps",
                                   message: message,
                                   from: self)
                
            }
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
        
        //TouchID
        
        if self.loginManager.deviceSupportTouchID {
        
            self.loginManager.canEnableTouchID
                .asObservable()
                .map { !$0 }
                .bind(to: self.touchIDButton.rx.isHidden)
                .disposed(by: self.disposeBag)
            
            self.touchIDButton.rx.tap
                .throttle(1.5, scheduler: MainScheduler.instance)
                .subscribe(onNext: {
                    
                    self.loginManager.authenticateWithTouchID { success, msg in
                        
                        if success {
                            self.presentAccounts()
                        } else {
                            let message = msg ?? "Some error occur, try again"
                            AlertUtil.showConfirmation(title: "Error", message: message, from: self)
                        }
                    }
                })
                .disposed(by: self.disposeBag)
        }
        
    }
    
    func configureTouchIDButton() {
        
        let button = UIButton(type: .custom)
        
        button.setImage(#imageLiteral(resourceName: "touchID"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        button.frame = CGRect(x: CGFloat(self.passcodeTextField.frame.size.width - 25),
                              y: CGFloat(5),
                              width: CGFloat(20),
                              height: CGFloat(20))
        
        button.isHidden = true
        
        self.passcodeTextField.rightView = button
        self.passcodeTextField.rightViewMode = .always
        
        self.touchIDButton = button
    }
    
    func presentAccounts() {
        let aStoryboard = UIStoryboard(name: "Accounts", bundle: nil)
        guard let accountsVC = aStoryboard.instantiateInitialViewController() as? UINavigationController else { return }
        
        self.present(accountsVC, animated: true, completion: nil)
    }
}







