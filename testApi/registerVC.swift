//
//  registerVC.swift
//  testApi
//
//  Created by shady on 11/27/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit
import Alamofire
class registerVC: UIViewController {

    @IBOutlet weak var namelbl: UITextField!
    @IBOutlet weak var emaillbl: UITextField!
    
    @IBOutlet weak var passwordlbl: UITextField!
    
    
    @IBOutlet weak var confirmpasswordlbl: UITextField!
    
    @IBOutlet weak var errorslbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        let params: [String: String] = ["name": namelbl.text!, "email": emaillbl.text!, "password": passwordlbl.text!, "password_confirmation": confirmpasswordlbl.text!]
        
        register(params: params, completed: { status in
            
            if status {
                
               self.performSegue(withIdentifier: "mainVC", sender: User.shared)
                
            } else {
                
                
            }
            
        });
        
        
    }
    
    func register(params: [String: String], completed: @escaping (_ success: Bool) -> ()) {
        
        Alamofire.request("http://localhost:8000/api/register", method: .post, parameters: params, encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
            print(response.result)
            if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                
                if let errors = dicit["errors"] as? Dictionary<String, [String]> {
                    
                    for error in errors {
                       
                        for message in error.value {
                            self.errorslbl.isHidden = false
                            
                           self.errorslbl.text = self.errorslbl.text! + "\(message)\n "
                            
                        }
                       
                    }
                    completed(false)
                  
                    
                }
                else {
                
                if  dicit["message"] as? String == "registered" {
                    
                    if let userData = dicit["user"] as? [String: AnyObject] {
                        
                        User.shared.email = (userData["email"] as? String)!
                        
                        User.shared.name = (userData["name"] as? String)!
                        
                        User.shared.id   = (userData["id"] as? Int)!
                        
                        completed(true)
                    }
                    
                   
                }
            
                }
            }
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? mainVC {
            
            if let user = sender as? User {
                
                dest.id = user.id
            }
        }
    }



}
