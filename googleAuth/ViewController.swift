//
//  ViewController.swift
//  googleAuth
//
//  Created by Kwame Agyenim - Boateng on 21/06/2021.


import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStyles()
    }

    func buttonStyles() {
        signUpButton.layer.cornerRadius = signUpButton.layer.frame.height / 2
        logoutButton.layer.cornerRadius = signUpButton.layer.frame.height / 2
    }

  

    @IBAction func signpUser(_ sender: Any) {
//        initialize signIn
        let config = GIDConfiguration(clientID: "1070451583338-gbiffro69gttrlrmlife5k9h5k1pvbhm.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard error == nil else {
                return
            }
            let idToken:String?
            guard let me = user else { return }
            guard let userId = me.userID else { return }
            idToken = me.authentication.idToken
            guard let fullName = me.profile?.name  else { return }
            guard let givenName = me.profile?.givenName  else { return }
            guard let familyName = me.profile?.familyName  else { return }
            guard let email = me.profile?.email  else { return }
            let user = [
                "userId":userId,
//                "idToken":idToken,
                "fullName":fullName,
                "givenName":givenName,
                "familyName":familyName,
                "email":email
            ]
            if (idToken?.isEmpty == false){
                let alert = UIAlertController(title: "Success", message: "Signed in", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(user)
            }
            
            
          

        }
    }
    
    @IBAction func logoutuser(_ sender: Any) {
        GIDSignIn.sharedInstance.signOut()
        let alert = UIAlertController(title: "Success", message: "Logout successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

