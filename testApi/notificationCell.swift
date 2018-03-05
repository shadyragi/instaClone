//
//  notificationCell.swift
//  testApi
//
//  Created by shady on 12/10/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit

class notificationCell: UITableViewCell {

    @IBOutlet weak var notificationMessage: UILabel!
    
    
    @IBOutlet weak var notificationImage: UIImageView!
    
    
    
    func updateCell(notif: Notification) {
        
        self.notificationMessage.text = notif.message
        
        let url = URL(string: "http://localhost:8000/\(notif.post["image"]!)")!
        
        
        do {
            
            let data = try Data(contentsOf: url)
            
            notificationImage.image = UIImage(data: data)
            
        } catch(let err as NSError) {
            
            print(err.description)
        }
    }
    
    

}
