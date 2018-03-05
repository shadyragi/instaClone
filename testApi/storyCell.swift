//
//  storyCell.swift
//  testApi
//
//  Created by shady on 12/7/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit

class storyCell: UICollectionViewCell {
    
    @IBOutlet weak var storyImage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    
    
    func updateCell(story: Story) {
        
        let url = URL(string: "http://localhost:8000/\(story.image)")
        
        do {
        
        let data = try Data(contentsOf: url!)
        
        self.storyImage.image = UIImage(data: data)
            
        } catch(let err as NSError) {
            
            print(err.description)
        }
        
        username.text = (story.user["name"] as? String)!
        
        
        
        
        
    }
}
