//
//  FirstViewController.swift
//  Insta Clone Firebase
//
//  Created by MAC-DIN-002 on 23/05/2019.
//  Copyright © 2019 MAC-DIN-002. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage


class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBAction func LogOutBtnClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        
        let signIn = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signIn
        
    }
    var useremailArray = [String]()
    var postCommentArray = [String]()
    var postImageURLArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        useremailArray.removeAll(keepingCapacity: false)
        postCommentArray.removeAll(keepingCapacity: false)
        postImageURLArray.removeAll(keepingCapacity: false)
        getDataFromFirbase()
    }

    /*retreive info from Firebase*/
    func getDataFromFirbase(){
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
            
            let values = snapshot.value! as! NSDictionary
            let post = values["post"] as! NSDictionary
            let postIDs = post.allKeys
            for id in postIDs {
                let singlePost = post[id] as! NSDictionary
                self.useremailArray.append(singlePost["postedby"] as! String)
                self.postCommentArray.append(singlePost["posttext"] as! String)
                self.postImageURLArray.append(singlePost["image"] as! String)
            }
            self.tableView.reloadData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useremailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.postComment.text = postCommentArray[indexPath.row]
        print(postCommentArray[indexPath.row])
        cell.postUserName.text = useremailArray[indexPath.row]
        cell.postImg.sd_setImage(with: URL(string: self.postImageURLArray[indexPath.row]), completed: nil)
        return cell
    }
    

}

