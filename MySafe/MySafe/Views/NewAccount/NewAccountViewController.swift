//
//  NewAccountViewController.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewAccountViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var navigationBar: UINavigationBar!

    @IBOutlet weak var applicationTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passcodeTextField: UITextField!
    
    //MARK: - Properties
    var newAccountManager: NewAccountManager!
    
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
extension NewAccountViewController {
    
    @IBAction func didPressCancel(barButtonItem: UIBarButtonItem) {
        self.dismiss()
    }
    
    @IBAction func didPressSave(barButtonItem: UIBarButtonItem) {
        
        let title: String
        let message: String
        
        let saveResult = self.newAccountManager.saveAccount()
        
        message = saveResult.1
        
        if saveResult.0 {
            title = "Success"
        } else {
            title = "Failure"
        }
        
        AlertUtil.showInfo(title: title, message: message, from: self) { _ in
            self.dismiss()
        }
    }
}

//**************************************************************************************
//
// MARK: - Methods Extension
//
//**************************************************************************************
extension NewAccountViewController {
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func bindManagers() {
        let newAccountManager = NewAccountManager()
        self.bind(newAccountManager: newAccountManager)
    }
    
    func bind(newAccountManager: NewAccountManager) {
        self.newAccountManager = newAccountManager
    }
    
    func bindUI() {
        
        self.applicationTextField.rx
            .text
            .orEmpty
            .bind(to: self.newAccountManager.application)
            .disposed(by: self.disposeBag)
        
        self.usernameTextField.rx
            .text
            .orEmpty
            .bind(to: self.newAccountManager.username)
            .disposed(by: self.disposeBag)
        
        self.passcodeTextField.rx
            .text
            .orEmpty
            .bind(to: self.newAccountManager.passcode)
            .disposed(by: self.disposeBag)
    }
}
