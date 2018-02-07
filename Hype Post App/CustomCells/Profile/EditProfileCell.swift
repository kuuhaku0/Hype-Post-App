//
//  EditProfileCell.swift
//  Hype Post App
//
//  Created by C4Q on 2/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material
import SnapKit

class EditProfileCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        resignFirstResponder()
    }
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBAction func changeHeaderImageButton(_ sender: Any) {
    }
    @IBOutlet weak var profileImageContainer: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBAction func changeProfileImageButton(_ sender: UIButton) {
        
    }
    @IBOutlet weak var usernameTF: TextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        profileImageContainer.clipsToBounds = true
        profileImageContainer.borderColor = .white
        profileImageContainer.layer.borderWidth = 4
        profileImageContainer.layer.cornerRadius = 20
    }
}
