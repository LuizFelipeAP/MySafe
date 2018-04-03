//
//  SignupViewController.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    
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
extension SignupViewController {
    
    @IBAction func didPressCancel(barButtonItem: UIBarButtonItem) {
        self.dismiss()
    }
    
    @IBAction func didPressDone(barButtonItem: UIBarButtonItem) {
        self.dismiss()
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
}
