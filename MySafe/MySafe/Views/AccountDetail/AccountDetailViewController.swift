//
//  AccountDetailViewController.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class AccountDetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var applicationLogoImageView: UIImageView!
    @IBOutlet weak var applicationNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passcodeTextField: UITextField!
    
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    //MARK: - Properties
    
    var revealButton: UIButton!
    var saveBarButtonItem: UIBarButtonItem!
    
    var accountDetailManager: AccountDetailManager!
    
    var latestFromFields: Observable<(String?, String?, String?)>!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.styleView()
        
        self.configureRevealButton()
        self.configureEditBarButtonItem()
        self.bindUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//**************************************************************************************
//
// MARK: - Methods Extension
//
//**************************************************************************************
extension AccountDetailViewController {
    
    func bindManagers(account: Account) {
        let persistenceService = KeychainPersistence()
        let accountDetailManager = AccountDetailManager(account: account, persistenceService: persistenceService)
        self.bind(accountDetailManager: accountDetailManager)
    }
    
    func bind(accountDetailManager: AccountDetailManager) {
        self.accountDetailManager = accountDetailManager
    }
    
    func bindUI() {
        
        //ImageView
        self.accountDetailManager.accountObservable
            .map { account -> URL? in
                guard let url = URL(string: EndPoints.logo.rawValue),
                    let application = account?.application else { return nil }
                
                return url.appendingPathComponent(application)
            }
            .filter {$0 != nil }
            .subscribe(onNext: {
                self.applicationLogoImageView.kf
                    .setImage(with: $0,
                              placeholder: nil,
                              options: [UserSession.shared.kingfisherModifier])
            })
            .disposed(by: self.disposeBag)
        
        //Application name
        self.accountDetailManager.accountObservable
            .map { $0?.application }
            .bind(to: self.applicationNameTextField.rx.text)
            .disposed(by: self.disposeBag)
        
        //Username
        self.accountDetailManager.accountObservable
            .map { $0?.username }
            .bind(to: self.usernameTextField.rx.text)
            .disposed(by: self.disposeBag)
        
        //Password
        self.accountDetailManager.accountObservable
            .map { $0?.passcode }
            .bind(to: self.passcodeTextField.rx.text)
            .disposed(by: self.disposeBag)
        
        //Reveal Button
        self.revealButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                if self.passcodeTextField.isSecureTextEntry {
                    self.passcodeTextField.isSecureTextEntry = false
                    self.revealButton.setImage(#imageLiteral(resourceName: "unlocked"), for: .normal)
                } else {
                    self.passcodeTextField.isSecureTextEntry = true
                    self.revealButton.setImage(#imageLiteral(resourceName: "locked"), for: .normal)
                }
            })
            .disposed(by: self.disposeBag)
        
        //Copy Button
        self.copyButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                UIPasteboard.general.string = self.passcodeTextField.text
            })
            .disposed(by: self.disposeBag)
        
        //Delete Button
        self.deleteButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                
                AlertUtil.showConfirmation(title: "Delete account", message: "Are you sure you want to delete this account?", from: self) { _ in
                
                    let deleted = self.accountDetailManager.removeAccount()
                    
                    self.presentDeletionAlert(forState: deleted)
                }
            })
            .disposed(by: self.disposeBag)
        
        //Edition
        
        self.latestFromFields = Observable.combineLatest(self.applicationNameTextField.rx.text,
                                                         self.usernameTextField.rx.text,
                                                         self.passcodeTextField.rx.text)
        
        self.latestFromFields
            .subscribe(onNext: {
                
                if let application = $0.0,
                    let username = $0.1,
                    let passcode = $0.2 {
                    
                    let eddited = Account(application: application, username: username, passcode: passcode)
                    
                    self.accountDetailManager.edditedAccount = eddited
                    
                    self.saveBarButtonItem.isEnabled = self.accountDetailManager.isAccountEddited()
                }

            })
            .disposed(by: self.disposeBag)
        
        self.saveBarButtonItem.rx
            .tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.handleSaveBarButtonItemClick()
            })
            .disposed(by: self.disposeBag)
    }
    
    func configureRevealButton() {
        let button = UIButton(type: .custom)
        
        button.setImage(#imageLiteral(resourceName: "locked"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        button.frame = CGRect(x: CGFloat(self.passcodeTextField.frame.size.width - 25),
                              y: CGFloat(5),
                              width: CGFloat(15),
                              height: CGFloat(15))
        
        self.passcodeTextField.rightView = button
        self.passcodeTextField.rightViewMode = .always
        
        self.revealButton = button
    }
    
    func configureEditBarButtonItem() {
        
        self.saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
        self.navigationItem.setRightBarButton(self.saveBarButtonItem, animated: true)
    }
    
    /**
     Present an alert informing if the deletion was sucessfull or not
     
     - parameters:
        - state: A boolean value indicating if the deletion was sucessfull
     
     */
    func presentDeletionAlert(forState state: Bool) {
        
        let title: String
        let message: String
        
        if state {
            title = "Success"
            message = "Account deleted"
        } else {
            title = "Failure"
            message = "Can't delete this account, try again"
        }
        
        AlertUtil.showInfo(title: title, message: message, from: self) { _ in
            if state {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
   
    func handleSaveBarButtonItemClick() {
        let saveResult = self.accountDetailManager.editAccount()
        
        let title: String
        let message: String
        
        message = saveResult.1
        
        if saveResult.0 {
            title = "Success"
        } else {
            title = "Failure"
        }
        
        AlertUtil.showInfo(title: title, message: message, from: self)
    }
    
    
    //MARK: - UI
    fileprivate func styleView() {
        
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
        
        
        //Round the iamgeView
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        let height = self.applicationLogoImageView.frame.height
        self.applicationLogoImageView.layer.cornerRadius = height / 2
        self.applicationLogoImageView.clipsToBounds = true
        
        self.applicationLogoImageView.layer.borderColor = UIColor.white.cgColor
        self.applicationLogoImageView.layer.borderWidth = 1
    }
}
