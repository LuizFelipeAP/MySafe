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
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!

    @IBOutlet weak var applicationTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passcodeTextField: UITextField!
    
    //MARK: - Properties
    var newAccountManager: NewAccountManager!
    
    let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.styleView()
        
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
            if saveResult.0 {
                self.dismiss()
            }
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
    
    //MARK: - UI
    fileprivate func styleView() {
        
        //Clear navigation Bar
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        
        self.containerView.backgroundColor = .clear
        
        //Create the blur
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.insertSubview(blurView, at: 0)
        
        //Add Constraints
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 1),
            blurView.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 1),
            blurView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            blurView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor)
            ])
        
        //Round the container
        blurView.layer.cornerRadius = 15
        blurView.clipsToBounds = true
    }
}
