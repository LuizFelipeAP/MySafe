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
    @IBOutlet weak var applicationLogoImageView: UIImageView!
    @IBOutlet weak var applicationNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passcodeTextField: UITextField!
    
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    //MARK: - Properties
    
    var revealButton: UIButton!
    
    var accountDetailManager: AccountDetailManager!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureRevealButton()
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
        let accountDetailManager = AccountDetailManager(account: account)
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
    
}
