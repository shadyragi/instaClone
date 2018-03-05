//
//  searchCell.swift
//  testApi
//
//  Created by shady on 12/3/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit

class searchCell: UITableViewCell {

    
    @IBOutlet weak var userImage: UIImageView!
   
    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var followBtn: UIButton!
    
    
    
    
    func updateCell(user: Profile) {
        
        self.userImage.image = UIImage(named: "profile")
        
        self.userName.text = user.name
        
        self.followBtn.tag = user.id
        
        if user.followed {
            
            self.followBtn.backgroundColor = UIColor.lightGray
            self.followBtn.setTitle("following", for: .normal)
        }
        
    }
}
