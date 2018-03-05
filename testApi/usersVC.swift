//
//  usersVC.swift
//  testApi
//
//  Created by shady on 12/3/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit
import Alamofire

class usersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    
    @IBOutlet weak var tableview: UITableView!
    
    var searchKey: String!
    
    var profiles: [Profile] = [Profile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        
        tableview.dataSource = self
        
        print(self.searchKey!)
        
        getUsersByName(completed:  {
            
            self.tableview.reloadData()
            
            print("count is \(self.profiles.count)")
            
        }, name: self.searchKey!)

        
    }
    
    func getUsersByName(completed: @escaping () -> (), name: String) {
        
        Alamofire.request("http://localhost:8000/api/user/\(name)", method: .get, parameters: ["id": User.shared.id], encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
            print(response.result)
            if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                
                if dicit["message"] as? String == "found" {
                    
                    if let users = dicit["users"] as? [Dictionary<String, AnyObject>] {
                        
                        for userData in users {
                            
                          var profile = Profile()
                            
                            profile.email = (userData["email"] as? String)!
                            
                            profile.id = (userData["id"] as? Int)!
                            
                            profile.name = (userData["name"] as? String)!
                            
                            profile.followed = (userData["followed"] as? Bool)!
                            
                            self.profiles.append(profile)
                            
                        }
                    }
                }
            }
            
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profiles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableview.dequeueReusableCell(withIdentifier: "searchCell") as? searchCell {
            
            if let profile = self.profiles[indexPath.row] as? Profile {
                
                cell.updateCell(user: profile)
                
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func followBtnPressed(_ sender: UIButton) {
        
        let params = ["profile_id": sender.tag]
        
        followUser(completed: {
            
            self.tableview.reloadData()
        
        }, params: params)
        
    }
    
    func followUser(completed: @escaping () -> (), params: [String: Int]) {
        let id = params["profile_id"]
        print("id is \(id)")
        Alamofire.request("http://localhost:8000/api/follow/\(id!)", method: .post, parameters: ["id": User.shared.id], encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
            print("follow response is \(response.result)")
            
            if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                
                if dicit["message"] as? String == "followed" {
                    
                    if let user = dicit["user"] as? Dictionary<String, AnyObject> {
                    
                    let index = self.profiles.index(where: {
                        
                        $0.name == user["name"] as? String
                    })
                        
                        self.profiles[index!].followed = true
                  }
                }
            }
            
            completed()
            
        }
    }
    
  

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
