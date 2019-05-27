//
//  SecondViewController.swift
//  Insta Clone Firebase
//
//  Created by MAC-DIN-002 on 23/05/2019.
//  Copyright © 2019 MAC-DIN-002. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class UploadVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextView!
    var uuid = NSUUID().uuidString
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(UploadVC.choosePhoto))
        imageView.addGestureRecognizer(recognizer)
    }
    
    @IBAction func postBtnClicked(_ sender: Any) {
        let storage = Storage.storage()
        let mediaFolder = storage.reference().child("media")
        
        let riversRef = mediaFolder.child("\(uuid).jpg")
        
        if let data = imageView.image!.jpegData(compressionQuality: 0.75){
            riversRef.putData(data, metadata: nil) { (metadata,error) in
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okBtn)
                    self.present(alert,animated: true,completion: nil)
                }else{
                   riversRef.downloadURL(completion: { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    print(downloadURL)
                    
                    /*on créé un post contenant l'url de la photo le commentaire et qui l'a posté ainsi qu'un id */
                    let post = ["image" : downloadURL.absoluteString, "postedby" : Auth.auth().currentUser!.email!, "uuid" : self.uuid, "posttext" : self.commentText.text] as [String : Any]
                    
                   /*on met ça en base de donnée */ Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(post)
                    /*on vide les champ de upload*/
                       self.commentText.text = ""
                       self.imageView.image = UIImage(named: "TAPME.jpg")
                    /*on revient à l'onglet Feed*/
                       self.tabBarController?.selectedIndex = 0
                    
                   })
                }
            }
        }
        
    }
    @objc func choosePhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}

