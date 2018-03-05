//
//  ViewController.swift
//  testApi
//
//  Created by shady on 11/27/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
class ViewController: UIViewController {

    @IBOutlet weak var emaillbl: UITextField!
    
    @IBOutlet weak var passwordlbl: UITextField!
    
    @IBOutlet weak var errorlbl: UILabel!
    
    
   
    
    var location: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
      
        
        let email = emaillbl.text!
        let pwd   = passwordlbl.text!
      
        if email != " " && pwd != " " {
            
              print("login pressed")
            
            checkCredintials(completed: {
                
             //  self.performSegue(withIdentifier: "mainVC", sender: User.shared)
                
            }, email: email, pwd: pwd)
        }
        
    }
    
    func checkCredintials(completed: @escaping () -> (), email: String, pwd: String) {
        
        Alamofire.request("http://localhost:8000/api/checkCredentials", method: .get, parameters: ["email": email, "password": pwd], encoding: URLEncoding.queryString,
                          headers: nil).responseJSON { response in
            print(response.result)
            if let dicit = response.result.value as? Dictionary<String, AnyObject>
            {
                //print("inside")
                if (dicit["message"] as? String == "exist")  {
                    
                    self.errorlbl.isHidden = true;
                    
                    if let userData = dicit["user"] as? Dictionary<String, AnyObject> {
                        
                        User.shared.email = (userData["email"] as? String)!
                        
                        User.shared.name = (userData["name"] as? String)!
                        
                        User.shared.id   = (userData["id"] as? Int)!
                    }
                    
                    
                }
                else {
                    
                    self.errorlbl.isHidden = false;
                }
                //print(dicit["message"]!)
            }
            completed()
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
