//
//  AccountsViewController.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
        self.tableView.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Methods
    @objc func tapMethod() {
        let acStoryboard = UIStoryboard(name: "AccountDetail", bundle: nil)
        guard let accountDetailVC = acStoryboard.instantiateInitialViewController() as? AccountDetailViewController else { return }
        
        self.navigationController?.pushViewController(accountDetailVC, animated: true)
    }
  
}

//**************************************************************************************
//
// MARK: - Actions Extension
//
//**************************************************************************************
extension AccountsViewController {
    
    @IBAction func didPressExit(barButtonItem: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressAdd(barButtonItem: UIBarButtonItem) {
        
        let nStoryboard = UIStoryboard(name: "NewAccount", bundle: nil)
        guard let newAccountVC = nStoryboard.instantiateInitialViewController() as? NewAccountViewController else { return }
        
        self.present(newAccountVC, animated: true, completion: nil)
    }
}












