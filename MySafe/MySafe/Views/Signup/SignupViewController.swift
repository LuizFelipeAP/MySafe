//
//  SignupViewController.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignupViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passcodeTextField: UITextField!
    
    //MARK: - Properties
    var signupManager: SignupManager!
    
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
extension SignupViewController {
    
    @IBAction func didPressCancel(barButtonItem: UIBarButtonItem) {
        self.dismiss()
    }
    
    @IBAction func didPressDone(barButtonItem: UIBarButtonItem) {
        
        self.signupManager.registerUser { (isAuthenticated, message) in
    
            if isAuthenticated {
                
                let aStoryboard = UIStoryboard(name: "Accounts", bundle: nil)
                guard let accountVC = aStoryboard.instantiateInitialViewController() as? UINavigationController else { return }
                
                self.present(accountVC, animated: true, completion: nil)
            } else {
                AlertUtil.showInfo(title: "Opps",
                                   message: message,
                                   from: self)
            }
            
        }
    }
}

//**************************************************************************************
//
// MARK: - Methods Extension
//
//**************************************************************************************
extension SignupViewController {
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func bindManagers() {
        let signupManager = SignupManager()
        self.bind(signupManager: signupManager)
    }
    
    func bind(signupManager: SignupManager) {
        self.signupManager = signupManager
    }
    
    func bindUI() {
     
        self.nameTextField.rx
            .text
            .orEmpty
            .bind(to: self.signupManager.name)
            .disposed(by: self.disposeBag)
        
        self.usernameTextField.rx
            .text
            .orEmpty
            .bind(to: self.signupManager.username)
            .disposed(by: self.disposeBag)
        
        self.passcodeTextField.rx
            .text
            .orEmpty
            .bind(to: self.signupManager.passcode)
            .disposed(by: self.disposeBag)
    }
}
