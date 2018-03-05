//
//  mainVC.swift
//  testApi
//
//  Created by shady on 11/28/17.
//  Copyright © 2017 shady. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class mainVC: UIViewController, UINavigationControllerDelegate, UISearchBarDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var searchbar: UISearchBar!

    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    @IBOutlet weak var caption: UITextField!
    
    @IBOutlet weak var sharedimage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    var id: Int!
    
    var posts: [Post] = [Post]()
    
    var stories: [Story] = [Story]()
    
    var locationManager: CLLocationManager!
    
    var location: CLLocation!
    
    var city: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        
        imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        tableview.dataSource = self
        
        collectionview.delegate = self
        
        collectionview.dataSource = self
        
        searchbar.delegate = self
        
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
        
     
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        
        getPosts {
            self.tableview.reloadData()
        }
        
        getStories {
            self.collectionview.reloadData()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        performSegue(withIdentifier: "usersVC", sender: searchBar.text)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? usersVC {
            
            if let searchkey = sender as? String {
                
                dest.searchKey = searchkey
            }
        }
        
        else if let dest = segue.destination as? commentsVC {
            
            if let post = sender as? Post {
                
                dest.post = post
                
                
            }
        }
    }
    

    @IBAction func likePost(_ sender: UIButton) {
        
        addLike( completed: {
            self.tableview.reloadData()
        }, postId: sender.tag)
        
    }
   
    
    func addLike(completed: @escaping () -> (), postId: Int) {
        
        let post_id = postId
        
        let params = ["id": User.shared.id]
        
        Alamofire.request("http://localhost:8000/api/\(post_id)/like", method: .post, parameters: params, encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
            if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                
                if dicit["message"] as? String == "liked" {
                    
                    if let postData = dicit["post"] as? Dictionary<String, AnyObject> {
                        
                        let index = self.posts.index(where: {
                            $0.id == postData["id"] as? Int
                        })
                        
                        
                        self.posts[index!].likesCount += 1
                        
                        
                        
                    }
                }
                
            }
            
            completed()
        }
        
    }
    
    func getPosts(completed: @escaping () -> ()) {
        let params = ["id": self.id];
        
        Alamofire.request("http://localhost:8000/api/post", method: .get, parameters: params, encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
            if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                
                if let posts = dicit["posts"] as? [Dictionary<String, AnyObject>] {
                    
                    for data in posts {
                        
                       
                        var post =  Post(data: data as! [String: AnyObject]) 
            
                        
                        self.posts.append(post)
                        
                    }
                }
                
            }
            completed()
        }
    }
    
    @IBAction func addImagePressed(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    

    
    func isGpsAllowed() -> Bool {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            return true
        }
        
        return false
        
    }
    
    @IBAction func addPostPressed(_ sender: UIButton) {
       
        
        var params: [String: AnyObject] = ["caption": self.caption.text! as AnyObject, "id": "\(User.shared.id)" as AnyObject] as [String : AnyObject]
        
       
        
        
        if isGpsAllowed() {
            
            getLocation()
            
            
            params["location"] = self.city as? AnyObject
            
            
        }
        
        addPost(completed:  {
           self.tableview.reloadData()
        }, params: params as! [String: AnyObject])
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.location = locations.first
        
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(self.location) { (placemarks: [CLPlacemark]?, error: Error?) in
            
            print("closure")
           
            self.city = placemarks?.first?.locality
        }
        
    }
    
    
    func getLocation() {
        
        CLGeocoder().reverseGeocodeLocation(self.locationManager.location!) { (placemarks, error)  in
        
            print("closure")
        }
        
     
     
    }
    
    
    func getStories(completed: @escaping () -> ()) {
        
        
        Alamofire.request("http://localhost:8000/api/story", method: .get, parameters: ["id": User.shared.id], encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
          
            if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                
                if let stories = dicit["stories"] as? [Dictionary<String, AnyObject>] {
                    
                    
                    for storyData in stories {
                        
                        var story = Story(storyData: storyData as! [String: AnyObject])
                        
                        
                        self.stories.append(story)
                        
                    }
                    
                }
            }
         
            completed()
        }
        
    }
    
    func addPost(completed: @escaping () -> (), params: [String: AnyObject]) {
        
        
     
        Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
            
            if let data = UIImageJPEGRepresentation(self.sharedimage.image!, 0.5) {
                
                form.append(data, withName: "image", fileName: "photo.jpeg", mimeType: "image/jpeg")
                
                let caption = params["caption"] as? String
                
                let id = params["id"] as? String
                
                let city = params["location"] as? String
                
                form.append((caption?.data(using: .utf8))!, withName: "caption")
                
                form.append((city?.data(using: .utf8))!, withName: "location")
                
                form.append((id?.data(using: .utf8))!, withName: "id")
            }
            
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: "http://localhost:8000/api/post", method: .post, headers: nil) { (result: SessionManager.MultipartFormDataEncodingResult) in
            
            switch result {
            case .failure(let err):
                print("error is \(err)")
                break
                
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                
                upload.responseJSON { response in
                    
                    print(response.result)
                    print(response.result.value)
                    if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                        
                        if let data = dicit["post"] {
                            
                            var post = Post(data: data as! [String : AnyObject])
                            
                            self.posts.append(post)
                            
                        }
                        
                        
                    }
                    completed()
                }
                
                
                break
            }
        }
        
    }
    
    
 
    
    
    @IBAction func addStory(_ sender: UIButton) {
        
        addNewStory {
            print("story uploaded")
        }
        
    }
    
    
    func addNewStory(completed: @escaping () -> ()) {
        
        Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
            
            if let data = UIImageJPEGRepresentation(self.sharedimage.image!, 0.5) {
                
                form.append(data, withName: "image", fileName: "photo.jpeg", mimeType: "image/jpeg")
                
        
                
                let id = String(User.shared.id)
                
                
                form.append((id.data(using: .utf8))!, withName: "id")
            }
            
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: "http://localhost:8000/api/story", method: .post, headers: nil) { (result: SessionManager.MultipartFormDataEncodingResult) in
            
            switch result {
            case .failure(let err):
                print("error is \(err)")
                break
                
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                
                upload.responseJSON { response in
                    
                    print(response.result)
                    print(response.result.value)
                    if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                       
                        
                        if dicit["message"] as? String != "story Added" {
                            
                            print("error in uploading story")
                        }
                        
                        
                    }
                    completed()
                }
                
                
                break
            }
        
    }
   
    }
    
    
    
    @IBAction func editBtnPressed(_ sender: UIButton) {
        
        let cell: UITableViewCell = (sender.superview?.superview?.superview as? UITableViewCell!)!
        
        let index = tableview.indexPath(for: cell)
        
        let post = self.posts[(index?.row)!]
        
        
        
        let alertController = UIAlertController(title: "Options", message: "Choose Option", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: { (acting) in
            
            self.deletePost(post: post, completed: {
                
                self.posts.remove(at: (index?.row)!)
                
                self.tableview.reloadData()
            })
            
            
        })
        
        alertController.addAction(deleteAction)
        
        alertController.addAction(cancelAction)
    
        
        present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    func deletePost(post: Post, completed: @escaping () -> ()) {
        
        Alamofire.request("http://localhost:8000/api/post/\(post.id)", method: .delete, parameters: ["id": User.shared.id], encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
            if let dicit = response.result.value as? Dictionary<String, AnyObject> {
                
                if dicit["message"] as? String == "post Has Been Deleted Successfully" {
                    
                    print("success")
                }
                    
                else {
                    
                    print("failure")
                }
            }
            
            completed()
        }
        
    }
    
    
    @IBAction func viewCommentsPressed(_ sender: UIButton) {
        
        
        let cell: UITableViewCell
            = (sender.superview?.superview?.superview as? UITableViewCell)!
        
        
        
        let indexPath = tableview.indexPath(for: cell)
        
        performSegue(withIdentifier: "commentsVC", sender: self.posts[(indexPath?.row)!])
        
    }
    

}

extension mainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: "feedCell") as? feedCell {
            
            if self.posts.count > 0 {
                
                if let item = self.posts[indexPath.row] as? Post  {
                    
                    if item.isLiked == true {
                        cell.likeBtn.isHighlighted = true
                    }
                    
                    cell.updateCell(post: item)
                }
                
                return cell;
            }
            
        }
        return UITableViewCell()
    }
    
    
}

extension mainVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return stories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as? storyCell {
            
            let story = stories[indexPath.row]
            
            cell.updateCell(story: story)
            
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 109 , height: 92)
    }
    
    
}

extension mainVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.sharedimage.image = image
            
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
}


