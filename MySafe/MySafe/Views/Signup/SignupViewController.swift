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
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passcodeTextField: UITextField!
    
    //MARK: - Properties
    var signupManager: SignupManager!
    
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
        let apiService = APIService()
        let persistenceService = KeychainPersistence()
        
        let signupManager = SignupManager(apiService: apiService,
                                          persistenceService: persistenceService)
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
