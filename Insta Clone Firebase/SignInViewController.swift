//
//  SignInViewController.swift
//  Insta Clone Firebase
//
//  Created by MAC-DIN-002 on 23/05/2019.
//  Copyright © 2019 MAC-DIN-002. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
   
    
    
    
    
    @IBAction func singInBtnClicked(_ sender: Any) {
        
        if emailText.text != nil && passwordText.text != nil{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert,animated: true, completion: nil)
                }else{
                    /*après avoir enregistré la connexion de l'utilisateur on lance la méthode de AppDelegate rememberLogin*/
                    UserDefaults.standard.set(user!.user.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberLogin()
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "incorrect email or password", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true, completion: nil)
        }
        
        
    }
    
    
    
    
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        
        
        if emailText.text != nil && passwordText.text != nil{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert,animated: true, completion: nil)
                }else{
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "incorrect email or password", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}
