//
//  commentsVC.swift
//  testApi
//
//  Created by shady on 12/4/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit

import Alamofire



class commentsVC: UIViewController, UITextFieldDelegate {
    
    var commentsObjects: [Comment] = [Comment]()
    
    var post: Post!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var commentField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentField.returnKeyType = UIReturnKeyType.done
        
        tableview.delegate = self
        
        tableview.dataSource = self
        
        commentField.delegate = self
        
        
        
        getComments {
            self.tableview.reloadData()
        }
    }
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true);
        
        return true;
    }
    
    
 
    
    
    func getComments(completed: @escaping () -> ()) {
        
        Alamofire.request("http://localhost:8000/api/\(post.id)/comment", method: .get, parameters: ["id": User.shared.id], encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
            if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                
                if let comments = dicit["comments"] as? [Dictionary<String, AnyObject>] {
                    
                    for commentData in comments {
                        
                        var comment = Comment(commentData: commentData as! [String: AnyObject])
                        
                        self.commentsObjects.append(comment)
                        
                    
                    }
                }
            }
         completed()
        }
    }
    

    

    @IBAction func postCommentPressed(_ sender: UIButton) {
        
        let params: [String: AnyObject] = ["id": User.shared.id as AnyObject, "comment": self.commentField.text! as AnyObject]
        
        postComment(completed: {
            
            self.tableview.reloadData()
            
        }, params: params)
        
        }
    
    
    func postComment(completed: @escaping () -> (), params: [String: AnyObject]) {
        
        Alamofire.request("http://localhost:8000/api/\(post.id)/comment", method: .post, parameters: params, encoding: URLEncoding.queryString, headers: nil)
            .responseJSON { response in
                
              
                
                if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                    
                    if dicit["message"] as? String == "comment added" {
                        
                        print("inside");
                        
                        if let commentData = dicit["comment"] as? Dictionary<String, AnyObject> {
                            
                            var comment = Comment(commentData: commentData)
                           
                            
                            self.commentsObjects.append(comment)
                            
                        }
                    }
                    
                }
                
                completed()
        }
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
      
        
        
        deleteComment(completed: {
            self.tableview.reloadData()
            
        }, params: ["comment_id": sender.tag])
        
        
        
        
    }
    
    func deleteComment(completed: @escaping () -> (), params: [String: Int]) {
        
        let comment_id = params["comment_id"]!
        
    
        
        
        Alamofire.request("http://localhost:8000/api/comment/\(comment_id)", method: .delete, parameters: ["id": User.shared.id], encoding: URLEncoding.queryString, headers: nil)
            .responseJSON { response in
                
                print(response.result)
                
                if let dicit = response.result.value as? [String: AnyObject] {
                    
                    if dicit["message"] as? String == "comment deleted" {
                        
                        let index = self.commentsObjects.index(where: {
                            $0.id == comment_id
                        })
                        
                        self.commentsObjects.remove(at: index!)
                        
                    }
                }
                completed()
                
        }
        
    }
    
    
    }


extension commentsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.commentsObjects.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableview.dequeueReusableCell(withIdentifier: "commentCell") as? commentCell {
            
            let comment = self.commentsObjects[indexPath.row]
            
            cell.updateCell(commentData: comment)
            
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    
}
   


