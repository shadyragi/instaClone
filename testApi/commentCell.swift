//
//  commentCell.swift
//  testApi
//
//  Created by shady on 12/4/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit

import Alamofire

class commentCell: UITableViewCell {

    @IBOutlet weak var commentOwner: UILabel!
    
    @IBOutlet weak var comment: UILabel!
    
    @IBOutlet weak var commentOwnerImage: UIImageView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    var commentObj: Comment!
    
    func updateCell(commentData: Comment) {
        
        self.commentObj = commentData
        
        commentOwner.text = commentData.user["name"] as? String
        
        if commentData.isOwner {
            
            deleteBtn.isHidden = false
            
            deleteBtn.tag = commentData.id
        }
        else {
            
            deleteBtn.isHidden = true
        }
        
        
        comment.text = commentData.comment
        
        
        
        commentOwnerImage.image = UIImage(named: "profile")
        
    }
    
    
    
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
        
      
       
    
        
    }

   

}
