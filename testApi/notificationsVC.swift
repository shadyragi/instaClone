//
//  notificationsVC.swift
//  testApi
//
//  Created by shady on 12/10/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit
import Alamofire

class notificationsVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    
    var notifications: [Notification] = [Notification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        
        tableview.dataSource = self
        
        getNotifications {
            
            self.tableview.reloadData()
        }

    }
    
    
    func getNotifications(completed: @escaping () -> ()) {
        
        Alamofire.request("http://localhost:8000/api/notifications", method: .get, parameters: ["id": User.shared.id], encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
            if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                
                if let notificationsObjects = dicit["notifications"] as? [Dictionary<String, AnyObject>] {
                    
                    for notificationData in notificationsObjects {
                        
                      
                        
                        if let data = notificationData["data"] as? [String: AnyObject] {
                            
                              var notification = Notification()
                            
                            notification.message = (data["message"] as? String)!
                            
                            notification.post = (data["post"] as? [String: AnyObject])!
                            
                            self.notifications.append(notification)
                            
                            
                        }
                        
                    }
                }
                
            }
            
            
            completed()
            
        }
        
    }
    

    

    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
   

}

extension notificationsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableview.dequeueReusableCell(withIdentifier: "notificationCell") as? notificationCell {
            
            let notif = notifications[indexPath.row]
            
            cell.updateCell(notif: notif)
            
            return cell
            
            
            
        }
        
        return UITableViewCell()
    }
}
