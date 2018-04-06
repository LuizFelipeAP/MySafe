//
//  CustomTableViewHeader.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 04/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit
import Kingfisher

class CustomTableViewHeader: UITableViewHeaderFooterView {

    override var reuseIdentifier: String? {
        return "CustomTableViewHeader"
    }
    
    static var identifier: String {
        return "CustomTableViewHeader"
    }
    
    static var height: CGFloat {
        return 50.0
    }
    
    @IBOutlet weak var applicationNameLabel: UILabel!
    @IBOutlet weak var applicationLogoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func styleView() {
        //Make the imageView rounded
        let imageViewHeight = self.applicationLogoImageView.frame.height
        self.applicationLogoImageView.layer.cornerRadius = imageViewHeight / 2
        self.applicationLogoImageView.layer.masksToBounds = true
        
        //Give a thin border to the image
        self.applicationLogoImageView.layer.borderColor = UIColor.white.cgColor
        self.applicationLogoImageView.layer.borderWidth = 1.0
    }
    
    func configure(with sectionName: String) {
        self.applicationNameLabel.text = sectionName
        self.configureImageView(forLogoName: sectionName)
    }
    
    func configureImageView(forLogoName logoName: String) {
        
        let url: String = EndPoints.logo.rawValue
        
        let finalURL = URL(string: "\(url)/\(logoName)")
                
        self.applicationLogoImageView.kf.setImage(with: finalURL, options: [UserSession.shared.kingfisherModifier])
    }
}
