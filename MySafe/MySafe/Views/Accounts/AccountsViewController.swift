//
//  AccountsViewController.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class AccountsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var accountsManager: AccountsManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindManagers()
        
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.accountsManager.fetchAccounts()
        self.tableView.reloadData()
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
extension AccountsViewController {
    
    @IBAction func didPressExit(barButtonItem: UIBarButtonItem) {
        
        //Check if came from Signup
        guard let homeVC =
            self.presentingViewController?.presentingViewController else {
                //If not dismiss directly to Login
                self.dismiss(animated: true, completion: nil)
                return
        }
        
        //If yes dismiss to login passing from Signup
        homeVC.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressAdd(barButtonItem: UIBarButtonItem) {
        
        let nStoryboard = UIStoryboard(name: "NewAccount", bundle: nil)
        guard let newAccountVC = nStoryboard.instantiateInitialViewController() as? NewAccountViewController else { return }
        
        self.present(newAccountVC, animated: true, completion: nil)
    }
}

//**************************************************************************************
//
// MARK: - Methods Extension
//
//**************************************************************************************
extension AccountsViewController {
    
    func bindManagers() {
        let accountsManager = AccountsManager()
        self.bind(accountsManager: accountsManager)
    }
    
    func bind(accountsManager: AccountsManager) {
        self.accountsManager = accountsManager
    }
    
    func configureTableView() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.tableFooterView = UIView()
        
        //RegisterNibs
        let headerNib = UINib(nibName: CustomTableViewHeader.identifier, bundle: nil)
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: CustomTableViewHeader.identifier)
    }
    
    func presentDetail(forAccount account: Account) {
        let acStoryboard = UIStoryboard(name: "AccountDetail", bundle: nil)
        guard let accountDetailVC = acStoryboard.instantiateInitialViewController() as? AccountDetailViewController else { return }
        
        accountDetailVC.bindManagers(account: account)
        
        self.navigationController?.pushViewController(accountDetailVC, animated: true)
    }
    
}

//**************************************************************************************
//
// MARK: - UITableViewDataSource Extension
//
//**************************************************************************************
extension AccountsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.accountsManager.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rowsCount = self.accountsManager.rowsPerSection.get(at: section)
        
        return rowsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let section = self.accountsManager.sections[indexPath.section]
        
        if let account: Account = self.accountsManager.grouped[section]?[indexPath.row] {
            cell.textLabel?.text = account.username
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

//**************************************************************************************
//
// MARK: - UITableViewDelegate Extension
//
//**************************************************************************************
extension AccountsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = self.accountsManager.sections[indexPath.section]
        
        guard let account = self.accountsManager.grouped[section]?[indexPath.row] else { return }
        
        
        
        self.presentDetail(forAccount: account)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomTableViewHeader.identifier) as? CustomTableViewHeader else { return UIView() }
        
        let sectionDesc = self.accountsManager.sections[section]
        
        header.configure(with: sectionDesc)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CustomTableViewHeader.height
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let customHeader = view as? CustomTableViewHeader else { return }
        customHeader.styleView()
    }
    
}
