//
//  feedCell.swift
//  testApi
//
//  Created by shady on 11/28/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit
import Alamofire
class feedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
  
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var sharedImage: UIImageView!
    
    @IBOutlet weak var caption: UITextView!

    @IBOutlet weak var likesCount: UILabel!
  
    @IBOutlet weak var likeBtn: UIButton!
    
    
    @IBOutlet weak var cityName: UILabel!
    
    
    @IBOutlet weak var editBtn: UIButton!
    
    
    @IBAction func likePressed(_ sender: UIButton) {
    }
    
    
    func updateCell(post: Post) {
        
        
        
        username.text = post.username
        caption.text = post.caption
        
        let url = URL(string: "http://localhost:8000/\(post.sharedImage)")
        
        do {
            
            let data = try Data(contentsOf: url!)
            
            sharedImage.image = UIImage(data: data)
            
        } catch(let err as NSError) {
            print(err.description)
        }
        
       
        cityName.text = post.location
        
        profileImage.image = UIImage(named: post.image)
        
        likeBtn.tag = post.id
        
        likesCount.text = "\(post.likesCount)"
        
        if post.isOwner {
            
            self.editBtn.isHidden = false
            
        }
        
        else {
            
            self.editBtn.isHidden = true
        }
        
        
    }
    
    
    
    
}
