//
//  CustomTableViewHeader.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 04/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class CustomTableViewHeader: UITableViewHeaderFooterView {

    override var reuseIdentifier: String? {
        return "CustomTableViewHeader"
    }
    
    static var identifier: String {
        return "CustomTableViewHeader"
    }
    
    static var height: CGFloat {
        return 66.0
    }
    
    @IBOutlet weak var applicationNameLabel: UILabel!
    @IBOutlet weak var applicationLogoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with sectionName: String) {
        self.applicationNameLabel.text = sectionName
    }
}
