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
    var accountDetailManager: AccountDetailManager!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
    }
    
}
